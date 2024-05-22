# use cv module to calculate the distance between two selections
cv reset
cv molid top 
cv config {
    colvar {
    distance {
    componentCoeff 1.0
    # start at 1
    group1 { atomNumbers 572 }
    group2 { atomNumbers 635 }
    }
}
}

# the output file name
set outf [open "dis_pbc.txt" w]

# 总帧数
set num [molinfo top get numframes]
for { set i 0 } { $i < $num } { incr i } {
    cv frame $i
    cv update
    set dist [cv colvar colvar1 value]
    # unit: ns
    set time [expr $i]
    puts $outf "$time $dist"
}
close $outf
exit

