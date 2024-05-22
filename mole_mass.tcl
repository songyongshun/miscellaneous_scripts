# used to obtain the molar mass of the system
# last edited by ys_song, 2021-11-21

set aa [atomselect top all]
set nt [$aa num]
set mass1 [$aa get mass]
set t_m 0
for {set i 0} {$i < $nt} {incr i 1} {
    set massx [lindex $mass1 $i]
    set t_m [expr $t_m+$massx]
}

puts "molar mass is"
puts $t_m

