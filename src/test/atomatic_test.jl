export test_across_libraries

function test_across_libraries(fun_name::String, task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    
    if fun_name == "MPI_Allreduce"
        dictionary = across_test_all_reduce( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Bcast" 
        dictionary = across_test_bcast( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Allgather" 
        dictionary = across_test_all_gather( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Allgatherv" 
        dictionary = across_test_all_gatherv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    elseif fun_name == "MPI_Gather" 
        dictionary = across_test_gather( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Gatherv" 
        dictionary = across_test_gatherv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Alltoall" 
        dictionary = across_test_all_to_all( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    elseif fun_name == "MPI_Alltoallv" 
        dictionary = across_test_all_to_allv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Reduce" 
        dictionary = across_test_reduce( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Scatter" 
        dictionary = across_test_scatter( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    elseif fun_name == "MPI_Scatterv" 
        dictionary = across_test_scatterv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    else
        println("unable to find the function name")
    end 

    #create job script file
    create_across_test_job_script_file(task, "nocuta2", dictionary, slurm_config) 

    # Create Files
    create_file(task, "changeMPI.sh", changeMPI_file_content, true)

    create_file(task, "set_mpijl.jl", set_mpijl_content, false)

    create_file(task, "check_mpi_version.jl", check_mpi_version_content, false)

    #run(`sbatch s.sh`)
    cd(task) do
       #run(`sbatch s.sh`)
    end

end



function across_test_all_reduce( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
                    ##(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String)
        out = openmpi_all_reduce(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
                    ##(task_name::String, path::String, sumbit_job::Bool, add_header::Bool, sub::String)
        out = intel_all_reduce(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function across_test_bcast( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    @show "atomatic_test->across_test_bcast open mPi"
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_bcast(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    @show "atomatic_test->across_test_bcast intel"

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_bcast(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end 

function across_test_all_gather( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_all_gather(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_all_gather(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end
    
function across_test_all_gatherv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_all_gatherv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_all_gatherv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end
        
function across_test_gather( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_gather(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_gather(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function across_test_gatherv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_gatherv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_gatherv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function across_test_all_to_all( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_all_to_all(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_all_to_all(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function across_test_all_to_allv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)  
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_all_to_allv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_all_to_allv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function across_test_reduce( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_reduce(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_reduce(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function across_test_scatter( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array) 
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_scatter(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_scatter(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function across_test_scatterv( task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)
    dics = Dict{String, String}()
    mkdir(task)
    for mpi_lib in openMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = openmpi_scatterv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process);
        dics[mpi_lib] = out
    end

    for mpi_lib in intelMPI
        sub_mpi_directory = replace(mpi_lib, "/" => "")
        out = intel_scatterv(task * "/" * sub_mpi_directory , path, false, false, sub_mpi_directory, slurm_config, number_of_julia_process)
        dics[mpi_lib] = out
    end
    return dics
end

function create_file(path::String, file_name::String, file_content::String, chmod::Bool)
    file_path = path  * "/" * file_name
    @show file_path
    
    open(file_path, "w") do file
        write(file, file_content)
    end

    if chmod
        file_name::String = path  * "/" * file_name
        run(`chmod 777 $file_name`)
    end

end

function create_across_test_job_script_file(path::String, nocuta_system::String, data::Dict, slurm_config::String)
    content = ""

    for (key, value) in data
        tempLine0= "echo $key \n"
        tempLine = ". changeMPI.sh $key \n"
        tempLine2= "julia set_mpijl.jl \n"
        tempLine3= "julia check_mpi_version.jl \n"
        tempLine4= "\n" * value * "\n"
        temp = tempLine0 * tempLine * tempLine2 * tempLine3 * tempLine4
        content = content * temp
    end

    if slurm_config != ""
        final_content = slurm_config * content

    else
        final_content = across_test_job_script_file_content_header * content
    end

    @show content

    @show final_content
    open(path  * "/" * "s.sh", "w") do file
        write(file, final_content)
    end   
end

include("constants.jl")
