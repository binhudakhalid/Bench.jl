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


function plot_bar_chart(name::String; xlims=(1, 2 ^ 23), ylims=(Inf, Inf), array_of_bench::Array, path::String)


     
    
    #plot!(p, riken[:, 1], riken[:, 2]; label="Cache avoidance (Riken-CCS)", marker=:auto, markersize=3)
    #savefig(joinpath("/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/6/", "$(lowercase(name))-latency_ one_node_4rank.pdf"))
    #savefig(joinpath(path, "$(lowercase(name))-latency_ one_node_4rank1.pdf"))

end

#plot_bench("Allreduce"; xlims=(4, 2 ^ 22.5), ylims=(10 ^ -6, Inf))
#plot_bench("Gatherv"; xlims=(1, 2 ^ 20.5))
#plot_bench("Reduce"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf))
