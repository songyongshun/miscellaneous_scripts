# given three atom indexs(ids), make them to the xy plane.
# the first two will be along x axis.
# last edited 2021.1.16 by ys_song.

proc plane {id1 id2 id3} {
set mol [atomselect top all]
set C1 [atomselect top "index $id1"]
set C2 [atomselect top "index $id2"]

set vC1  [lindex [$C1 get {x y z}] 0]
set vC2  [lindex [$C2 get {x y z}] 0]

set vdC [vecsub $vC1 $vC2]

$mol move [transmult [transvecinv $vdC] [transoffset [vecinvert $vC1] ] ]

set C3 [atomselect top "index $id3"]
set vy  [lindex [$C3 get {y}] 0]
set vz  [lindex [$C3 get {z}] 0]
set angle [expr -180*atan($vz/$vy)/3.1415926]

$mol move [transaxis x $angle]
}