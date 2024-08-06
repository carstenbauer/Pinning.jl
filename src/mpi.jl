"""
    mpi_pinthreads(symbol; compact, kwargs...)

Pin the thread(s) of MPI ranks in a round-robin fashion to specific domains
(e.g. sockets or NUMA domains).
Specifically, when calling this function on all MPI ranks, the latter will be distributed
in a round-robin fashion among the specified domains such that their Julia threads
are pinned to non-overlapping ranges of CPU-threads within the domain.

For now, valid options for `symbol` are `:sockets` and `:numa`.

Both single-node and multi-node usage are supported.

If `compact=false` (default), physical cores are occupied before hyperthreads. Otherwise,
CPU-cores - with potentially multiple CPU-threads - are filled up one after another
(compact pinning).

**Note:**
As per usual for MPI, `rank` starts at zero.

*Example:*

```
using ThreadPinning
using MPI
MPI.Init()
mpi_pinthreads(:sockets)
```
"""
function mpi_pinthreads end

"""
On rank 0, this function returns a `Dict{Int, Vector{Int}}` where the keys
are the MPI rank ids and the values are the CPU IDs of the CPU-threads that are currently
running the Julia threads of the MPI rank. Returns `nothing` on all other ranks.
"""
function mpi_getcpuids end

"""
On rank 0, this function returns a `Dict{Int, String}` where the keys
are the MPI rank ids and the values are the hostnames of the nodes that are currently
hosting the respective MPI ranks. Returns `nothing` on all other ranks.
"""
function mpi_gethostnames end

"""
Returns a node-local rank id (starts at zero). Nodes are identified based on their
hostnames (`gethostname`). On each node, ranks are ordered based on their global rank id.
"""
function mpi_getlocalrank end
