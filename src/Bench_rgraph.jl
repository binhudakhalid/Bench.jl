export BenchRGraph

struct BenchRGraph <: MPIBenchmark
    conf::Configuration
    name::String
end

function BenchRGraph(T::Type=Float32;
                   filename::Union{String,Nothing}="julia_imb_b_rgraph.csv",
                   kwargs...,
                   )
    return BenchRGraph(
        Configuration(T; filename, kwargs...),
        "IMB Reduce",
    )
end

function imb_b_rgraph(T::Type, bufsize::Int, iters::Int, a::Int, path::String)

    @show "imb_b_rgraph"
    @show "here"
    @show path
    @show "0000000000000000000000000000000000000000000"
    #read from a file

    #get all from the folder

    data_csv_files_list = get_csv_file_from_path(path)
  
    # error handling
    if isempty(data_csv_files_list)
        @show "No csv file found in $(path)"
    end

    plot_bench("Reduce"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf), array_of_bench=data_csv_files_list)


    @show "----------------"
    @show data_csv_files_list
    @show "----------------"





    


 
    return "avgtime"
end


function get_csv_file_from_path(path::String)
    get_all_files_from_path = joinpath.(path, readdir(path))
    data_csv_files = []
    for item in get_all_files_from_path
        if contains(item , ".csv")
            push!(data_csv_files, item)
        end
    end
    return data_csv_files
end

 
benchmark(bench::BenchRGraph, path::String) = run_graph(bench, imb_b_rgraph, bench.conf, path)
