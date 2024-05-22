# in tcl of vmd, run source render64.tcl.

proc rd { out } {
  set outfile $out.ppm
  axes location off
  color Display Background white
  #set crd [pwd]
  # seems must be defined in vmd.rc, at here, just don't work.
  #set env(VMDOPTIXIMAGESIZE) "3840 2160"
  # ppm can be opened by imageglass, save as png is ok.
  render TachyonLOptiXInternal $outfile
}
