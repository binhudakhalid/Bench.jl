export BenchGraph

struct BenchGraph <: MPIBenchmark
    conf::Configuration
    name::String
end

function BenchGraph(T::Type=Float32;
                   filename::Union{String,Nothing}="julia_imb_b_graph.csv",
                   kwargs...,
                   )
    return BenchGraph(
        Configuration(T; filename, kwargs...),
        "IMB Reduce",
    )
end

function imb_b_graph(T::Type, bufsize::Int, iters::Int, a::Int, dict::Dict)
    println("imb_b_graph")
    str1 = "coll_tuned_bcast_algorithm_ignore.jl.csv,coll_tuned_bcast_algorithm_knomial_tree.jl.csv"

    Array1 = ["/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/6/coll_tuned_bcast_algorithm_ignore.jl.csv", "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/6/coll_tuned_bcast_algorithm_knomial_tree.jl.csv"]


    plot_bench("Reduce"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf), array_of_bench=Array1)

  

 
    return "avgtime"
end
benchmark(bench::BenchGraph, path::String) = run_collective(bench, imb_b_graph, bench.conf, path)
