The repository contains package for my Master thesis at University of Paderborn.
To install Bench.jl, open a Julia REPL, type ] to enter the Pkg REPL mode and run the command
   
    add https://github.com/binhudakhalid/Bench.jl

Bench.jl requires Julia v1.6, MPI.jl v0.20 and MPIBenchmarks.jl.

    using Bench
    benchmark(BenchBcast())
