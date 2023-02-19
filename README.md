To install MPIBenchmarks.jl, open a Julia REPL, type ] to enter the Pkg REPL mode and run the command
   
    add https://github.com/binhudakhalid/Bench.jl

Bench.jl requires Julia v1.6, MPI.jl v0.20 and MPIBenchmarks.jl.

    using Bench
    #using MPIBenchmarks
    benchmark(BenchBcast())


## Example to run test_across_libraries() function on Noctua 2

      using Bench

      my_slurm_config = """
      #!/bin/bash
      ##SBATCH -q express
      #SBATCH -J JuliaBenchMark
      #SBATCH -A hpc-prf-mpibj
      #SBATCH -p normal
      #SBATCH -N 4                       ## [NUMBER_OF_NODE]
      #SBATCH --cpus-per-task=1
      #SBATCH --ntasks-per-node=4      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
      #SBATCH --exclusive
      #SBATCH -t 10:40:00
      """
      openMPIList = ["mpi/OpenMPI/4.1.4-GCC-11.3.0", "mpi/OpenMPI/4.1.1-GCC-11.2.0"]
      intelMPIList = ["mpi/impi/2021.7.1-intel-compilers-2022.2.1","mpi/impi/2021.5.0-intel-compilers-2022.0.1"]

      # calling the the function
      test_across_libraries("MPI_Allreduce", "f_allreduce4_16", @__FILE__, my_slurm_config, 64, openMPIList, intelMPIList)
