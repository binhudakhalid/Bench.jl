export BenchBroadcast

struct BenchBroadcast <: MPIBenchmark
    conf::Configuration
    name::String
end

function BenchBroadcast(T::Type=Float32;
                   filename::Union{String,Nothing}="julia_imb_b_bcast.csv",
                   kwargs...,
                   )
    return BenchBroadcast(
        Configuration(T; filename, kwargs...),
        "IMB Reduce",
    )
end

function imb_b_bcast(T::Type, bufsize::Int, iters::Int, a::Int, dict::Dict)

  
    #bcast
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("bcast") # get_all_bcast_algorithm()
    #@show dic_of_algorithm
    
    # write a jobscriptfile
   # write_job_script_file(dic_of_algorithm)

    #execute sbatch from julia's run



 
    return "avgtime"
end


#=
function get_all_bcast_algorithm()
    dic_of_algorithm = Dict()
    
   #a = read(pipeline(`ompi_info --param coll tuned -l 9`, `grep "bcast algorith"`), String)

    #a = read(` ompi_info --param coll tuned -l 9` , String)
    #start = findfirst("Can be locked down to choice of:", s)


    #@show a

    #s = "                          Number of bcast algorithms available\n                          Which bcast algorithm is used. Can be locked down to choice of: 0 ignore, 1 basic linear, 2 chain, 3: pipeline, 4: split binary tree, 5: binary tree, 6: binomial tree, 7: knomial tree, 8: scatter_allgather, 9: scatter_allgather_ring. Only relevant if coll_tuned_use_dynamic_rules is true.\n                          Segment size in bytes used by default for bcast algorithms. Only has meaning if algorithm is forced and supports segmenting. 0 bytes means no segmentation.\n                          Fanout for n-tree used for bcast algorithms. Only has meaning if algorithm is forced and supports n-tree topo based operation.\n                          Fanout for chains used for bcast algorithms. Only has meaning if algorithm is forced and supports chain topo based operation.\n                          k-nomial tree radix for the bcast algorithm (radix > 1).\n"
    s = read(pipeline(`ompi_info --param coll tuned -l 9`, `grep "bcast algorith"`), String)
    
    start = findfirst("Can be locked down to choice of:", s)
    end1 = findfirst(". Only relevant", s)
    r = s[start[end]+1:end1[1]-1]
    
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
=#



benchmark(bench::BenchBroadcast) = run_collective(bench, imb_b_bcast, bench.conf)
