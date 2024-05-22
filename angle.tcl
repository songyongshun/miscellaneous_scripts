# used to calculate the angle of assembled chiral peptides.
# last edited at 2021-1-17, by ys_song

proc angle {} {
set fid [open "angle.txt" w]

set mol [atomselect top all]
set C1 [atomselect top "index 103"]
set C2 [atomselect top "index 64"]
set C1t [atomselect top "index 4847"]
set C2t [atomselect top "index 4886"]
set num [molinfo top get numframes]
for { set i 0 } { $i < $num } { incr i } {
$C1 frame $i
$C2 frame $i
$C1t frame $i
$C2t frame $i

set vC1  [lindex [$C1 get {x y z}] 0]
set vC2  [lindex [$C2 get {x y z}] 0]
set vdC [vecsub $vC1 $vC2]

set vC1t  [lindex [$C1t get {x y z}] 0]
set vC2t  [lindex [$C2t get {x y z}] 0]
set vdCt [vecsub $vC1t $vC2t]

set C_2 [veclength $vdC]
set Ct_2 [veclength $vdCt]
set Cdot [vecdot $vdC $vdCt]
set angle [expr 180*acos($Cdot/$C_2/$Ct_2)/3.1415926]

puts $fid $angle 
}
close $fid
}
