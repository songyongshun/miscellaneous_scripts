# move $sel and save
# last edited 2021-1-17, by ys_song

proc msave {sel} {
set mol [atomselect top all]
set num 10
for { set i 0 } { $i < $num } { incr i } {
#set j [expr -0.1*$i]
$sel move [transoffset "0 0 0.2" ]

# 保存为pdb文件
$mol writepdb "mol_$i.pdb"
}
}