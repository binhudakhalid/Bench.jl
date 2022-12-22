using Plots, DelimitedFiles

function format_bytes(bytes)
    log2b = log2(bytes)
    unit, val = divrem(log2b, 10)
    val = Int(exp2(val))
    unit_string = if unit == 0
        " B"
    elseif unit == 1
        " KiB"
    elseif unit == 2
        " MiB"
    elseif unit == 3
        " GiB"
    elseif unit == 4
        " TiB"
    end
    return string(val) * unit_string
end

function plot_bench(name::String; xlims=(1, 2 ^ 23), ylims=(Inf, Inf), array_of_bench::Array, path::String)
    @show "=++++++++++++++++++++++++++++++++"
    @show name
    @show array_of_bench
    @show path
    @show "=++++++++++++++++++++++++++++++++"
    function_name = ""

    s = open("$(path)/graph_data3.txt") do file
        function_name = read(file, String)
        @show name
    end

    @show "---------------------------------------------444444444444444444444444444444444444444"

    @show function_name
    @show "---------------------------------------------444444444444444444444444444444444444444"

    xticks_range = exp2.(log2(first(xlims)):2:log2(last(xlims)))
    xticks = (xticks_range, format_bytes.(xticks_range))


    p = plot(;
    title = function_name, #"Latency of MPI $(name) @ local (1 nodes, 4 ranks)",
    titlefont=font(12),
    xlabel = "message size",
    xscale = :log10,
    xlims,
    xticks,
    ylabel = "time [sec]",
    ylims,
    yscale = :log10,
    legend=:topleft,
    )

    #julia  = readdlm(joinpath(@__DIR__, "one_node_4rank_1.csv"), ',', Float64; skipstart=1)
    @show @__DIR__
    @show "joinpathjoinpath"

    #/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_2/coll_tuned_allreduce_algorithm_basic_linear.jl.csv

    for item in array_of_bench
        if !contains(item, ".pdf")
            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]
            value = replace(temp_name, "coll_tuned_allreduce_algorithm_" => "", ".jl.csv" => "")
            plot!(p, julia[:, 1],  julia[:, 5];  label="$(value)", marker=:auto, markersize=3)
        end
    end
    savefig(joinpath(path, "graph.pdf"))

end

#plot_bench("Allreduce"; xlims=(4, 2 ^ 22.5), ylims=(10 ^ -6, Inf))
#plot_bench("Gatherv"; xlims=(1, 2 ^ 20.5))
#plot_bench("Reduce"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf))
#julia --project=. plot.jl
