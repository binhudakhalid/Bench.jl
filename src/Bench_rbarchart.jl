using Printf

export BenchRBarChart

struct BenchRBarChart <: MPIBenchmark
    conf::Configuration
    name::String
end

function BenchRBarChart(T::Type=Float32;
                   filename::Union{String,Nothing}="julia_imb_b_rbarchart.csv",
                   kwargs...,
                   )
    return BenchRBarChart(
        Configuration(T; filename, kwargs...),
        "IMB Reduce",
    )
end

function imb_b_rbarchart(T::Type, bufsize::Int, iters::Int, a::Int, path::String)

    @show "imb_b_rbarchart"
  
    #p = bar([1,2,3],[4,5,6],fillcolor=[:red,:green,:blue],fillalpha=[0.2,0.4,0.6])

    giorni = collect(1:10)
    fatturato = rand(10)
    #p = bar(giorni,fatturato)
   #= ylabel!("Fatturato [Dollari]")
    xlabel!("Tempo (Giorni)")
    title!("Fatturato Giornaliero")

    x = ["Bcast tree","Bcast tree2","Bcast tree5","Bcast tree 6","Bcast tree7"]
    y = [11,22,33,44,55]
    str = [(@sprintf("%.2f", yi),5) for yi in y]  # tuple with fontsize=10 (by: @pdeffebach)
    @show str
    (ymin,ymax) = extrema(y)
    dy = 0.05*(ymax-ymin)
    a = Plots.bar(x,y, title="Annotated bar plot",legend=false, orientation = :horizontal)
    
    #annotate!(x, y.+dy, str, ylim = (0,ymax+2dy))
    
    =#
    xx = ["1aaaaaaaaaaaa","2aaaaaaaaaa","3aaaaaaaa","4aaaaaaa","5aaaaaaaaaa","6","7aaaaaaaaaaaa","8aaaaaa","9aaaaaaaaa","10","11"]
    x = [1,2,3,4,5,6,7,8,9,10,11]
    y = [11,22,33,44,55,66,77,88,99,100,111]
    #a = Plots.bar(x, y,fillcolor=[:red,:green,:blue],fillalpha=[0.2,0.4,0.6], orientation = :h)

    a = Plots.bar(x, y, orientation = :h, yticks=(1:11, xx), left_margin=15Plots.mm  )
 
  
    #str = [(@sprintf("%.2f", yi),5) for yi in y]  # tuple with fontsize=10 (by: @pdeffebach)

    #annotate!(x, y, "sdfsdfsdf")
    #annotate!([(2,2,"(2,2)"),(3,7,text("hey", 2, :left, :top, :green))])
    annotate!([(5,1,"(5,1)"),(5,2,"(5,2)"),(5,3,"(5,3)"),(5,4, "5,4"),(5,5, "5,5"),(5,6, "5,6"),(5,10, "5,10"), (5,11, "5,11")])
    #annotate!([(6,1,"(6,1)"),(6,2,"(6,2)"),(6,3,"(6,3)"),(6,4, "6,4"),(6,5, "6,5"),(6,6, "6,6")])



    savefig(a,"barplot15.png")


    


 
    return "avgtime"
end

 

 
benchmark(bench::BenchRBarChart, path::String) = run_graph(bench, imb_b_rbarchart, bench.conf, path)
