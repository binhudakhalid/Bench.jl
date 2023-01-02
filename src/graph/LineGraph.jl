export LineGraph

struct LineGraph <: MPIBenchmark
    conf::Configuration
    name::String
end

function LineGraph(T::Type=Float32;
                   filename::Union{String,Nothing}="LineGraph",
                   kwargs...,
                   )
    return LineGraph(
        Configuration(T; filename, kwargs...),
        "LineGraph",
    )
end

function imb_b_rgraph(path::String)

    @show "Drawing graph"
    data_csv_files_list = get_csv_file_from_path(path)
  
    # error handling
    if isempty(data_csv_files_list)
        @show "No csv file found in $(path)"
    end

    plot_bench("Reduce"; xlims=(4, 2 ^ 22), ylims=(Inf, Inf), array_of_bench=data_csv_files_list, path=path)

    return "avgtime"
end


function get_csv_file_from_path(path::String)
    @show path
    @show "memme"

    get_all_files_from_path = joinpath.(path, readdir(path))
    @show "memme2"

    @show get_all_files_from_path
    data_csv_files = []
    @show "memme3"

    for item in get_all_files_from_path
        if contains(item , ".csv")
            push!(data_csv_files, item)
        end
    end
    @show "memme4"

    return data_csv_files
end

 
benchmark(bench::LineGraph, path::String) = imb_b_rgraph(path)

include("graph_util.jl")
