# used to obtain the n peptides from m of 100k_20ns.pdb.
# this pdb file has 162 k11 molecules, one k11 molecule has 208 atoms.
# last edited at 2021-3-1, by ys_song


set n 3
set m 3

set begin1 [expr ($m-1)*208]
set end1 [expr ($n/2+$n%2)*208+$begin1-1]
set mol1 [atomselect top "index $begin1 to $end1"]

set begin2 [expr 81*208+$begin1]
set end2 [expr ($n/2)*208+$begin2-1]
set mol2 [atomselect top "index $begin2 to $end2"]

set mol [atomselect top "index $begin1 to $end1 or index $begin2 to $end2"]
$mol writepdb "mol_out.pdb"