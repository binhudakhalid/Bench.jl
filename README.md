To install MPIBenchmarks.jl, open a Julia REPL, type ] to enter the Pkg REPL mode and run the command
   
    add https://github.com/binhudakhalid/Bench.jl

Bench.jl requires Julia v1.6, MPI.jl v0.20 and MPIBenchmarks.jl.

    using Bench
    #using MPIBenchmarks
    benchmark(BenchBcast())
