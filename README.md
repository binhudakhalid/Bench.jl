To install MPIBenchmarks.jl, open a Julia REPL, type ] to enter the Pkg REPL mode and run the command
   
    add https://github.com/binhudakhalid/Bench.jl

Bench.jl requires Julia v1.6, MPI.jl v0.20 and MPIBenchmarks.jl.

     using Bench
     bench1("MPI_Allreduce", "task_1021", @__FILE__, "IntelMPI")
     benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1006")
     benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1006")
    
# Automated testing

    test("MPI_Allreduce", "task_1023")

It will run against all the available version of OpenMPI and IntelMPI

Available version of Intel MPI on Noctua 2

- mpi/impi/2021.6.0-intel-compilers-2022.1.0
- mpi/impi/2021.5.0-intel-compilers-2022.0.1
- mpi/impi/2021.4.0-intel-compilers-2021.4.0
- mpi/impi/2021.2.0-intel-compilers-2021.2.0


Available version of Open MPI on Noctua 2

- mpi/OpenMPI/4.1.4-GCC-11.3.0
- mpi/OpenMPI/4.1.2-GCC-11.2.0
- mpi/OpenMPI/4.1.1-gcccuda-2022a
- mpi/OpenMPI/4.1.1-GCC-11.2.0
- mpi/OpenMPI/4.1.1-GCC-10.3.0
- mpi/OpenMPI/4.0.5-gcccuda-2020b
- mpi/OpenMPI/4.0.5-GCC-10.2.0
- mpi/OpenMPI/4.0.3-GCC-9.3.0
- mpi/OpenMPI/3.1.4-GCC-8.3.0 (NOT work with MPI.JL)
