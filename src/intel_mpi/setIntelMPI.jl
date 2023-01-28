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



#= https://stackoverflow.com/questions/45224536/module-load-command-in-linux-bash-script
I had a similar problem, and found two solutions:

instead of running your script with sh yourscript.sh or ./yourscript.sh, you could run it as . yourscript.sh This will source the module correctly and run the script

if you don't want to use . yourscript.sh, you can modify your shebang from #!/bin/sh to #!/bin/bash as noted in DavidC's answer and run your script as ./yourscript.sh Note that running it as sh yourscript.sh will not work

  =#  