
# OPEN MPI +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function openmpi_all_reduce(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    dic_of_algorithm = get_tuned_algorithm_from_openmpi("allreduce")
    
    MPIBenchmarks_function_name = "OSUAllreduce"
    algorithm_name = "coll_tuned_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)

    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_bcast(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("bcast") # get_all_bcast_algorithm()
    
    MPIBenchmarks_function_name = "OSUBroadcast"
    algorithm_name = "coll_tuned_bcast_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_all_to_all(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("alltoall")
    
    MPIBenchmarks_function_name = "OSUAlltoall"
    algorithm_name = "coll_tuned_alltoall_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_all_to_allv(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("alltoallv")
    
    MPIBenchmarks_function_name = "OSUAlltoallv"
    algorithm_name = "coll_tuned_alltoallv_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_all_gather(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("allgather")
    
    MPIBenchmarks_function_name = "OSUAllgather"
    algorithm_name = "coll_tuned_allgather_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_all_gatherv(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)

    dic_of_algorithm = get_tuned_algorithm_from_openmpi("allgatherv")
    
    MPIBenchmarks_function_name = "OSUAllgatherv"
    algorithm_name = "coll_tuned_allgatherv_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_scatter(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)
        
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("scatter")
    
    MPIBenchmarks_function_name = "OSUScatter"
    algorithm_name = "coll_tuned_scatter_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_reduce(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("reduce")
    
    MPIBenchmarks_function_name = "OSUReduce"
    algorithm_name = "coll_tuned_reduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_gather(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String, slurm_config::String, number_of_julia_process::Int)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("gather")
    
    MPIBenchmarks_function_name = "OSUGather"
    algorithm_name = "coll_tuned_gather_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub, slurm_config, number_of_julia_process)
    write_graph_data(BenchData1)
    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end
