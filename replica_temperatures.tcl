# modify based on answer from Norman Geist: https://www.researchgate.net/post/Can_anyone_help_me_to_do_REMD_simulation_of_glycan_using_AMBER
# can run with vmd tcl engine now.

# last edited by ys_song, 2021-3-25

set min_temp 300
set max_temp 350
set num_replicas 10

proc replica_temp { i } {
  global set min_temp max_temp num_replicas
return [format "%.2f" [expr ($min_temp * \
         exp( log(1.0*$max_temp/$min_temp)*(1.0*$i/($num_replicas-1)) ) )]]
}

for {set r 0} {$r < $num_replicas} {incr r} {
  puts [replica_temp $r]
}
