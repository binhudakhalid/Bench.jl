# THis is the entry point for Bench.jl
module Bench
#using MPI

include("open_mpi/open_collective_fun.jl")
include("bench1.jl")
include("Util.jl")
end
