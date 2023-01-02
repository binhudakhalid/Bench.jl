using Bench

#benchmark(BenchAllreduce(),"task_6", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_5")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_5")
#using Plots
#x = range(0, 10, length=100)
#y = sin.(x)
#plot(x, y)



#benchmark(BenchIntelAllreduce(),"task_10", @__FILE__)
#asd("ali")
#--------------------------------------------------------
#bench1("MPI_Allreduce", "task_1006", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1006")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1006")

#MPI_Bcast
#bench1("MPI_Bcast", "task_1009", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1009")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1009")


#MPI_Allgather
#bench1("MPI_Allgather", "task_10011", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10011")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10011")

#MPI_Allgatherv
#bench1("MPI_Allgatherv", "task_10012", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10012")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10012")

#MPI_Gather chechk
#bench1("MPI_Gather", "task_100131", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10013")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10013")

#MPI_Gatherv
#bench1("MPI_Gatherv", "task_100141", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10014")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10014")


#MPI_MPI_Alltoall
#bench1("MPI_Alltoall", "task_10015", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10015")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10015")

#MPI_MPI_Alltoallv
#bench1("MPI_Alltoallv", "task_10016", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10016")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10016")


#MPI_Reduce
#bench1("MPI_Reduce", "task_10017", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10017")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10017")

#MPI_Scatter
#bench1("MPI_Scatter", "task_10018", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10018")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10018")


#MPI_Scatter
#bench1("MPI_Scatterv", "task_10019", @__FILE__)
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10019")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_10019")
#---------------------------------------------------

#--------------------------------------------------------
bench1("MPI_Allreduce", "task_1021", @__FILE__, "IntelMPI")
#benchmark(LineGraph(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1006")
#benchmark(BarChart(), "/upb/departments/pc2/groups/hpc-prf-mpibj/tun/test/8/96/100/task_1006")

