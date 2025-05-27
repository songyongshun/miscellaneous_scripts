# used to 计算某两个原子或基团之间的距离
# run by:
# vmd.exe -dispdev text -psf temp.psf -xtc temp.xtc -e temp.tcl
# last edited at 2021-8-10, by ys_song

proc dist1 { } {
set outfilename $out
set a1 [atomselect top "index 74"]
set a2 [atomselect top "index 126"]
set num [molinfo top get numframes]
puts $num
set outfile [open $outfilename w]
for { set i 1 } { $i < $num } { incr i } {
$a1 frame $i 
$a2 frame $i 
set center1 [measure center $a1 weight mass] 
set center2 [measure center $a2 weight mass] 
set dist1 [vecdist $center1 $center2]]
set j [expr $i-1]
#puts $outfile "$j 0 $dist1 $dist2 $dist3; $dist1 0 $dist4 $dist5; $dist2 $dist4 0 $dist6; $dist3 $dist5 $dist6 0"
puts $outfile "$j $dist1"
}
close $outfile
}
