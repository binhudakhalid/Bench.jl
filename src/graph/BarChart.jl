using Printf

export BarChart

struct BarChart <: MPIBenchmark
    conf::Configuration
    name::String
end

function BarChart(T::Type=Float32;
                   filename::Union{String,Nothing}="",
                   kwargs...,
                   )
    return BarChart(
        Configuration(T; filename, kwargs...),
        "BarChart",
    )
end

function imb_b_rbarchart(path::String)
    @show "Drawing Bar Chart"
    data_csv_files_list = get_csv_file_from_path(path)
    array_of_bench = data_csv_files_list
    y_list = []
    xx_list = []
    x_list = []
    index = 1
    
    for item in array_of_bench
        if !contains(item, ".pdf")
            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]
            value = replace(temp_name, "coll_tuned_allreduce_algorithm_" => "", ".jl.csv" => "")
            a = julia[:, 5]
            push!(y_list, a[14]*1e+6)
            push!(xx_list, "$(value)")
            push!(x_list, index )
            index = index + 1
        end
    end
    xx = xx_list
    x =  x_list 
    y = y_list 

    # get name from file
    function_name = ""
    open("$(path)/graph_data3.txt") do file
        function_name = read(file, String)
    end

    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:11, xx), left_margin=40Plots.mm, bottom_margin=10Plots.mm,  xlabel = "time (us)", ylabel = "algorithm Name", title = "$(function_name)")
  
    # annotate the bars of the chart
    i = 1
    for item in y_list
        annotate!((5,i,"$(item)"))
        i = i + 1
    end

    savefig(graph_obj,"barplot15.png")
    
    @show "Drawing Bar Chart -> done"

end

benchmark(bench::BarChart, path::String) = imb_b_rbarchart(path::String)