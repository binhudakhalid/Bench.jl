

# function to get the different algo of collective fuction on MPI
# Return a dictionary 
function get_tuned_algorithm_from_openmpi(function_name::String)
    dic_of_algorithm = Dict()
    
    string_output = read(pipeline(`ompi_info --param coll tuned -l 9`, `grep " $(function_name) algorith"`), String)
    
    @show "------------------"
    @show string_output
    @show "------------------"


    start = findfirst("Can be locked down to choice of:", string_output)
    if start === nothing
        start = findfirst("Can be locked down to any of:", string_output)
    end

    end1 = findfirst(". Only relevant", string_output)
    @show start
    @show end1
    r = string_output[start[end]+1:end1[1]-1]
    
    list = split(r, "," )
    for item in list
        temp = chop(item, head = 1, tail = 0)
        tempList = split(temp, " "; limit = 2 )
        #dic_of_algoritm[]
        #dd = replace(tempList[1], ":" => "")
        key = replace(tempList[1], r"[: ]" => "", ".jl.csv" => "")
        key = match(r"\d+", key).match

        value = replace(tempList[2], ")" => "", "(" => "", " " => "_", "+"=>"plus")

        dic_of_algorithm[key] = value
    end
    
    @show dic_of_algorithm
    return dic_of_algorithm

end

initial_part = """
#!/bin/bash
##SBATCH -q express
#SBATCH -J JuliaBenchMark
#SBATCH -A hpc-prf-mpibj
#SBATCH -p normal
#SBATCH -N 4                       ## [NUMBER_OF_NODE]
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=64      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
#SBATCH --exclusive
#SBATCH -t 40:40:00

###module reset
###module load lang       # loading the gateway module
###module load JuliaHPC   # loading the latest JuliaHPC
"""



#=
initial_part = """
#!/bin/bash
#SBATCH -q express
#SBATCH -J JuliaBenchMark
#SBATCH -A hpc-prf-mpibj
##SBATCH -p hpc-prf-mpibj
#SBATCH -N 1			 ## [NUMBER_OF_NODE]
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=4      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
#SBATCH --mem-per-cpu 10G         ## [Memory per CPU]  - A node have many CPUs
#SBATCH -t 00:30:00

###module reset
###module load lang       # loading the gateway module
###module load JuliaHPC   # loading the latest JuliaHPC

"""
=#