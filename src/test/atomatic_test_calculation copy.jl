export across_test_calculation

# Noctua2
open_mpi_module = [
"mpi/OpenMPI/4.1.4-GCC-11.3.0",
"mpi/OpenMPI/4.1.2-GCC-11.2.0",
#"mpi/OpenMPI/4.1.1-gcccuda-2022a",
#"mpi/OpenMPI/4.0.5-GCC-10.2.0",
#"mpi/OpenMPI/4.0.3-GCC-9.3.0"
]

#=
open_mpi_module = ["mpi/OpenMPI/4.1.4-GCC-11.3.0",
"mpi/OpenMPI/4.1.2-GCC-11.2.0",
"mpi/OpenMPI/4.1.1-gcccuda-2022a",
"mpi/OpenMPI/4.1.1-GCC-11.2.0",
"mpi/OpenMPI/4.1.1-GCC-10.3.0",
"mpi/OpenMPI/4.0.5-gcccuda-2020b",
"mpi/OpenMPI/4.0.5-GCC-10.2.0",
"mpi/OpenMPI/4.0.3-GCC-9.3.0",] 
=#


       #= if !contains(item, ".pdf") && filesize("$(item)") > 0
            @show filesize("$(item)")
            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]=#

function across_test_calculation(fun_name, path::String)

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
        #println("Files in $root")
        #for file in files
        #    println(joinpath(root, file)) # path to files
        #end
    end

    @show all_directories
    colors = ["red3", "green", "blue", "purple", "orange", "yellow", "pink", "magenta", "gray", "cyan", "chartreuse1", "black" ]
    markerSize = [1,2,3,1,2,3,1,2,3,1,2,3,1,2]

     

    for item in all_directories
        cvs_list = get_csv_file_from_path(item)
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                dataframe  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia
                
                #split_on_slash = split(csv, "/")
                #MPI_library_name = split_on_slash[end-1]
                #di[MPI_library_name] = dataframe[:, 5]
                #@show 

     
                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                @show dataframe[:, 5]
                dic_with_all_results["$(lib)_$(csv_name)"] = dataframe[:, 5]

            end
        end
    end



   # savefig(joinpath(path, "gggg4.pdf"))


    @show "==================="
    #@show dic_with_all_results
    draw_chart(path, dic_with_all_results, "32kb")





end


#= create a scatter plot with different colors for each column
scatter(df[:,1], df[:,2], color=:red, label="Column 1")
scatter!(df[:,1], df[:,3], color=:green, label="Column 2")
scatter!(df[:,1], df[:,4], color=:blue, label="Column 3")
scatter!(df[:,1], df[:,5], color=:purple, label="Column 4")
scatter!(df[:,1], df[:,6], color=:orange, label="Column 5")
=#


function draw_chart(path, dic_with_all_results::Dict,data_size::String )
    println("Drawing Bar Chart")

    #@show dic_with_all_results
    deb = []
    y_list = []
    xx_list = []
    x_list = []
    index_of_csv = string_to_index(data_size)
    @show index_of_csv
    index = 1
    for (key, item)  in dic_with_all_results
        
        value = set_name_format!(key)
        #push!(deb, item[index])
        push!(y_list, item[index_of_csv]*1e+6)
        push!(xx_list, "$(value)")
        push!(x_list, index )
        index = index + 1
    end
    @show deb





  #=  index = index
    for item in array_of_bench
        if !contains(item, ".pdf") && filesize("$(item)") > 0
            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]

            value = set_name_format!(temp_name)
            a = julia[:, 5]
            push!(y_list, a[index]*1e+6)
            push!(xx_list, "$(value)")
            push!(x_list, index )
            index = index + 1
        end
    end =#


    xx = xx_list 
    #@show xx
    x =  x_list 
    y = y_list 
    max_y_list = maximum(y_list)

#=    function_name  = "abc"

    @show x
    @show y

    #Plots.scalefontsizes(0.4)
    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:80, xx), left_margin=44Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)",
    ylabel = "algorithm Name", title = "$(function_name)", legend=:false, fillcolor=:blue,fillalpha=0.2, xtickfont=font(1), 
    ytickfont=font(1) )
  
    mid = max_y_list/2
    
    @show y_list
    i = 1
    for item in y_list
        annotate!((mid,i,"$(item)"), annotationfontsize=2)
        i = i + 1
    end

    savefig(joinpath(path, "tttt_bar_chart_$(index).pdf"))
    =#
    function f(x, y)
        r = sqrt(x^2 + y^2)
        return cos(r) / (1 + r)
    end

    @show palette([:purple, :green],54 )
    @show x
    @show y

    data2 = rand(21,100)

    a = 1:size(data2,1)
    @show a
    @show b= 1:size(data2,2)
    @show data3= 1:size(data2,2)
    
    data = rand(21,100)
   
    xs = [string("x", i) for i = 1:24]
    ys = [string("y8888888888888888888888888888888888888 \n 8888888888888888888888888888888", i) for i = 1:40]
    z = float((1:40) * reshape(1:24, 1, :))
    
    heatmap(xs, ys, z, yticks = :all, ytickfont=font(2), left_margin=44Plots.mm, guidefont=font(10),  legendfont=font(10))

    savefig(joinpath(path, "2221tttt_bar_chart_$(index).pdf"))

    println("Drawing Bar Chart -> done")
end
