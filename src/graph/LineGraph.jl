export draw_line_chart

function draw_line_chart(path::String)

    @show "Drawing graph"
    data_csv_files_list = get_csv_file_from_path(path)
  
    # error handling
    if isempty(data_csv_files_list)
        @show "No csv file found in $(path)"
    end

    plot_bench("Reduce"; xlims=(1, 2 ^ 22), ylims=(10 ^ -6, Inf), array_of_bench=data_csv_files_list, path=path)

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

include("graph_util.jl")
