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
    function_name = ""

    open("$(path)/graph_data45.txt") do file
        function_name = read(file, String)
    end

    xticks_range = exp2.(log2(first(xlims)):2:log2(last(xlims)))
    xticks = (xticks_range, format_bytes.(xticks_range))

    p = plot(; title = function_name, titlefont=font(12), xlabel = "message size",
    xscale = :log10, xlims, xticks, ylabel = "time [sec]",
    ylims, yscale = :log10, legend=:topleft, left_margin=15Plots.mm, bottom_margin=15Plots.mm)

    @show @__DIR__
    @show "joinpathjoinpath"

    #/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_2/coll_tuned_allreduce_algorithm_basic_linear.jl.csv

    for item in array_of_bench
        if !contains(item, ".pdf")
            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]
            value = replace(temp_name, "coll_tuned_allreduce_algorithm_" => "", ".jl.csv" => "")
            plot!(p, julia[:, 1],  julia[:, 5];  label="$(value)", marker=:auto, markersize=2, legendfontsize=4, background_color_legend=nothing)#legend=:outertop)
        end
    end#background_color_legend=nothing

    
    savefig(joinpath(path, "graph.pdf"))

end

#plot_bench("Allreduce"; xlims=(4, 2 ^ 22.5), ylims=(10 ^ -6, Inf))
#plot_bench("Gatherv"; xlims=(1, 2 ^ 20.5))
#plot_bench("Reduce"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf))
#julia --project=. plot.jl
