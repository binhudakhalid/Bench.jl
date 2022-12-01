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
#julia --project=. plot.jl


function plot_bench(name::String; xlims=(1, 2 ^ 23), ylims=(Inf, Inf), array_of_bench::Array)
    system = "Fugaku"
    xticks_range = exp2.(log2(first(xlims)):2:log2(last(xlims)))
    xticks = (xticks_range, format_bytes.(xticks_range))


    p = plot(;
    title = "Latency of MPI $(name) @ local (1 nodes, 4 ranks)",
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

    for item in array_of_bench
        julia  = readdlm("$(item)", ',', Float64; skipstart=1)
        plot!(p, julia[:, 1],  julia[:, 5];  label="without cache avoidance", marker=:auto, markersize=3)
    end



    
    #plot!(p, riken[:, 1], riken[:, 2]; label="Cache avoidance (Riken-CCS)", marker=:auto, markersize=3)
    savefig(joinpath("/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/6/", "$(lowercase(name))-latency_ one_node_4rank.pdf"))
end

#plot_bench("Allreduce"; xlims=(4, 2 ^ 22.5), ylims=(10 ^ -6, Inf))
#plot_bench("Gatherv"; xlims=(1, 2 ^ 20.5))
#plot_bench("Reduce"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf))
