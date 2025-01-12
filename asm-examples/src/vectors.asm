.import VBLANK, RESET, IRQ

.segment "VECTORS"
  .word VBLANK
  .word RESET
  .word IRQ