function run_collective(benchmark::MPIBenchmark, func::Function, conf::Configuration)



    if String(string(func)) == "imb_b_bcast"

        # MPIBenchmarks.jl: "OSUBroadcast"
        MPIBenchmarks_function_name = "OSUBroadcast"
        # OpenMPI:   "bcast"
        julia_script_file_name = MPIBenchmarks_function_name 


        dic_of_algorithm = get_tuned_algorithm_from_openmpi("bcast") # get_all_bcast_algorithm()
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        algo = "coll_tuned_bcast_algorithm"
        a = write_job_script_file(dic_of_algorithm, "coll_tuned_bcast_algorithm", MPIBenchmarks_function_name)
        #submit_sbatch(a)



        #rray1 = ["coll_tuned_bcast_algorithm_ignore.jl.csv", "coll_tuned_bcast_algorithm_knomial_tree.jl.csv"]

        str1 = "coll_tuned_bcast_algorithm_ignore.jl.csv,coll_tuned_bcast_algorithm_knomial_tree.jl.csv"
        open("graphDB.csv", "w") do file
            write(file, str1)
        end


        ##plot_bench("bcast"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf), Array1)

    elseif  String(string(func)) == "imb_b_scatter"
        #dic_of_algorithm = get_tuned_algorithm_from_openmpi("scatter") # get_all_bcast_algorithm()
        #func(conf.T, 1, 10 , 3, dic_of_algorithm)
    else
        dic_of_algorithm = get_tuned_algorithm_from_openmpi("bcast") # get_all_bcast_algorithm()
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        
    end

    




    return nothing
end

function write_job_script_file(dict::Dict, coll_tuned_bcast_algorithm::String, MPIBenchmarks_function_name::String)

    line = ""

    #write julia benchmark file 
    for item in dict

        algo_name = replace(item.second , " " => "_")
        julia_script_file_name = coll_tuned_bcast_algorithm * "_" * algo_name * ".jl"
        julia_script_file_name_output = julia_script_file_name * ".csv"

        
        file_name = "bcast_algo_" * algo_name * ".jl"


        julia_benchmark_script = """
        using MPIBenchmarks
        benchmark($(MPIBenchmarks_function_name)(;filename="$julia_script_file_name_output"))
        """
        open(julia_script_file_name, "w") do file
            write(file, julia_benchmark_script)
        end

        line = line * "mpiexec  --mca mpi_show_mca_params all --mca coll_tuned_use_dynamic_rules true --mca $(coll_tuned_bcast_algorithm) $(item.first) -np 4 julia --project $(julia_script_file_name) \n"

    end
    

    job_script_file_name = coll_tuned_bcast_algorithm * "_" * "jobscript.sh"
    job_script_file_content = string(initial_part, line)
 
    # Write job script file
    open(job_script_file_name, "w") do file
        write(file, job_script_file_content)
    end

    return job_script_file_name
end

function submit_sbatch(jobscript_file_name::String)

    @show "Before calling sbatch" 
    run(`sbatch $(jobscript_file_name)`)


end

include("Bench_Bcast.jl")
include("Util.jl")
include("Graph.jl")
include("Bench_Graph.jl")

