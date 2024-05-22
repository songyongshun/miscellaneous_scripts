# used to generate the size of system 
# how to use:
# source size.tcl
# 方便被外部调用

# last edited at 2021-12-31, by ys_song
proc size {} {
    set sel [atomselect top all]
    measure minmax $sel
    set size [measure minmax $sel]
    set min [lindex $size 0]
    set max [lindex $size 1]
    return [vecsub $max $min]
}
