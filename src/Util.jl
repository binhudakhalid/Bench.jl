mutable struct BenchData
    task_name::String
    MPIBenchmarks_function_name::String
    dic_of_algorithm::Dict
    algorithm_name::String
    job_script_file_name::String
    julia_script_file_name_output_array::Union{Array, Nothing}
end

initial_part = """
#!/bin/bash
##SBATCH -q express
#SBATCH -J JuliaBenchMark
#SBATCH -A hpc-prf-mpibj
#SBATCH -p normal
#SBATCH -N 4                       ## [NUMBER_OF_NODE]
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=64      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
#SBATCH --exclusive
#SBATCH -t 40:40:00

###module reset
###module load lang       # loading the gateway module
###module load JuliaHPC   # loading the latest JuliaHPC
"""

# function to get the different algo of collective fuction on MPI
# Return a dictionary 
function get_tuned_algorithm_from_openmpi(function_name::String)
    dic_of_algorithm = Dict()
    
    string_output = read(pipeline(`ompi_info --param coll tuned -l 9`, `grep " $(function_name) algorith"`), String)

    @show string_output

    start = findfirst("Can be locked down to choice of:", string_output)
    if start === nothing
        start = findfirst("Can be locked down to any of:", string_output)
    end

    end1 = findfirst(". Only relevant", string_output)

    r = string_output[start[end]+1:end1[1]-1]
    
    list = split(r, "," )
    for item in list
        temp = chop(item, head = 1, tail = 0)
        tempList = split(temp, " "; limit = 2 )
        #dic_of_algoritm[]
        #dd = replace(tempList[1], ":" => "")
        key = replace(tempList[1], r"[: ]" => "", ".jl.csv" => "")
        key = match(r"\d+", key).match

        value = replace(tempList[2], ")" => "", "(" => "", " " => "_", "+"=>"plus")

        dic_of_algorithm[key] = value
    end
    

    return dic_of_algorithm

end
 
function write_job_script_file(dict::Dict, coll_tuned_bcast_algorithm::String, MPIBenchmarks_function_name::String, benchData::BenchData, add_header::Bool, sub_directory::String, slurm_config::String, number_of_julia_process::Int)

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
        benchmark($(MPIBenchmarks_function_name)(Int8; filename="$julia_script_file_name_output"))
        """
        open(benchData.task_name*"/"* julia_script_file_name, "w") do file
            write(file, julia_benchmark_script)
        end
        if sub_directory == ""
            line = line * "mpiexec  --mca mpi_show_mca_params all --mca coll_tuned_use_dynamic_rules true --mca $(coll_tuned_bcast_algorithm) $(item.first) -np $(number_of_julia_process) julia --project $(julia_script_file_name) \n"
        else
            line = line * "mpiexec  --mca mpi_show_mca_params all --mca coll_tuned_use_dynamic_rules true --mca $(coll_tuned_bcast_algorithm) $(item.first) -np $(number_of_julia_process) julia --project " *"./" * "$sub_directory" *"/"*"$(julia_script_file_name) \n"
        end
    end
    
    job_script_file_name = coll_tuned_bcast_algorithm * "_" * "jobscript.sh"

    if slurm_config != ""
        initial_part = slurm_config
    end

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

function write_job_script_file_intel(dict::Dict, function_name::String, MPIBenchmarks_function_name::String, benchData::BenchData , add_header::Bool, sub_directory::String, slurm_config::String, number_of_julia_process::Int)
    @show "collectice.jl -> write_job_script_file_intel"
    # I_MPI_ADJUST_ALLREDUCE
    line = ""
    julia_script_file_name_output_array = String[]
    #write julia benchmark file 
    for item in dict

        algo_name = replace(item.second , " " => "_")
        julia_script_file_name::String = function_name * "_" * algo_name * ".jl"

        if sub_directory == ""
            julia_script_file_name_output = julia_script_file_name * ".csv"
        else
            julia_script_file_name_output = sub_directory * "/"* julia_script_file_name * ".csv"
        end
        
        push!( julia_script_file_name_output_array,  julia_script_file_name_output)
        
        julia_benchmark_script = """
        using MPIBenchmarks
        benchmark($(MPIBenchmarks_function_name)(Int8; filename="$julia_script_file_name_output"))
        """
        open(benchData.task_name*"/"* julia_script_file_name, "w") do file
            write(file, julia_benchmark_script)
        end
        if sub_directory == ""
            line = line * "mpiexec -genv I_MPI_DEBUG=6 -genv $(function_name)=$(item.first) -np $(number_of_julia_process) julia --project $(julia_script_file_name) \n"
        else
            line = line * "mpiexec -genv I_MPI_DEBUG=6 -genv $(function_name)=$(item.first) -np $(number_of_julia_process) julia --project  " *"./" * "$sub_directory" *"/"*"$(julia_script_file_name) \n"
        end
    end
    

    job_script_file_name = function_name * "_" * "jobscript.sh"

    if slurm_config != ""
        initial_part = slurm_config
    end

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
    
    @show "collectice.jl -> write_job_script_file_intel return "
    return job_script_file_content
end

function submit_sbatch(benchData::BenchData)
    @show "collectice.jl->Before calling sbatch" 
    cd(benchData.task_name) do
        run(`sbatch $(benchData.job_script_file_name)`)
    end
end

function write_graph_data(benchData::BenchData)

    julia_script_file_name_output_array_string = string(benchData.julia_script_file_name_output_array)
    # Write graph data to a file
    open("$(benchData.task_name)/graph_data45" * ".txt", "w") do file
        #write(file, julia_script_file_name_output_array_string)
        write(file, benchData.MPIBenchmarks_function_name)
    end
end


# chart
include("graph/BarChart.jl")
include("graph/LineGraph.jl") 

#intel
include("intel_mpi/intel_collective_variants.jl")
include("intel_mpi/intel_collective_fun.jl")
include("test/atomatic_test.jl")
include("test/atomatic_test_calculation.jl")
