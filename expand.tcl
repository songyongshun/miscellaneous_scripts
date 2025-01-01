# make mono.pdb to a*b*c of mono.
# expand sel a b c x y z
proc expand {} {
  set a 4
  set b 4
  set c 5
  # angle 60, change to 90.
  set x 9.503
  set y 6.936
  set z [expr 18.993 * sqrt(3)/2]

  set output_file "merged.pdb"  
  set out [open $output_file "w"]  

  # like this CRYST1    9.503    6.936   18.993  90.00 119.99  90.00 P 1           1
  set bx [expr $x*$a]
  set by [expr $y*$b]
  set bz [expr $z*$c]
  puts $out [format "CRYST1 %8.3f %8.3f %8.3f  90.00  90.00  90.00" $bx $by $bz]
  set mol [atomselect top all]
  $mol move [transoffset "-$x -$y -$z"] 
  for { set i 0 } { $i < $a } { incr i } {
    $mol move [transoffset "$x 0 0"] 
    for { set j 0 } { $j < $b } { incr j } {
      $mol move [transoffset "0 $y 0"] 
      for { set k 0 } { $k < $c } { incr k } {
	$mol move [transoffset "0 0 $z"] 
	set num_atoms [molinfo top get numatoms]
	for {set m 0} {$m < $num_atoms} {incr m} {  
	  # 读取每个分子的原子信息  
	  set atom_info [atomselect top "index $m"]  
	  # 将原子信息写入输出文件  
	  # 获取原子的坐标、元素、原子序号等信息
	  set coords [$atom_info get {x y z}]
	  set atom_type [$atom_info get {element}]
	  # 在$atom_type后面加上一个数字，代表不同原子
	  set atom_type1 "$atom_type$m"
	  set residue_name [$atom_info get {resname}]
	  set residue_index [$atom_info get {resid}]

	  # 格式化为 PDB 行，并写入输出文件
	  puts $out [format "ATOM     %d %s  %s       %d    %8.3f%8.3f%8.3f" \
	    $m $atom_type1 [lindex $residue_name 0] $residue_index \
	    [lindex [lindex $coords 0] 0] [lindex [lindex $coords 0] 1] \
	    [lindex [lindex $coords 0] 2]]
	}  
	#$mol writepdb "mol-$i-$j-$k.pdb"
      }
	set dz [expr $z * $c]
	$mol move [transoffset "0 0 -$dz"] 
    }
      set dy [expr $y * $b]
      $mol move [transoffset "0 -$dy 0"] 
  }
  close $out
}
