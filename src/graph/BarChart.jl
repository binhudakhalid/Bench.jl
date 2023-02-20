using Printf

export draw_bar_chart

            # a[2] = 1byte
            # a[3] = 2bytes
            # a[7] = 32bytes
            # a[8] = 64 bytes
            # a[12] = 1kb
            # a[17] = 32 kb
            # a[22] = 1 MiB
            # a[23] = 2 MB

function string_to_index(data_size::String)
    if data_size == "1b"
        return 2
    elseif data_size == "2b"
        return 3
    elseif data_size == "4b"
        return 4
    elseif data_size == "8b"
        return 5
    elseif data_size == "16b"
        return 6
    elseif data_size == "32b"
        return 7
    elseif data_size == "64b"
        return 8
    elseif data_size == "128b"
        return 9
    elseif data_size == "256b"
        return 10
    elseif data_size == "512b"
        return 11
    elseif data_size == "1kb"
        return 12
    elseif data_size == "2kb"
        return 13
    elseif data_size == "4kb"
        return 14
    elseif data_size == "8kb"
        return 15
    elseif data_size == "16kb"
        return 16
    elseif data_size == "32kb"
        return 17
    elseif data_size == "64bk"
        return 18
    elseif data_size == "128bk"
        return 19
    elseif data_size == "256kb"
        return 20
    elseif data_size == "512kb"
        return 21
    elseif data_size == "1mb"
        return 22
    elseif data_size == "2mb"
        return 23
    else
        return 12 # 1kb
    end
end

function draw_bar_chart(path::String, data_size::String)
    println("Drawing Bar Chart1")
    data_csv_files_list = get_csv_file_from_path(path)
    array_of_bench = data_csv_files_list

    y_list = []
    xx_list = []
    x_list = []
    index_of_csv = string_to_index(data_size)

    index = 1
    for item in array_of_bench
        if !contains(item, ".pdf") && filesize("$(item)") > 0
            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]

            value = set_name_format!(temp_name)
            a = julia[:, 5]
            push!(y_list, a[index_of_csv]*1e+6)
            push!(xx_list, "$(value)")
            push!(x_list, index )
            index = index + 1
        end
    end
    xx = xx_list 
    x =  x_list 
    y = y_list 
    max_y_list = maximum(y_list)

    # get name from file
    function_name = ""
    open("$(path)/graph_data45.txt") do file
        function_name = read(file, String)
    end

    graph_obj = Plots.bar(x, y, orientation = :h,  yticks=(1:20, xx), left_margin=44Plots.mm, bottom_margin=6Plots.mm,  xlabel = "time (us)",
    ylabel = "algorithm Name", title = "$(function_name)", legend=:false, fillcolor=:blue,fillalpha=0.2)
  
    mid = max_y_list/2
    i = 1
    for item in y_list
        annotate!((mid,i,"$(item)"))
        i = i + 1
    end

    savefig(joinpath(path, "correct_bar_chart_$(data_size).pdf"))

  
    println("Drawing Bar Chart -> done")
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


