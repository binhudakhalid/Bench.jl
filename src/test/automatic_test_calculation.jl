export across_test_calculation

# This function will only work on the output from test_across_libraries() funtion. It will draw bar charts.
function across_test_calculation(Barchart_title::String, path::String,  datasize::String)

    di = Dict{String, Array}()
    dic_with_all_results = Dict{String, Array}()

    all_directories = []
    for (root, dirs, files) in walkdir(path)
        #println("Directories in $root")
        for dir in dirs
            # path to directories
            push!(all_directories, joinpath(root, dir))

        end
    end


    for item in all_directories
        cvs_list = get_csv_file_from_path(item)
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                dataframe  = readdlm("$(csv)", ',', Float64; skipstart=1)
                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                dic_with_all_results["$(lib)_$(csv_name)"] = dataframe[:, 5]

            end
        end
    end
    
    # draw bar chart for a specific data size.
    draw_chart_one(Barchart_title, path, dic_with_all_results, datasize)
    # find top 5 best algorithms.
    find_top_best_algorithm(dic_with_all_results, datasize)
    
end

function find_top_best_algorithm(dic_with_all_results, datasize)

    index_of_csv = string_to_index(datasize)
    list = Dict{}()
    for (key, item)  in dic_with_all_results
        list[key] = item[index_of_csv]
    end
    sort_dictionar = sort(collect(list), by=x->x[2])

    # print the top 5 best latencies
    println("\nThe top five best algorithms for the message size of $(datasize) are: \n")
    i = 1
    for (key, item)  in sort_dictionar
        println("$(i): $(key) ->  $(item)" )
        i = i + 1
        if i == 6  break end
    end
end

function draw_chart_one(Barchart_title::String, path, dic_with_all_results::Dict,data_size::String )
    println("Drawing Bar Chart")

    deb = []
    y_list = []
    xx_list = []
    x_list = []
    index_of_csv = string_to_index(data_size)
    index = 1
    for (key, item)  in dic_with_all_results
        
        value = set_name_format!(key)
        push!(deb, item[index_of_csv])
        push!(y_list, item[index_of_csv]*1e+6)
        push!(xx_list, "$(value)")
        push!(x_list, index )
        index = index + 1
    end

    xx = xx_list 
    x =  x_list 
    y = y_list 
    max_y_list = maximum(y_list)

    function_name  = "abc"

    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:80, xx), left_margin=10Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)",
    ylabel = "", title = "$(Barchart_title)", legend=:false, fillcolor=:blue,fillalpha=0.2, 
    ytickfont=font(2) )
    mid = max_y_list/2
    
    i = 1
    for item in y_list
        annotate!((mid,i,"$(item)"), annotationfontsize=4)
        i = i + 1
    end

    savefig(joinpath(path, "bar_chart_$(index_of_csv).pdf"))

    println("Drawing Bar Chart -> done")
end
