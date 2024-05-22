# generate the origin.pdb file
# last edited at 2021-1-17, by ys_song

# 选中分子
set mol [atomselect top all]

# 选中要转到x轴上的两个原子
set C1 [atomselect top "index 102"]
set C2 [atomselect top "index 63"]

set vC1  [lindex [$C1 get {x y z}] 0]
set vC2  [lindex [$C2 get {x y z}] 0]
set vdC [vecsub $vC1 $vC2]

# 偏移值为C1坐标的负值
# 将 C1-->C2 变换为x轴
# 沿x轴平移 2 A, because no atom can make as the origin of the axis, will be not zero.
set dx 3

# 绕y轴旋转 71度, which is obtained by atan(z/y), where z,y is the coordinates of the atom you want to move it to xy plane.

#set r_y -71.75
set r_y 0
$mol move [transmult [transaxis x $r_y] [transoffset "$dx 0 0" ] [transvecinv $vdC] [transoffset [vecinvert $vC1] ] ]

# 保存为pdb文件
$mol writepdb "mol_origin.pdb"