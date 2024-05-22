# used to search the residues nearest to PHE(or other particular residue or group)
# last edited at 2021-2-16, by ys_song

proc search_res {} {
    set fid [open "nearest_res.txt" w]
    set num [molinfo top get numframes]
    for { set i 1 } { $i < $num } { incr i } {
        set near [atomselect top "name CA and same residue as within 5 of index 538 to 553" frame $i]
        puts $fid [$near get residue] 
    }
    close $fid
}

proc search_idx {} {
    set fid [open "nearest_idx.txt" w]
    set num [molinfo top get numframes]
    for { set i 0 } { $i < $num } { incr i } {
        set near [atomselect top "within 4 of index 143 to 153" frame $i]
        puts $fid [$near get index] 
    }
    close $fid
}
