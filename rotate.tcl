# used to treat the output file of center.tcl
# to obtain all the rotated structures
# last edited at 2021-1-17, by ys_song

# 选中分子
set mol [atomselect top all]

# z方向移动，成为螺旋
set dt 30 
set dz 10
# 12 is 360
for {set i 0} {$i <= 12} {incr i 1} {
	# 绕z轴旋转 t
	# 沿z轴平移 z
	set t [expr $i*$dt]
	set z [expr $i*$dz]
	$mol move [transmult [transoffset "0 0 $dz"] [transaxis z $dt] ]

	# 保存为xyz文件
	$mol writexyz "mol_$z-$t.xyz"
}