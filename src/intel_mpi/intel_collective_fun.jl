
export bench1
#using MPIPreferences
using MPI
function bench1(fun_name::String, task::String, path::String, lib::String) # BenchBroadcast(), @__FILE__)
    @show task
    @show path
    
        #if is_mpi_lib_is("intel")
        #    intel_all_reduce(task::String, path::String)
        #else
        #end
    sumbit_job = true
    add_header = true

    if fun_name == "MPI_Allreduce" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_all_reduce(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Bcast" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_bcast(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Allgather" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_all_gather(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Allgatherv" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_all_gatherv(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Gather" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_gather(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Gatherv" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_gatherv(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Alltoall" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_all_to_all(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Alltoallv" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_all_to_allv(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Reduce" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_reduce(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Scatter" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_scatter(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Scatterv" && lib == "IntelMPI"
        is_mpi_lib_is("IntelMPI") == true ? intel_scatterv(task::String, path::String) : throw(ErrorException("IntelMPI library is not configured with MPI.jl"))
    
    # OPEN MPI

    elseif fun_name == "MPI_Allreduce" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_reduce(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Bcast" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_bcast(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Alltoall" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_to_all(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Alltoallv" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_to_allv(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Allgather" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_gather(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Allgatherv" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_gatherv(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Scatter" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_scatter(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Reduce" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_reduce(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Gather" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_gather(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))

    #elseif fun_name == "MPI_Gatherv" && lib == "OpenMPI"
    #    is_mpi_lib_is("OpenMPI") == true ? openmpi_gatherv(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    #elseif fun_name == "MPI_Scatterv" && lib == "OpenMPI"
    #    is_mpi_lib_is("OpenMPI") == true ? openmpi_scatterv(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))


    
    else
        println("unable to find the function name")
    end
end



# I_MPI_ADJUST_ALLREDUCE
function intel_all_reduce(task::String, path::String)

    @show task
    @show path
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
function intel_all_gather(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUAllgather" # this should the method name of MPIBenchmark.jl 
    @show dict_all_reduce_variant
    algorithm_name = "I_MPI_ADJUST_ALLGATHER" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_all_gather_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_all_gather_variant, "I_MPI_ADJUST_ALLGATHER", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)
end

# I_MPI_ADJUST_ALLGATHERV
function intel_all_gatherv(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUAllgatherv" # this should the method name of MPIBenchmark.jl 
    @show dict_all_reduce_variant
    algorithm_name = "I_MPI_ADJUST_ALLGATHERV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_all_gatherv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_all_gatherv_variant, "I_MPI_ADJUST_ALLGATHERV", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)
end

# I_MPI_ADJUST_GATHER
function intel_gather(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUGather" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_GATHER" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_gather_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_gather_variant, "I_MPI_ADJUST_GATHER", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)

end

# I_MPI_ADJUST_GATHERV
function intel_gatherv(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUGatherv" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_GATHERV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_gatherv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_gatherv_variant, "I_MPI_ADJUST_GATHERV", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)
end

#I_MPI_ADJUST_ALLTOALL
function intel_all_to_all(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUAlltoall" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_ALLTOALL" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_allToall_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_allToall_variant, "I_MPI_ADJUST_ALLTOALL", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)
end

# I_MPI_ADJUST_ALLTOALLV	
function intel_all_to_allv(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUAlltoallv" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_ALLTOALLV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_allToallv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_allToallv_variant, "I_MPI_ADJUST_ALLTOALLV", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)
end


# I_MPI_ADJUST_REDUCE
function intel_reduce(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUReduce" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_REDUCE" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_reduce_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_reduce_variant, "I_MPI_ADJUST_REDUCE", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)

end
# I_MPI_ADJUST_SCATTER
function intel_scatter(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUScatter" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_SCATTER" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_scatter_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_scatter_variant, "I_MPI_ADJUST_SCATTER", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)

end
# I_MPI_ADJUST_SCATTERV
function intel_scatterv(task::String, path::String)
    task_name = task
    MPIBenchmarks_function_name = "OSUScatterv" # this should the method name of MPIBenchmark.jl 
    algorithm_name = "I_MPI_ADJUST_SCATTERV" # "intel_allreduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"
    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name, dict_scatterv_variant, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file_intel(dict_scatterv_variant, "I_MPI_ADJUST_SCATTERV", MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    write_graph_data(BenchData1)

end



# OPEN MPI +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function openmpi_all_reduce(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String)

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
    job_script_file_cont = write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1, add_header, sub)
    write_graph_data(BenchData1)
    @show "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
    @show BenchData1
    @show "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"

    if sumbit_job
        submit_sbatch(BenchData1)
    end
    return job_script_file_cont
end

function openmpi_bcast(task_name::String, path::String)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("bcast") # get_all_bcast_algorithm()
    
    MPIBenchmarks_function_name = "OSUBroadcast"
    algorithm_name = "coll_tuned_bcast_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    

end

function openmpi_all_to_all(task_name::String, path::String)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("alltoall")
    
    MPIBenchmarks_function_name = "OSUAlltoall"
    algorithm_name = "coll_tuned_alltoall_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    

end
function openmpi_all_to_allv(task_name::String, path::String)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("alltoallv")
    
    MPIBenchmarks_function_name = "OSUAlltoallv"
    algorithm_name = "coll_tuned_alltoallv_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    
end

function openmpi_all_gather(task_name::String, path::String)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("allgather")
    
    MPIBenchmarks_function_name = "OSUAllgather"
    algorithm_name = "coll_tuned_allgather_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    

end

function openmpi_all_gatherv(task_name::String, path::String)

    dic_of_algorithm = get_tuned_algorithm_from_openmpi("allgatherv")
    
    MPIBenchmarks_function_name = "OSUAllgatherv"
    algorithm_name = "coll_tuned_allgatherv_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
end

function openmpi_scatter(task_name::String, path::String)
    
    
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("scatter")
    
    MPIBenchmarks_function_name = "OSUScatter"
    algorithm_name = "coll_tuned_scatter_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    

end

function openmpi_reduce(task_name::String, path::String)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("reduce")
    
    MPIBenchmarks_function_name = "OSUReduce"
    algorithm_name = "coll_tuned_reduce_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)
    

end

function openmpi_gather(task_name::String, path::String)
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("gather")
    
    MPIBenchmarks_function_name = "OSUGather"
    algorithm_name = "coll_tuned_gather_algorithm"
    job_script_file_name = algorithm_name * "_" * "jobscript.sh"

    BenchData1 = BenchData(task_name, MPIBenchmarks_function_name,dic_of_algorithm, algorithm_name, job_script_file_name, nothing)

    mkdir(BenchData1.task_name)
    write_job_script_file(dic_of_algorithm, BenchData1.algorithm_name, MPIBenchmarks_function_name, BenchData1)
    write_graph_data(BenchData1)
    submit_sbatch(BenchData1)

end

function is_mpi_lib_is(name::String)

    #using MPI
    impl, version = MPI.identify_implementation()

    if name == impl #"IntelMPI"
        return true
    else
        return false
    end
    #println("asdasdasdads")
    println("THe:: ", impl)
    println("THe:: ", version)


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
