mutable struct BenchData
    MPIBenchmarks_function_name::String
    dic_of_algorithm::Dict
    algorithm_name::String
    job_script_file_name::String
    julia_script_file_name_output_array::Union{Array, Nothing}
end

function run_collective(benchmark::MPIBenchmark, func::Function, conf::Configuration, path::String)

    # To run it requires
        #1- Path of the script that start the program
        #2- MPIBenchmarks_function_name
        #3- OpenMPI param bcast

    @show path
    #@show benchmark
    #@show conf

    #@show  @__DIR__
    #@show @__FILE__
    #@show PROGRAM_FILE 


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
        
        # MPIBenchmarks.jl: "OSUScatter"
        MPIBenchmarks_function_name = "OSUScatter"
        # OpenMPI:   "coll_tuned_scatter_algorithm"
        julia_script_file_name = MPIBenchmarks_function_name 


        dic_of_algorithm = get_tuned_algorithm_from_openmpi("scatter") # get_all_bcast_algorithm()
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        algo = "coll_tuned_scatter_algorithm"
        a = write_job_script_file(dic_of_algorithm, "coll_tuned_scatter_algorithm", MPIBenchmarks_function_name)
        #submit_sbatch(a)
 
    
    elseif  String(string(func)) == "imb_b_reduce"
        MPIBenchmarks_function_name = "OSUReduce"

        #else
        dic_of_algorithm = get_tuned_algorithm_from_openmpi("reduce") # get_all_bcast_algorithm()
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        algo = "coll_tuned_reduce_algorithm"
        a = write_job_script_file(dic_of_algorithm, "coll_tuned_reduce_algorithm", MPIBenchmarks_function_name)
        #submit_sbatch(a)

    elseif  String(string(func)) == "imb_b_gather"
        MPIBenchmarks_function_name = "OSUGather"

        #else
        dic_of_algorithm = get_tuned_algorithm_from_openmpi("gather") # get_all_bcast_algorithm()
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        algo = "coll_tuned_gather_algorithm"
        a = write_job_script_file(dic_of_algorithm, "coll_tuned_gather_algorithm", MPIBenchmarks_function_name)
        #submit_sbatch(a)
    
    elseif  String(string(func)) == "imb_b_allreduce"

        MPIBenchmarks_function_name = "OSUAllreduce"
        dic_of_algorithm = get_tuned_algorithm_from_openmpi("allreduce") # get_all_bcast_algorithm()
        algorithm_name = "coll_tuned_allreduce_algorithm"
        job_script_file_name = algorithm_name * "_" * "jobscript.sh"
        
        BenchData1 = BenchData(MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        a = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name)
        submit_sbatch(BenchData1.job_script_file_name)
        
        @show "****************"
        @show BenchData1
        @show "****************"

        ## Draw graph
        ## Draw praph

        #=
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        algo = "coll_tuned_allreduce_algorithm"
        a = write_job_script_file(dic_of_algorithm, algo, MPIBenchmarks_function_name)
        #submit_sbatch(a)=#





    end

    

    




    return nothing
end

function write_job_script_file(dict::Dict, coll_tuned_bcast_algorithm::String, MPIBenchmarks_function_name::String)

    line = ""
    julia_script_file_name_output_array = String[]

    #write julia benchmark file 
    for item in dict

        algo_name = replace(item.second , " " => "_")
        julia_script_file_name::String = coll_tuned_bcast_algorithm * "_" * algo_name * ".jl"
        julia_script_file_name_output = julia_script_file_name * ".csv"
        

        push!( julia_script_file_name_output_array,  julia_script_file_name_output  )
        
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

    @show "--------------------------------------"
    julia_script_file_name_output_array_string = string(julia_script_file_name_output_array)
    @show julia_script_file_name_output_array_string
    # Write graph data to a file
    open("graph_data" * ".txt", "w") do file
        write(file, julia_script_file_name_output_array_string)
    end

    return job_script_file_name
end

function submit_sbatch(jobscript_file_name::String)
    @show "Before calling sbatch" 
    @show jobscript_file_name
    run(`sbatch $(jobscript_file_name)`)
end

include("Bench_Bcast.jl")
include("Bench_Scatter.jl")
include("Bench_Reduce.jl")
include("Bench_Gather.jl")
include("Bench_Allreduce.jl")
include("Util.jl")
include("Graph.jl")
include("Bench_Graph.jl")
