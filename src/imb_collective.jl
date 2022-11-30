function run_collective(benchmark::MPIBenchmark, func::Function, conf::Configuration)


    if String(string(func)) == "imb_b_bcast"
        dic_of_algorithm = get_tuned_algorithm_from_openmpi("bcast") # get_all_bcast_algorithm()
        func(conf.T, 1, 10 , 3, dic_of_algorithm)

        algo = "coll_tuned_bcast_algorithm"
        write_job_script_file(dic_of_algorithm, "coll_tuned_bcast_algorithm")
        write_julia_script(dic_of_algorithm, "Bcast")

    elseif  String(string(func)) == "imb_b_scatter"
        dic_of_algorithm = get_tuned_algorithm_from_openmpi("scatter") # get_all_bcast_algorithm()
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
    end

  




    return nothing
end

function write_job_script_file(dict::Dict, coll_tuned_bcast_algorithm::String)
    
    initial_part = """
    #!/bin/bash
    #SBATCH -q express
    #SBATCH -J JuliaBenchMark
    #SBATCH -A hpc-prf-mpibj
    ##SBATCH -p hpc-prf-mpibj
    #SBATCH -N 1			 ## [NUMBER_OF_NODE]
    #SBATCH --cpus-per-task=1
    #SBATCH --ntasks-per-node=4      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
    #SBATCH --mem-per-cpu 10G         ## [Memory per CPU]  - A node have many CPUs
    #SBATCH -t 00:30:00
    s
    module reset
    module load lang       # loading the gateway module
    module load JuliaHPC   # loading the latest JuliaHPC

    """

    middle_part = ""
    line = ""
    @show dict
    for item in dict
        @show item.first
        @show item.second
        line = line * "mpiexec  --mca mpi_show_mca_params all --mca coll_tuned_use_dynamic_rules true --mca $(coll_tuned_bcast_algorithm) $(item.first) -np 4 julia --project base.jl \n"
    end

    final_string = string(initial_part, line)

    job_script_file_name = coll_tuned_bcast_algorithm * "_" * "jobscript.sh"
    # Write job script file
    open(job_script_file_name, "w") do file
        write(file, final_string)
    end
end

function write_julia_script(dict::Dict, algo_name::String)

        #write julia benchmark file 
        for item in dict
            algo_name = replace(item.second , " " => "_")
            file_name = "bcast_algo_" * algo_name * ".jl"
            julia_benchmark_script = """
            using MPIBenchmarks
            benchmark(OSUReduce(;filename="$file_name"))
            """
            open(file_name, "w") do file
                write(file, julia_benchmark_script)
            end
        end

    #run(`whoami`)
    #read(` julia s.jl`, String)
    ##run(`./d.sh `)

end

include("Bench_Bcast.jl")
include("Util.jl")
