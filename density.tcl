# used to calculate the density inside a nanotube
# how to use:
# source density.tcl
# density density.txt 10 0 199
# 10 is the number of bin, you want to split.
# 0 is the start frame, 199 is the end frame

proc density {out bin nstart nend} {

    set outfilename $out
    set num [molinfo top get numframes]

    set outfile [open $outfilename w]
    set r 13
    set xc 75
    set yc 75
    set zmin 100
    set zmax 180
    set dbin [expr $r*1.0/$bin]
    set Pi 3.1416
    
    #初始赋值
    for { set i 1 } { $i <= $bin } { incr i } {
    set ntot($i) 0
    }

    # 进入到每一帧累加
    for { set i $nstart } { $i <= $nend } { incr i } {

        puts $i
        # 选择不同bin区域，进行个数统计
        for { set j 1 } { $j <= $bin } { incr j } {
        set selw [atomselect top "(x-$xc)*(x-$xc)+(y-$yc)*(y-$yc)<$j*$dbin*$j*$dbin and (x-$xc)*(x-$xc)+(y-$yc)*(y-$yc)>($j-1)*$dbin*($j-1)*$dbin and z>$zmin and z<$zmax and name OH2" frame $i]
        set nw [$selw num]
        set ntot($j) [expr $ntot($j)+$nw]
        }
    }

    #输出到文件
    #单位是个数/nm^3
    for { set i 1 } { $i <= $bin } { incr i } {
        set den($i) [expr 1000*$ntot($i)/($nend-$nstart+1)/($zmax-$zmin)/($Pi*($i*$dbin)*($i*$dbin)-$Pi*(($i-1)*$dbin)*(($i-1)*$dbin))]
        puts $outfile "$den($i)" 
    }   
    close $outfile
}
