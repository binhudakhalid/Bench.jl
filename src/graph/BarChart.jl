using Printf

export BarChart
export imb_b_rbarchart

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
#draw_bar_Char
function imb_b_rbarchart(path::String, si)
    @show "Drawing Bar Chart1"
    data_csv_files_list = get_csv_file_from_path(path)
    array_of_bench = data_csv_files_list
    @show array_of_bench
    y_list2 = []
    y_list = []
    xx_list = []
    x_list = []
    index = 1
    @show "here"
    si = si
    for item in array_of_bench
        if !contains(item, ".pdf") && filesize("$(item)") > 0
            @show filesize("$(item)")
            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]
            #@show "--------------"
            #@show temp_name
            #@show "--------------"

            #value = replace(temp_name, "coll_tuned_allreduce_algorithm_" => "", ".jl.csv" => "")
            value = set_name_format!(temp_name)
            #value = replace(temp_name, "_" => "\n")

            a = julia[:, 5]


            # a[2] = 1byte
            # a[3] = 2bytes
            # a[7] = 32bytes
            # a[8] = 64 bytes
            # a[12] = 1kb
            # a[17] = 32 kb
            # a[22] = 1 MiB
            # a[23] = 2 MB
            

            @show a
            @show "a[$si]"
            @show a[si]
            push!(y_list, a[si]*1e+6)
            push!(xx_list, "$(value)")
            push!(x_list, index )
            index = index + 1
        end
    end
    xx = xx_list # [1,2,3,4,5,6,7,8,9,10,11,12]#
    x =  x_list 
    y = y_list 
    max_y_list = maximum(y_list)
    #@show max_y_list = maximum(y_list)

    #@show "-------------------------"
    #@show xx
    #@show length(xx)
    #@show x_list
    #@show "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
    #@show y_list
    #@show "-------------------------"




    # get name from file
    function_name = ""
    open("$(path)/graph_data45.txt") do file
        function_name = read(file, String)
    end



    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:20, xx), left_margin=44Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)",
     ylabel = "algorithm Name", title = "$(function_name)", legend=:false, 
     fillcolor=:blue,fillalpha=0.2)
  

    #plot(x1, y1, x2, y2, x3, y3, x4, y4, orientation = :h,  
    #yticks=(1:20, xx), left_margin=44Plots.mm,
    # bottom_margin=6Plots.mm,  xlabel = "time (us)", ylabel = "algorithm Name", 
    # title = "$(function_name)", legend=:false)

    # annotate the bars of the chart
    #if max_y_list >
    mid = max_y_list/2
    i = 1
    for item in y_list
        annotate!((mid,i,"$(item)"))
        i = i + 1
    end

    savefig(joinpath(path, "bar_chartt_$(si).pdf"))

    #savefig(graph_obj,"barplot445.png")
    
    @show "Drawing Bar Chart -> done"

end

function set_name_format!(value)

    value = replace(value, "I_MPI_ADJUST_ALLREDUCE_" => "",
                           "I_MPI_ADJUST_BCAST_" => "",
                           "coll_tuned_allreduce_algorithm_" => "",
                           "coll_tuned_bcast_algorithm_" => "",
                           "coll_tuned_alltoall_algorithm_" => "",
                           "coll_tuned_alltoallv_algorithm_" => "",
                           "coll_tuned_allgather_algorithm_" => "",
                           "coll_tuned_allgatherv_algorithm_" => "",
                           "coll_tuned_scatter_algorithm_" => "",
                           "coll_tuned_reduce_algorithm_" => "",
                           "coll_tuned_gather_algorithm_" => "",
        ".jl.csv" => "")


    if length(value) > 20
        a = replace(value, r"(.{20})" => s"\1 \n")
        return a
    else
        return value
    end 
end


benchmark(bench::BarChart, path::String) = imb_b_rbarchart(path::String)