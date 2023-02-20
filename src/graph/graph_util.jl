# Reference: we get the inpiration from https://github.com/giordano/julia-on-fugaku/blob/main/benchmarks/mpi-collective/plot.jl 
# and modify the code according our need.

using Plots, DelimitedFiles

function format_data_unit(bytes)
    log2b = log2(bytes)
    unit, val = divrem(log2b, 10)
    val = Int(exp2(val))
    unit_string = if unit == 0
        " B"
    elseif unit == 1
        " KiB"
    elseif unit == 2
        " MiB"
    end
    return string(val) * unit_string
end

function plot_it(name::String; xlims=(1, 2 ^ 23), ylims=(Inf, Inf), array_of_bench::Array, path::String)
    function_name = ""

    open("$(path)/graph_data45.txt") do file
        function_name = read(file, String)
    end

    range_of_xticks = exp2.(log2(first(xlims)):2:log2(last(xlims)))
    xticks = (range_of_xticks, format_data_unit.(range_of_xticks))

    p = plot(; title = function_name, xlabel = "message size", titlefont=font(12),
    xscale = :log10, xlims, xticks, ylabel = "time [sec]",
    ylims, yscale = :log10, legend=:topleft, left_margin=15Plots.mm, bottom_margin=15Plots.mm)

    for item in array_of_bench
        if !contains(item, ".pdf") && filesize("$(item)") > 0

            data = readdlm("$(item)", ',')
            if isempty(data)
                println("The CSV file is empty.")
            else
                println("The CSV file is not empty.")
            end

            julia  = readdlm("$(item)", ',', Float64; skipstart=1)
            temp_name = split(item, "/")[end]
            value = replace(temp_name, "coll_tuned_allreduce_algorithm_" => "", ".jl.csv" => "")
            plot!(p, julia[:, 1],  julia[:, 5];  label="$(value)", marker=:auto, markersize=2, legendfontsize=4, background_color_legend=nothing)#legend=:outertop)
        end
    end
    # saving to the disk
    savefig(joinpath(path, "graph.pdf"))
end

#plot_bench("Allreduce"; xlims=(4, 2 ^ 22.5), ylims=(10 ^ -6, Inf))
#plot_bench("Gatherv"; xlims=(1, 2 ^ 20.5))
#plot_bench("Reduce"; xlims=(4, 2 ^ 27), ylims=(Inf, Inf))
#julia --project=. plot.jl
