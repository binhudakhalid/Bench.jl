export test_across_libraries


function test_across_libraries(fun_name::String, task::String, path::String, openMPI::Array, intelMPI::Array)

    @show "fun_name"
    @show task
    @show path
    dics = Dict{String, String}()

    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = t_openmpi_all_reduce(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory);
        dics[sub_mpi_directory] = out
    end


    


end




function t_openmpi_all_reduce(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String)

    @show "-------------------"
    @show task_name
    @show path
    @show "-------------------"

    dic_of_algorithm = get_tuned_algorithm_from_openmpi("allreduce")
    
    MPIBenchmarks_function_name = "OSUAllreduce"
    algorithm_name = "coll_tuned_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = t_openMPI_write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub)
    write_graph_data(BenchData1)
    @show "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
    @show BenchData1
    @show "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"

    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end







function t_openMPI_write_job_script_file(dict::Dict, coll_tuned_bcast_algorithm::String, MPIBenchmarks_function_name::String, benchData::BenchData, add_header::Bool, sub_directory::String)

    line = ""
    julia_script_file_name_output_array = String[]
    #write julia benchmark file 
    for item in dict

        algo_name = replace(item.second , " " => "_")
        julia_script_file_name::String = coll_tuned_bcast_algorithm * "_" * algo_name * ".jl"

        if sub_directory == ""
            julia_script_file_name_output = julia_script_file_name * ".csv"
        else
            julia_script_file_name_output = sub_directory * "/"* julia_script_file_name * ".csv"
        end
        

        push!( julia_script_file_name_output_array,  julia_script_file_name_output  )
        
        file_name = "bcast_algo_" * algo_name * ".jl"


        julia_benchmark_script = """
        using MPIBenchmarks
        benchmark($(MPIBenchmarks_function_name)(Int8; max_size=2097152, filename="$julia_script_file_name_output"))
        """
        @show "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
        open(benchData.task_name*"/"* julia_script_file_name, "w") do file
            write(file, julia_benchmark_script)
        end
        if sub_directory == ""
            line = line * "mpiexec  --mca mpi_show_mca_params all --mca coll_tuned_use_dynamic_rules true --mca $(coll_tuned_bcast_algorithm) $(item.first) -np 4 julia --project $(julia_script_file_name) \n"
        else
            line = line * "mpiexec  --mca mpi_show_mca_params all --mca coll_tuned_use_dynamic_rules true --mca $(coll_tuned_bcast_algorithm) $(item.first) -np 4 julia --project " *"./" * "$sub_directory" *"/"*"$(julia_script_file_name) \n"
        end
        

    end
    

    job_script_file_name = coll_tuned_bcast_algorithm * "_" * "jobscript.sh"

    @show initial_part
    @show line
    if add_header
        job_script_file_content = string(initial_part, line)
    else
        job_script_file_content = line
    end
 
    # Write job script file
    open(benchData.task_name * "/" * job_script_file_name, "w") do file
        write(file, job_script_file_content)
    end

    benchData.julia_script_file_name_output_array = julia_script_file_name_output_array


    return job_script_file_content
end
