using Bench

#=

my_slurm_config = """
#!/bin/bash
##SBATCH -q express
#SBATCH -J JuliaBenchMark
#SBATCH -A hpc-prf-mpibj
#SBATCH -p normal
#SBATCH -N 4                       ## [NUMBER_OF_NODE]
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=16      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
##SBATCH --exclusive
#SBATCH -t 50:40:00
"""

#bench1("MPI_Allreduce", "m3", @__FILE__, "OpenMPI")
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/auto/m3")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/auto/m3")
openMPI = ["mpi/OpenMPI/4.1.4-GCC-11.3.0", "mpi/OpenMPI/4.1.1-GCC-11.2.0"]
intelMPI = ["mpi/impi/2021.7.1-intel-compilers-2022.2.1","mpi/impi/2021.5.0-intel-compilers-2022.0.1"]

test_across_libraries("MPI_Allreduce", "f_mpiallreduce", @__FILE__, my_slurm_config, 64, openMPI, intelMPI)
#bench1("MPI_Allreduce", "yy_m5", @__FILE__, "IntelMPI", my_slurm_config, 9)


#across_test_calculation("LineGraph()", "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/auto/m2")

#across_test("MPI_Allreduce", "final_m2", @__FILE__, "OpenMPI")

#test_across_libraries("MPI_Allreduce", "final_m2", @__FILE__, ["mpi/OpenMPI/4.1.4-GCC-11.3.0", "mpi/OpenMPI/4.1.2-GCC-11.2.0"], ["mpi/OpenMPI/4.1.2-GCC-11.2.0", "mpi/$

=#
