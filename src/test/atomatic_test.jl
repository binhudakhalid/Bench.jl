export across_test

changeMPI_file_content = """
rm -rf ~/.julia/compiled/v1.8/MPI
rm -rf /upb/departments/pc2/groups/hpc-prf-mpibj/khalids/.julia/compiled/v1.8/MPI
rm -rf /upb/departments/pc2/users/k/khalids/.julia/compiled/v1.8/MPI
ml reset
ml lang
ml JuliaHPC
ml \$1
"""
#
# julia setMPI_jl_version.jl
#julia checkMPIVersion.jl

set_mpijl_content = """
using MPIPreferences
MPIPreferences.use_system_binary()  # use the system binary
"""

check_mpi_version_content = """
using MPI
impl, version = MPI.identify_implementation()

println(impl)

println(version)
"""

across_test_job_script_file_content_header = """
#!/bin/bash
#SBATCH -q express
#SBATCH -J JuliaBenchMark
#SBATCH -A hpc-prf-mpibj
##SBATCH -p hpc-prf-mpibj
#SBATCH -N 1                     ## [NUMBER_OF_NODE]
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=4      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
#SBATCH --mem-per-cpu 10G         ## [Memory per CPU]  - A node have many CPUs
#SBATCH -t 00:30:00
ls -la

"""

# Noctua2
open_mpi_module = ["mpi/OpenMPI/4.1.4-GCC-11.3.0",
"mpi/OpenMPI/4.1.2-GCC-11.2.0",
"mpi/OpenMPI/4.1.1-gcccuda-2022a",
"mpi/OpenMPI/4.1.1-GCC-11.2.0",
"mpi/OpenMPI/4.1.1-GCC-10.3.0",
"mpi/OpenMPI/4.0.5-gcccuda-2020b",
"mpi/OpenMPI/4.0.5-GCC-10.2.0",
"mpi/OpenMPI/4.0.3-GCC-9.3.0",]











# /upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100

function across_test(fun_name::String, task::String, path::String, lib::String)
    
    @show fun_name
    @show task
    @show path
    
    

    mkdir(task)

    # Create Files
    create_file(task, "changeMPI.sh", changeMPI_file_content, true)

    create_file(task, "set_mpijl.jl", set_mpijl_content, false)

    create_file(task, "check_mpi_version.jl", check_mpi_version_content, false)

    #create job script file
    create_across_test_job_script_file(task, "nocuta2")
    
    #a = task * "/" * "s.sh"
    #run(`sbatch $a`)

    cd(task) do
        run(`sbatch s.sh`)
    end


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


function create_across_test_job_script_file(path::String, nocuta_system::String)
    content = ""
    if nocuta_system == "nocuta2"
        for mod in open_mpi_module
            tempLine0= "echo $mod"
            tempLine = ". changeMPI.sh $mod \n"
            tempLine2= "julia set_mpijl.jl \n"
            tempLine3= "julia check_mpi_version.jl \n"
            temp = tempLine0 * tempLine * tempLine2 * tempLine3
            content = content * temp
        end


        @show content
        final_content = across_test_job_script_file_content_header * content
        open(path  * "/" * "s.sh", "w") do file
            write(file, final_content)
        end
    end
end

