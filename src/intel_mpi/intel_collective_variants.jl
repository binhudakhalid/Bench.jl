## https://www.intel.com/content/www/us/en/develop/documentation/mpi-developer-reference-linux/top/environment-variable-reference/i-mpi-adjust-family-environment-variables.html

# I_MPI_ADJUST_ALLREDUCE
dict_all_reduce_variant = Dict{Integer, String}(
    1 => "Recursive_doubling",
    2 => "Rabenseifner_s",
    3 => "Reduce_+_Bcast",
    4 => "Topology_aware_Reduce_+_Bcast",
    5 => "Binomial_gather_+_scatter",
    6 => "Topology_aware_binominal_gather_+_scatter",
    7 => "Shumilin_s_ring",
    8 => "Ring",
    9 => "Knomial",
    10 => "Topology_aware_SHM-based_flat",
    11 => "Topology_aware_SHM-based_Knomial",
    12 => "Topology_aware_SHM-based_Knary",
    )

# I_MPI_ADJUST_BCAST
dict_broadcast_variant = Dict{Integer, String}(
    1 => "Binomial",
    2 => "Recursive_doubling",
    3 => "Ring",
    4 => "Topology_aware_binomial",
    5 => "Topology_aware_recursive_doubling",
    6 => "Topology_aware_binominal_gather_+_scatter",
    7 => "Shumilin_s",
    8 => "Knomial",
    9 => "Topology_aware_SHM-based_flat",
    10 => "Topology_aware_SHM-based_Knomial",
    11 => "Topology_aware_SHM-based_Knary",
    12 => "NUMA_aware_SHM-based_SSE4_2",
    13 => "NUMA_aware_SHM-based_AVX2",
    14=> "NUMA_aware_SHM-based_AVX512")    

# I_MPI_ADJUST_ALLGATHER    
dict_all_gather_variant = Dict{Integer, String}(
    1 => "Recursive_doubling",
    2 => "Bruck_s",
    3 => "Ring",
    4 => "Topology_aware_Gatherv_+_Bcast",
    5 => "Knomial")


# I_MPI_ADJUST_ALLGATHERV
dict_all_gatherv_variant = Dict{Integer, String}(
    1 => "Recursive_doubling",
    2 => "Bruck_s",
    3 => "Ring",
    4 => "Topology_aware_Gatherv_+_Bcast")


# I_MPI_ADJUST_GATHER
dict_gather_variant = Dict{Integer, String}(
    1 => "Binomial",
    2 => "Topology_aware_binomial",
    3 => "Shumilin_s",
    4 => "Binomial_with_segmentation")

# I_MPI_ADJUST_GATHERV
dict_gatherv_variant = Dict{Integer, String}(
    1 => "Linear",
    2 => "Topology_aware_linear",
    3 => "Knomial")

# I_MPI_ADJUST_ALLTOALL
dict_allToall_variant = Dict{Integer, String}(
    1 => "Bruck_s",
    2 => "Isend_Irecv_+_waitall",
    3 => "Pair_wise_exchange",
    4 => "Plum_s")


# I_MPI_ADJUST_ALLTOALLV	
dict_allToallv_variant = Dict{Integer, String}(
    1 => "Isend_Irecv_+_waitall",
    2 => "Plum_s")

# I_MPI_ADJUST_REDUCE
dict_reduce_variant = Dict{Integer, String}(
    1 => "Shumilin_s",
    2 => "Binomial",
    3 => "Topology_aware_Shumilin_s",
    4 => "Topology_aware_binomial",
    5 => "Rabenseifner_s",
    6 => "Topology_aware_Rabenseifner_s",
    7 => "Knomial",
    8 => "Topology_aware_SHM-based_flat",
    9 => "Topology_aware_SHM-based_Knomial",
    10 => "Topology_aware_SHM-based_Knary",
    11 => "Topology_aware_SHM-based_binomial",
    )

# I_MPI_ADJUST_SCATTER
dict_scatter_variant = Dict{Integer, String}(
    1 => "Binomial",
    2 => "Topology_aware_binomial",
    3 => "Shumilin_s"
    )

# I_MPI_ADJUST_SCATTERV
dict_scatterv_variant = Dict{Integer, String}(
    1 => "Linear",
    2 => "Topology_aware_linear"
    )