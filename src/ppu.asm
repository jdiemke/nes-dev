.export WAIT_PPU_READY

.proc WAIT_PPU_READY
  BIT $2002
VBLANK_1:
  BIT $2002
  BPL VBLANK_1
VBLANK_2:
  BIT $2002
  BPL VBLANK_2
  RTS
.endproc