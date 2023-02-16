export bench1

# I_MPI_ADJUST_ALLREDUCE
function intel_all_reduce(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUAllreduce" # this should the method name of MPIBenchmark.jl 
    #dic_of_algorithm = get_tuned_algorithm_from_intel("allreduce") # get_all_bcast_algorithm()
    algorithm_name = "I_MPI_ADJUST_ALLREDUCE" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    # job_script_file_name = "I_MPI_ADJUST_ALLREDUCE" * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_all_reduce_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    #func(conf.T, 1, 10 , 3, dict_all_reduce_variant)
    job_script_file_cont = write_job_script_file_intel(dict_all_reduce_variant, "I_MPI_ADJUST_ALLREDUCE", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont    
end


#   I_MPI_ADJUST_BCAST
function intel_bcast(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUBroadcast" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_BCAST" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_broadcast_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_broadcast_variant, "I_MPI_ADJUST_BCAST", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)

    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  
end

# I_MPI_ADJUST_ALLGATHER
function intel_all_gather(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUAllgather" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_ALLGATHER" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_all_gather_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_all_gather_variant, "I_MPI_ADJUST_ALLGATHER", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)

    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  
end

# I_MPI_ADJUST_ALLGATHERV
function intel_all_gatherv(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUAllgatherv" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_ALLGATHERV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_all_gatherv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_all_gatherv_variant, "I_MPI_ADJUST_ALLGATHERV", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)

    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  
end

# I_MPI_ADJUST_GATHER
function intel_gather(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUGather" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_GATHER" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_gather_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_gather_variant, "I_MPI_ADJUST_GATHER", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)

    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  

end

# I_MPI_ADJUST_GATHERV
function intel_gatherv(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUGatherv" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_GATHERV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_gatherv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_gatherv_variant, "I_MPI_ADJUST_GATHERV", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  
end

#I_MPI_ADJUST_ALLTOALL
function intel_all_to_all(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUAlltoall" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_ALLTOALL" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_allToall_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_allToall_variant, "I_MPI_ADJUST_ALLTOALL", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  
end

# I_MPI_ADJUST_ALLTOALLV	
function intel_all_to_allv(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUAlltoallv" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_ALLTOALLV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_allToallv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_allToallv_variant, "I_MPI_ADJUST_ALLTOALLV", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  
end


# I_MPI_ADJUST_REDUCE
function intel_reduce(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUReduce" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_REDUCE" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_reduce_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_reduce_variant, "I_MPI_ADJUST_REDUCE", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  

end
# I_MPI_ADJUST_SCATTER
function intel_scatter(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUScatter" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_SCATTER" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_scatter_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_scatter_variant, "I_MPI_ADJUST_SCATTER", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  

end
# I_MPI_ADJUST_SCATTERV
function intel_scatterv(task::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    task_name = task
    MPIBenchmarks_function_name = "OSUScatterv" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_SCATTERV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_scatterv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file_intel(dict_scatterv_variant, "I_MPI_ADJUST_SCATTERV", MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end

    return job_script_file_cont  

end

function is_mpi_lib_is(name::String)

    #using MPI
    #impl, version = MPI.identify_implementation()

    #if name == impl #"IntelMPI"
    #    return true
    #else
    #    return false
    #end
    #println("asdasdasdads")
    #println("THe:: ", impl)
    #println("THe:: ", version)


    return false
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

export change_version

# OpenMPI
# mpi/OpenMPI/4.1.4-GCC-11.3.0
# mpi/OpenMPI/4.1.2-GCC-11.2.0

# IntelMPI
# mpi/impi/2021.6.0-intel-compilers-2022.1.0
# mpi/impi/2021.5.0-intel-compilers-2022.0.1

function change_version() # BenchBroadcast(), @__FILE__)
   
    run(`rm -r /upb/departments/pc2/groups/hpc-prf-mpibj/khalids/.julia/compiled/v1.8/MPI`) # remember the backticks ``
    run(`ml reset`)
    run(`ml lang`)
    run(`ml JuliaHPC`)
    run(`ml mpi/OpenMPI/4.1.4-GCC-11.3.0`)
    run(`julia setMPI_jl_version.jl`)

    MPIPreferences.use_system_binary()

    impl, version = MPI.identify_implementation()
    println(impl)
    println(version)

end
