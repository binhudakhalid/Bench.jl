function bench1(fun_name::String, task::String, path::String, lib::String, slurm_config::String, number_of_julia_process::Int ) # BenchBroadcast(), @__FILE__)
    @show task
    @show path
    
        #if is_mpi_lib_is("intel")
        #    intel_all_reduce(task::String, path::String)
        #else
        #end
    sumbit_job = false
    add_header = true
    julia_ouput_directory = ""
    #number_of_julia_process = 4

    if fun_name == "MPI_Allreduce" && lib == "IntelMPI"
        intel_all_reduce(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Bcast" && lib == "IntelMPI"
        intel_bcast(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Allgather" && lib == "IntelMPI"
        intel_all_gather(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Allgatherv" && lib == "IntelMPI"
        intel_all_gatherv(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int) 
    elseif fun_name == "MPI_Gather" && lib == "IntelMPI"
        intel_gather(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Gatherv" && lib == "IntelMPI"
        intel_gatherv(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Alltoall" && lib == "IntelMPI"
        intel_all_to_all(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int) 
    elseif fun_name == "MPI_Alltoallv" && lib == "IntelMPI"
        intel_all_to_allv(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Reduce" && lib == "IntelMPI"
        intel_reduce(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Scatter" && lib == "IntelMPI"
        intel_scatter(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    elseif fun_name == "MPI_Scatterv" && lib == "IntelMPI"
        intel_scatterv(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int)
    
    # OPEN MPI

    elseif fun_name == "MPI_Allreduce" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_reduce(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Bcast" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_bcast(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Alltoall" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_to_all(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Alltoallv" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_to_allv(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Allgather" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_gather(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Allgatherv" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_all_gatherv(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Scatter" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_scatter(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Reduce" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_reduce(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    elseif fun_name == "MPI_Gather" && lib == "OpenMPI"
        is_mpi_lib_is("OpenMPI") == true ? openmpi_gather(task::String, path::String, sumbit_job::Bool,add_header::Bool, julia_ouput_directory::String, slurm_config::String, number_of_julia_process::Int ) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    #elseif fun_name == "MPI_Gatherv" && lib == "OpenMPI"
    #    is_mpi_lib_is("OpenMPI") == true ? openmpi_gatherv(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))
    #elseif fun_name == "MPI_Scatterv" && lib == "OpenMPI"
    #    is_mpi_lib_is("OpenMPI") == true ? openmpi_scatterv(task::String, path::String) : throw(ErrorException("OpenMPI library is not configured with MPI.jl"))


    else
        println("unable to find the function name")
    end
end
