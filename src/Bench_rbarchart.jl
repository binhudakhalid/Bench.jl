using Printf

export BenchRBarChart

struct BenchRBarChart <: MPIBenchmark
    conf::Configuration
    name::String
end

function BenchRBarChart(T::Type=Float32;
                   filename::Union{String,Nothing}="julia_imb_b_rbarchart.csv",
                   kwargs...,
                   )
    return BenchRBarChart(
        Configuration(T; filename, kwargs...),
        "IMB Reduce",
    )
end

function imb_b_rbarchart(T::Type, bufsize::Int, iters::Int, a::Int, path::String)


    data_csv_files_list = get_csv_file_from_path(path)
    array_of_bench=data_csv_files_list
  
    #temp_name = split(item, "/")[end]
    #value = replace(temp_name, "coll_tuned_allreduce_algorithm_" => "", ".jl.csv" => "")
    #plot!(p, julia[:, 1],  julia[:, 5];  label="$(value)", marker=:auto, markersize=2)
   

    @show "Khalids"

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
            @show "--------------888-----------"
            @show a[14]
            push!(y_list, a[14]*1e+6)
            push!(xx_list, "$(value)")
            push!(x_list, index )
            index = index + 1
            @show "---------------888----------"

            #plot!(p, julia[:, 1],  julia[:, 5];  label="$(value)", marker=:auto, markersize=2)
        end
    end
    xx = xx_list
    @show "0000000000000000000000000000000000000000000000"
    @show xx_list
    @show y_list

    @show "0000000000000000000000000000000000000000000000"

    x =  x_list # [1,2,3,4,5,6]# ["basic", "ignore", "nonoverlapping", "recursive", "ring", "segmented"] #xx_list # [1,2,3,4,5,6]
    y = y_list #[61,22,33,44,55,66]
    #a = Plots.bar(x, y,fillcolor=[:red,:green,:blue],fillalpha=[0.2,0.4,0.6], orientation = :h)

    # get 
    function_name = ""

    s = open("$(path)/graph_data3.txt") do file
        function_name = read(file, String)
    end
    @show function_name

    # legend yticks=(1:11, xx)
    a = Plots.bar(x, y, orientation = :h,  yticks=(1:11, xx), left_margin=40Plots.mm, bottom_margin=10Plots.mm,  xlabel = "time (us)", ylabel = "algorithm Name", title = "$(function_name)")
 
  
    #str = [(@sprintf("%.2f", yi),5) for yi in y]  # tuple with fontsize=10 (by: @pdeffebach)

    #annotate!(x, y, "sdfsdfsdf")
    #annotate!([(2,2,"(2,2)"),(3,7,text("hey", 2, :left, :top, :green))])
    #annotate!([(5,1,"(5a,1a)"),(5,2,"(5a,2a)"),(5,3,"(5a,3a)"),(5,4, "5a,4a"),(5,5, "5a,5a"),(5,6, "5a,6a")])
    #annotate!([(6,1,"(6,1)"),(6,2,"(6,2)"),(6,3,"(6,3)"),(6,4, "6,4"),(6,5, "6,5"),(6,6, "6,6")])

    # annotate the bars of the chart
    i = 1
    for item in y_list
        annotate!((5,i,"$(item)"))
        i = i + 1
    end

    savefig(a,"barplot15.png")


    


 
    return "avgtime"
end

 

 
benchmark(bench::BenchRBarChart, path::String) = run_graph(bench, imb_b_rbarchart, bench.conf, path)
