

# function to get the different algo of collective fuction on MPI
# Return a dictionary 
function get_tuned_algorithm_from_openmpi(function_name::String)
    dic_of_algorithm = Dict()
    
    string_output = read(pipeline(`ompi_info --param coll tuned -l 9`, `grep "$(function_name) algorith"`), String)
    
    start = findfirst("Can be locked down to choice of:", string_output)
    end1 = findfirst(". Only relevant", string_output)
    r = string_output[start[end]+1:end1[1]-1]
    
    list = split(r, "," )
    for item in list
        temp = chop(item, head = 1, tail = 0)
        tempList = split(temp, " "; limit = 2 )
        #dic_of_algoritm[]
        #dd = replace(tempList[1], ":" => "")
        key = replace(tempList[1], r"[: ]" => "")
        dic_of_algorithm[key] = tempList[2]
    end
    
    @show dic_of_algorithm
    return dic_of_algorithm

end
