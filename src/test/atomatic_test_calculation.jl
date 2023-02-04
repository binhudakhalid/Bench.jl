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
    di = Dict{String, Vector}()
    di2 = Dict()

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

    x = [1, 2, 3, 4, 5]
    xlims=(1, 2 ^ 23)
    ylims=(Inf, Inf)
    xticks_range = exp2.(log2(first(xlims)):2:log2(last(xlims)))
    xticks = (xticks_range, format_bytes.(xticks_range))

    p = scatter(; title = "a", titlefont=font(12), xlabel = "message size",
    xscale = :log10, xlims, xticks, ylabel = "time [sec]",
    ylims, yscale = :log10, legend=:outertopright, left_margin=15Plots.mm, bottom_margin=15Plots.mm,
    guidefont=font(8), xtickfont=font(5), width=2000,height=2000, legend_margin=5, legendfont=font(5))


    for item in all_directories
        cvs_list = get_csv_file_from_path(item)
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                julia  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia


                scatter!( p, julia[:, 1],  julia[:, 5], color=colors[index], ma=0.9   )
                index = index + 1
                @show "me"

                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                di2[lib*"_"*csv_name] = julia


            end
        end
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                julia  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia


                scatter!( p, julia[:, 1],  julia[:, 5], color=colors[index], ma=0.9   )
                index = index + 1
                @show "me"

                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                di2[lib*"_"*csv_name] = julia


            end
        end
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                julia  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia


                scatter!( p, julia[:, 1],  julia[:, 5], color=colors[index], ma=0.9   )
                index = index + 1
                @show "me"

                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                di2[lib*"_"*csv_name] = julia


            end
        end
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                julia  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia


                scatter!( p, julia[:, 1],  julia[:, 5], color=colors[index], ma=0.9   )
                index = index + 1
                @show "me"

                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                di2[lib*"_"*csv_name] = julia


            end
        end
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                julia  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia


                scatter!( p, julia[:, 1],  julia[:, 5], color=colors[index], ma=0.9   )
                index = index + 1
                @show "me"

                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                di2[lib*"_"*csv_name] = julia


            end
        end
        index = 1
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                julia  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia


                scatter!( p, julia[:, 1],  julia[:, 5], color=colors[index], ma=0.9   )
                index = index + 1
                @show "me"

                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                di2[lib*"_"*csv_name] = julia


            end
        end
    
        #di[item] = a 

    end


    savefig(joinpath(path, "gggg3.pdf"))


    @show "==================="
    #@show di2





end


#= create a scatter plot with different colors for each column
scatter(df[:,1], df[:,2], color=:red, label="Column 1")
scatter!(df[:,1], df[:,3], color=:green, label="Column 2")
scatter!(df[:,1], df[:,4], color=:blue, label="Column 3")
scatter!(df[:,1], df[:,5], color=:purple, label="Column 4")
scatter!(df[:,1], df[:,6], color=:orange, label="Column 5")
=#