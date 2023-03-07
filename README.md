To install Bench.jl, open a Julia REPL, type ] to enter the Pkg REPL mode and run the command
   
    add https://github.com/binhudakhalid/Bench.jl

The Bench.jl require
1.     MPI.jl 0.20.4
1.     Julia 1.6 or more
1.     MPIBenchmarks.jl

And it will only work with Intel MPI and Open MPI.

## How to run on Noctua 2.

1. First load the modules

        module reset
        module load lang    
        module load JuliaHPC  

2. Second intall MPI.jl and MPIBenchmarks.jl

3. Create script file for julia "test.jl" with following content:

        using Bench

        my_slurm_config = """
        #!/bin/bash
        ##SBATCH -q express
        #SBATCH -J JuliaBenchMark
        #SBATCH -A hpc-prf-mpibj
        #SBATCH -p normal
        #SBATCH -N 2                       ## [NUMBER_OF_NODE]
        #SBATCH --cpus-per-task=1
        #SBATCH --ntasks-per-node=2      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
        #SBATCH -t 50:40:00
        """

        bench1("MPI_Allreduce", "task_bench_allreduce2", "/scratch/hpc-prf-mpibj/com_j_variant/Noctua2", "OpenMPI", my_slurm_config, 4)


And execute using "julia test.jl". The will submit the becnhmarking jobs to Slurm. Wait for the job to complete (check squeue to see the status). And Then it store the benchmarking results (benchmark with every variant of MPI_Allreduce) in folder called "task_bench_allreduce2". 

![image](https://user-images.githubusercontent.com/9871507/223517799-f656d8ad-81bb-4f70-99fa-ca40d7f095eb.png) This picture shows the content of "task_bench_allreduce2" folder.

## How to draw bar charts for the previous benchmarking results

1. Create script file for julia "bplot.jl" with following content:

      using Bench
      draw_bar_chart("/scratch/hpc-prf-mpibj/com_j_variant/Noctua2/task_bench_allreduce2", "2b")
      draw_bar_chart("/scratch/hpc-prf-mpibj/com_j_variant/Noctua2/task_bench_allreduce2", "32b")

2. Run the script (julia bplot.jl).  It will generate two graph 1 for two bytes and the other one for thirty two bytes.
 ![image](https://user-images.githubusercontent.com/9871507/223521470-f8817fc3-4936-4b3b-a565-013be9922d21.png)



## How to draw Line charts for the previous benchmarking results


1. Create script file for julia "lineplot.jl" with following content:

            using Bench
            draw_bar_chart("/scratch/hpc-prf-mpibj/com_j_variant/Noctua2/task_bench_allreduce2", "2b")
            draw_bar_chart("/scratch/hpc-prf-mpibj/com_j_variant/Noctua2/task_bench_allreduce2", "32b")

2. Run the script (julia lineplot.jl).  It will generate line graph, each line represending 1 variant of MPIALL reduce.

   ![image](https://user-images.githubusercontent.com/9871507/223522068-b26cd1c1-385d-409d-81ca-5430601c9810.png)


# bench1() Function
      Functional signature
      function bench1 ( fun_name::String, task::String, path::String, lib::String, slurm_config :: String , number_of_julia_process::Int )

### List of collective operation work with Open MPI for `bench1()` function:
   - MPI_Allreduce
   - MPI_Bcast
   - MPI_Alltoall
   - MPI_Allgather
   - MPI_Allgatherv
   - MPI_Scatter
   - MPI_Reduce
   - MPI_Gather
   
   
### List of collective operation work with Intel MPI for `bench1()` function:

   - MPI_Allreduce
   - MPI_Bcast
   - MPI_Allgather
   - MPI_Allgatherv
   - MPI_Gather
   - MPI_Gatherv
   - MPI_Alltoall
   - MPI_Alltoallv
   - MPI_Reduce
   - MPI_Scatter
   - MPI_Scatterv
   - MPI_Scatter
   - MPI_Reduce
   - MPI_Scatter
   - MPI_Scatterv


## draw_bar_chart() Function

      # functional signature
      function draw_bar_chart(path::String, data_size::String)
      
 The data_size can be 1b, 2b, 4b, 8b, 16b, 32b



## How to run test_across_libraries on Noctua 2

      using Bench

      my_slurm_config = """
      #!/bin/bash
      ##SBATCH -q express
      #SBATCH -J JuliaBenchMark
      #SBATCH -A hpc-prf-mpibj
      #SBATCH -p normal
      #SBATCH -N 2                       ## [NUMBER_OF_NODE]
      #SBATCH --cpus-per-task=1
      #SBATCH --ntasks-per-node=2      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
      #SBATCH --exclusive
      #SBATCH -t 10:40:00
      """

      # Functional Signature
      #function test_across_libraries(fun_name::String, task::String, path::String, slurm_config::String, number_of_julia_process::Int, openMPI::Array, intelMPI::Array)

      # Modules available in Noctua 2
      openMPIList = ["mpi/OpenMPI/4.1.4-GCC-11.3.0", "mpi/OpenMPI/4.1.1-GCC-11.2.0"]
      #intelMPIList = ["mpi/impi/2021.7.1-intel-compilers-2022.2.1","mpi/impi/2021.5.0-intel-compilers-2022.0.1"]
      intelMPIList = []
      # Functional call
      test_across_libraries("MPI_Allreduce", "test_mpiallreduce2", "/scratch/hpc-prf-mpibj/ya", my_slurm_config, 4, openMPIList, intelMPIList)

![image](https://user-images.githubusercontent.com/9871507/223528278-c570d616-a588-4399-92cd-0f7f94152103.png)


