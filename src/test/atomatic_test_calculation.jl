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
    colors = ["red", "green", "blue", "purple", "orange"]

    x = [1, 2, 3, 4, 5]

    for item in all_directories
        cvs_list = get_csv_file_from_path(item)
        for csv in cvs_list
            if contains(csv, ".csv") && filesize("$(csv)") > 0
                julia  = readdlm("$(csv)", ',', Float64; skipstart=1)
                #@show julia


                scatter( julia[:, 5], x, color=colors)

                lib = split(item, "/")[end]
                csv_name = split(csv, "/")[end]
                di2[lib*"_"*csv_name] = julia


            end
        end
    
        #di[item] = a 

    end


    savefig(joinpath(path, "gggg.pdf"))


    @show "==================="
    @show di2





end
