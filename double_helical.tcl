# used to rotate it and generate a double helix

proc double_helical {} {
set mol [atomselect top all]

set dtx 180
set dz 120
$mol move [transmult [transoffset "0 0 $dz"] [transaxis x $dtx] ]

$mol writepdb "helical2.pdb"
}