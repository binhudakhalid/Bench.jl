module Bench
using MPI

include("collective.jl")
include("open_mpi/open_collective_fun.jl")
include("bench1.jl")
include("Util.jl")
end
