function run_graph(benchmark::MPIBenchmark, func::Function, conf::Configuration, path::String)

    # To run it requires
        #1- Path of the script that start the program
        #2- MPIBenchmarks_function_name
        #3- OpenMPI param bcast

    @show path
    #@show benchmark
    #@show conf

    #@show  @__DIR__
    #@show @__FILE__
    #@show PROGRAM_FILE 
    dic_of_algorithm = get_tuned_algorithm_from_openmpi("bcast") # get_all_bcast_algorithm()


    func(conf.T, 1, 10 , 3, path)


     
    return nothing
end

 



include("Bench_rgraph.jl")
