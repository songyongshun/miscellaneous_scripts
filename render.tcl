# in tcl of vmd, run source render.tcl.
pbc box -off
axes location off
color Display Background white
set crd [pwd]
cd "C:/Program Files (x86)/University of Illinois/VMD"
render Tachyon out "tachyon_WIN32.exe" -aasamples 12 %s -format bmp -res 2000 2000 -o $crd/%s.bmp
# this line is essential for the following command.
cd $crd
