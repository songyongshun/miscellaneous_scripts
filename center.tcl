# used to move the molecule to the center
# how to use:
# source center.tcl

# last edited at 2021-1-27, by ys_song

proc center {sel} {
set sel [atomselect top all]
set center_ori [measure center $sel]
set center [lindex [pbc get] 0]
set x1 [lindex $center 0]
set y1 [lindex $center 1]
set z1 [lindex $center 2]

set center [vecscale [list $x1 $y1 $z1] 0.5]
set M [vecsub $center $center_ori]
$sel moveby $M
}
