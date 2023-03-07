export across_test_calculation


function across_test_calculation(Barchart_title::String, path::String,  datasize::String)

    @show path
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

    #@show all_directories

    for item in all_directories
        cvs_list = get_csv_file_from_path(item)
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                dataframe  = readdlm("$(csv)", ',', Float64; skipstart=1)
                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                @show dataframe[:, 5]
                dic_with_all_results["$(lib)_$(csv_name)"] = dataframe[:, 5]

            end
        end
    end

    @show "==================="
    @show datasize

    
    
    draw_chart_one(path, dic_with_all_results, datasize)
    #find top 5 best algorithm
    find_top_best_algorithm(dic_with_all_results, datasize)
    
end

function find_top_best_algorithm(dic_with_all_results, datasize)

    index_of_csv = string_to_index(datasize)
    list = Dict{}()
    for (key, item)  in dic_with_all_results
        list[key] = item[index_of_csv]
    end
    @show list
    @show "----------------"
    sort_dictionar = sort(collect(list), by=x->x[2])
    @show sort_dictionar

    # print the top 5 best latencies
    println("\nThe top five best algorithms for the message size of $(datasize) are: \n")
    i = 1
    for (key, item)  in sort_dictionar
        println("$(i): $(key) ->  $(item)" )
        i = i + 1
        if i == 6  break end
    end
end

function draw_chart_one(path, dic_with_all_results::Dict,data_size::String )
    println("Drawing Bar Chart")

    @show dic_with_all_results
    deb = []
    y_list = []
    xx_list = []
    x_list = []
    index_of_csv = string_to_index(data_size)
    @show index_of_csv
    @show "--------------------"
    index = 1
    for (key, item)  in dic_with_all_results
        
        value = set_name_format!(key)
        push!(deb, item[index_of_csv])
        push!(y_list, item[index_of_csv]*1e+6)
        push!(xx_list, "$(value)")
        push!(x_list, index )
        index = index + 1
    end
    @show deb


    xx = xx_list 
    #@show xx
    x =  x_list 
    y = y_list 
    max_y_list = maximum(y_list)

    function_name  = "abc"

    @show x
    @show y

    #Plots.scalefontsizes(0.4)
    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:80, xx), left_margin=10Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)",
    ylabel = "", title = "Scatter", legend=:false, fillcolor=:blue,fillalpha=0.2, 
    ytickfont=font(2) )
    mid = max_y_list/2
    
    @show y_list
    i = 1
    for item in y_list
        annotate!((mid,i,"$(item)"), annotationfontsize=4)

        #annotate!((mid,i,"$(item)"))
        i = i + 1
    end

    savefig(joinpath(path, "f_Scatter_$(index_of_csv).pdf"))

    function f(x, y)
        r = sqrt(x^2 + y^2)
        return cos(r) / (1 + r)
    end

    println("Drawing Bar Chart -> done")
end



#=
    #Plots.scalefontsizes(0.4)
    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:80, xx), left_margin=10Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)",
    ylabel = "algorithm Name", title = "Bcast", legend=:false, fillcolor=:blue,fillalpha=0.2, 
    ytickfont=font(1) )

    #graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:20, xx), left_margin=44Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)",
    #ylabel = "algorithm Name", title = "MPI_Alltoallv", legend=:false, fillcolor=:blue,fillalpha=0.2, ytickfont=font(6))
=#