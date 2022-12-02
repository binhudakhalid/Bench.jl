To install MPIBenchmarks.jl, open a Julia REPL, type ] to enter the Pkg REPL mode and run the command
   
    add https://github.com/binhudakhalid/Bench.jl

Bench.jl requires Julia v1.6, MPI.jl v0.20, MPIBenchmarks.jl and Plots.jl

    using Bench
    #using MPIBenchmarks
    benchmark(BenchBcast())
    
Example Script

      using Bench
      #using MPIBenchmarks
      #benchmark(BenchBroadcast(), @__FILE__)
      #benchmark(BenchGraph(), @__FILE__)

      #benchmark(BenchScatter(), @__FILE__)
      #benchmark(BenchReduce(), @__FILE__)

      #benchmark(BenchGather(), @__FILE__)
      #benchmark(BenchAllreduce(), @__FILE__)

      #benchmark(BenchRGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/89/task0016")
      benchmark(BenchRBarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/89/task0016")
      #@show @__FILE__
      #@show Base.PROGRAM_FILE

      #@show @__@DIR__

