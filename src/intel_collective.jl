mutable struct BenchData
    task_name::String
    MPIBenchmarks_function_name::String
    dic_of_algorithm::Dict
    algorithm_name::String
    job_script_file_name::String
    julia_script_file_name_output_array::Union{Array, Nothing}
end

function run_collective_intel(benchmark::MPIBenchmark, func::Function, conf::Configuration, path::String)

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
 
    
    elseif  String(string(func)) == "imb_b_allreduce"

        task_name = "task0016" 
        MPIBenchmarks_function_name = "OSUAllreduce"
        dic_of_algorithm = get_tuned_algorithm_from_openmpi("allreduce") # get_all_bcast_algorithm()
        algorithm_name = "coll_tuned_allreduce_algorithm"
        job_script_file_name = algorithm_name * "_" * "jobscript.sh"
        
        BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)


        mkdir(BenchData1.task_name)
        func(conf.T, 1, 10 , 3, dic_of_algorithm)
        a = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
        write_graph_data(BenchData1)
        
        #write_graph_data_c(BenchData1)

        @show "*****mememe***********"
        @show BenchData1
        @show "******after**********"
        @show ")))))))))))))))))))))))))))))))"
        @show BenchData1.job_script_file_name
        @show ")))))))))))))))))))))))))))))))"
        submit_sbatch(BenchData1)

        #write_graph_data_c(BenchData1)
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

function write_job_script_file(dict::Dict, coll_tuned_bcast_algorithm::String, MPIBenchmarks_function_name::String, benchData::BenchData )

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
        @show "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
        open(benchData.task_name*"/"* julia_script_file_name, "w") do file
            write(file, julia_benchmark_script)
        end

        line = line * "mpiexec  --mca mpi_show_mca_params all --mca coll_tuned_use_dynamic_rules true --mca $(coll_tuned_bcast_algorithm) $(item.first) -np 4 julia --project $(julia_script_file_name) \n"

    end
    

    job_script_file_name = coll_tuned_bcast_algorithm * "_" * "jobscript.sh"
    job_script_file_content = string(initial_part, line)
 
    # Write job script file
    open(benchData.task_name * "/" * job_script_file_name, "w") do file
        write(file, job_script_file_content)
    end

    benchData.julia_script_file_name_output_array = julia_script_file_name_output_array


    return job_script_file_name
end

function submit_sbatch(benchData::BenchData)

    
    @show "Before calling sbatch" 

    #@show "$(benchData.task_name)/$(benchData.job_script_file_name)"
    #cd("$(benchData.task_name)")
    #run(`sbatch $(benchData.task_name)/$(benchData.job_script_file_name)`)

    cd("task0016/") do
        run(`sbatch $(benchData.job_script_file_name)`)
    end



end

function write_graph_data(benchData::BenchData)
    julia_script_file_name_output_array_string = string(benchData.julia_script_file_name_output_array)
    @show julia_script_file_name_output_array_string
    # Write graph data to a file
    open("graph_data3" * ".txt", "w") do file
        write(file, julia_script_file_name_output_array_string)
    end


end
function write_graph_data_c(benchData::BenchData)
 
    @show benchData.algorithm_name="a009"


end

