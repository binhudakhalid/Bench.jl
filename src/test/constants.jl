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
open_mpi_module = [
"mpi/OpenMPI/4.1.4-GCC-11.3.0",
"mpi/OpenMPI/4.1.1-GCC-11.2.0"
]


intel_mpi_module = [
"mpi/impi/2021.7.1-intel-compilers-2022.2.1",
"mpi/impi/2021.5.0-intel-compilers-2022.0.1"
] 

# /upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100
