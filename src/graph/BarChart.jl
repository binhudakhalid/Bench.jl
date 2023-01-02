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
    @show "Drawing Bar Chart1"
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
            @show "--------------"
            @show temp_name
            @show "--------------"

            #value = replace(temp_name, "coll_tuned_allreduce_algorithm_" => "", ".jl.csv" => "")
            value = set_name_format!(temp_name)
            #value = replace(temp_name, "_" => "\n")

            a = julia[:, 5]
            push!(y_list, a[14]*1e+6)
            push!(xx_list, "$(value)")
            push!(x_list, index )
            index = index + 1
        end
    end
    xx = xx_list # [1,2,3,4,5,6,7,8,9,10,11,12]#
    x =  x_list 
    y = y_list 

    @show xx
    @show length(xx)
    @show x_list
    @show y_list



    # get name from file
    function_name = ""
    open("$(path)/graph_data45.txt") do file
        function_name = read(file, String)
    end

    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:20, xx), left_margin=44Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)", ylabel = "algorithm Name", title = "$(function_name)", legend=:false)
  
    # annotate the bars of the chart
    i = 1
    for item in y_list
        annotate!((6,i,"$(item)"))
        i = i + 1
    end

    savefig(joinpath(path, "line_chart.pdf"))

    #savefig(graph_obj,"barplot445.png")
    
    @show "Drawing Bar Chart -> done"

end

function set_name_format!(value)

    value = replace(value, "I_MPI_ADJUST_ALLREDUCE_" => "",
                           "I_MPI_ADJUST_BCAST_" => "",
    ".jl.csv" => "")


    if length(value) > 20
        a = replace(value, r"(.{20})" => s"\1 \n")
        return a
    else
        return value
    end 
end


benchmark(bench::BarChart, path::String) = imb_b_rbarchart(path::String)