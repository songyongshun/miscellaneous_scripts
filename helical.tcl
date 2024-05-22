# to generate the helical ribbon as reference:
# Hwang, W., Marini, D. M., Kamm, R. D., & Zhang, S. (2003). Supramolecular structure of helical ribbons self-assembled from a β-sheet peptide. The Journal of chemical physics, 118(1), 389-397. doi:10.1063/1.1524618
# the input pdb is at the center, which is center.pdb
# last edited by ys_song, 2021-2-16

proc helical {} {

# 选中分子
set mol [atomselect top all]

# since it already centered, move along x axis, and rotate along y axis.
set dx 50
set dty 30 
$mol move [transmult [transoffset "$dx 0 0"] [transaxis y $dty] ]

# 保存为pdb文件
$mol writepdb "mol_0.pdb"


# move along z, change to along dz1=cos($dty)*dz and dx1=sin($dty)*dz
set dz 10
set dt 4.44
set dz1 [expr cos($dty*3.1416/180)*$dz]
set dx1 [expr sin($dty*3.1416/180)*$dz]
#set num [expr 360/$dt], actually 80.8+1
set num 82
for { set i 1 } { $i < $num } { incr i } {
$mol move [transmult [transaxis z $dt] [transoffset "0 0 $dz1"] [transoffset "$dx1 0 0"] ]
$mol writepdb "mol_$i.pdb"
}

# load seed file again
mol load pdb "center5.pdb"

set mol1 [atomselect 1 all]
$mol1 writepdb "origin.pdb"
set shift 21
# invert along y axis for self-sort and transoffset
$mol1 move [transmult [transoffset "$shift 0 0"] [transaxis x 180] [transaxis y 180]]

# move to the circle area
set half_dz [expr $dz/2]
set half_dz1 [expr $dz1/2]
set half_dx1 [expr $dx+$dx1/2]
set half_dt [expr $dt/2]
$mol1 move [transmult [transaxis z $half_dt] [transoffset "$half_dx1 0 $half_dz1"] [transaxis y $dty] ]
$mol1 writepdb "mol_i0.pdb"

for { set i 1 } { $i < $num } { incr i } {
$mol1 move [transmult [transaxis z $dt] [transoffset "0 0 $dz1"] [transoffset "$dx1 0 0"] ]
$mol1 writepdb "mol_i$i.pdb"
}

}