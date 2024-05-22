# creat the invert file, to make it a couple.
# used to treat the output file of center.tcl

# last edited at 2021-1-26, by ys_song

# 选中分子
set mol [atomselect top all]

# since it already centered, rotate it directly.
set dz 5
set dt 195
$mol move [transmult [transoffset "0 0 $dz"] [transaxis z $dt] ]

# 保存为pdb文件
$mol writepdb "mol_invert.pdb"
