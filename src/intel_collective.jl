mutable struct BenchData
    task_name::String
    MPIBenchmarks_function_name::String
    dic_of_algorithm::Dict
    algorithm_name::String
    job_script_file_name::String
    julia_script_file_name_output_array::Union{Array, Nothing}
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
        benchmark($(MPIBenchmarks_function_name)(Int8; max_size=2097152, filename="$julia_script_file_name_output"))
        """
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
 
    benchData.algorithm_name="a009"


end

