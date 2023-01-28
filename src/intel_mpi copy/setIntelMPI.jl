#= setIntel.sh
#!/bin/bash -i
module reset
module load lang       # loading the gateway module
module load JuliaHPC   # loading the latest JuliaHPC
module load mpi/impi/2021.2.0-intel-compilers-2021.2.0
=#

#= setIntel.jl
using MPIPreferences
MPIPreferences.use_system_binary()  # use the system binary
=#

#=see
using MPI
impl, version = MPI.identify_implementation()
println("asdasdasdads")
println(impl)
println(version)
=#
