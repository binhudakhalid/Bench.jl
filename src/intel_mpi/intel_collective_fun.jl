
export bench1
function bench1(fun_name::String, task::String, path::String) # BenchBroadcast(), @__FILE__)
    @show task
    @show path

    if fun_name == "MPI_Allreduce"
        is_mpi_lib_is("intel")
        intel_all_reduce(task::String, path::String)

    elseif fun_name == "MPI_Bcast"
        is_mpi_lib_is("intel")
        intel_bcast(task::String, path::String)

    elseif fun_name == "MPI_Allgather"
        is_mpi_lib_is("intel")
        intel_all_gather()

    elseif fun_name == "MPI_Allgatherv"
        is_mpi_lib_is("intel")
        intel_all_gatherv()

    elseif fun_name == "MPI_Gather"
        is_mpi_lib_is("intel")
        intel_gather()

    elseif fun_name == "MPI_Gatherv"
        is_mpi_lib_is("intel")
        intel_gatherv()

    elseif fun_name == "MPI_Alltoall"
        is_mpi_lib_is("intel")
        intel_all_to_all()

    elseif fun_name == "MPI_Alltoallv"
        is_mpi_lib_is("intel")
        intel_all_to_allv()

    elseif fun_name == "MPI_Scatter"
        is_mpi_lib_is("intel")
        intel_scatter()

    elseif fun_name == "MPI_Scatterv"
        is_mpi_lib_is("intel")
        intel_scatterv()

    else
        println("unable to find the function name")
    end
end



# I_MPI_ADJUST_ALLREDUCE
function intel_all_reduce(task::String, path::String)

    task_name = task
    MPIBenchmarks_function_name = "OSUAllreduce" # this should the method name of MPIBenchmark.jl 
    #dic_of_algorithm = get_tuned_algorithm_from_intel("allreduce") # get_all_bcast_algorithm()
    @show dict_all_reduce_variant
    algorithm_name = "I_MPI_ADJUST_ALLREDUCE" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    # job_script_file_name = "I_MPI_ADJUST_ALLREDUCE" * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_all_reduce_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    #func(conf.T, 1, 10 , 3, dict_all_reduce_variant)
    write_job_script_file_intel(dict_all_reduce_variant, "I_MPI_ADJUST_ALLREDUCE", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)    
end


#   I_MPI_ADJUST_BCAST
function intel_bcast(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUBroadcast" # this should the method name of MPIBenchmark.jl 
    @show dict_all_reduce_variant
    algorithm_name = "I_MPI_ADJUST_BCAST" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_broadcast_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_broadcast_variant, "I_MPI_ADJUST_BCAST", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)
end

# I_MPI_ADJUST_ALLGATHER
function intel_all_gather()
    
end

# I_MPI_ADJUST_ALLGATHERV
function intel_all_gatherv()

end

# I_MPI_ADJUST_GATHER
function intel_gather()

end

# I_MPI_ADJUST_GATHERV
function intel_gatherv()

end

#I_MPI_ADJUST_ALLTOALL
function intel_all_to_all()

end

# I_MPI_ADJUST_ALLTOALLV	
function intel_all_to_allv()

end


# I_MPI_ADJUST_REDUCE
function intel_reduce()

end
# I_MPI_ADJUST_SCATTER
function intel_scatter()

end
# I_MPI_ADJUST_SCATTERV
function intel_scatterv()

end


function is_mpi_lib_is(name::String)

    return true
end

#=


task_name = task
MPIBenchmarks_function_name = "IMBAllreduce" # this should the method name of MPIBenchmark.jl 
#dic_of_algorithm = get_tuned_algorithm_from_intel("allreduce") # get_all_bcast_algorithm()
@show dict_all_reduce_variant
algorithm_name = "intel_allreduce_algorithm"
job_script_file_name = algorithm_name * "_" * "jobscript.sh"

BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_all_reduce_variant, algorithm_name, job_script_file_name, nothing)

mkdir(BenchData1.task_name)
func(conf.T, 1, 10 , 3, dict_all_reduce_variant)
write_job_script_file_intel(dict_all_reduce_variant, "I_MPI_ADJUST_ALLREDUCE", MPIBenchmarks_function_name, BenchData1)
write_graph_data(BenchData1)
#submit_sbatch(BenchData1)

=#
