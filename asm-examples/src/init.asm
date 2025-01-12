.export INIT_NES

.import DISABLE_APU_FRAME_IRQ
.import WAIT_PPU_READY
.import DISABLE_DMC_INTERRUPTS
.import DISABLE_NMI_INTERRUPTS
.import DISABLE_PPU_RENDERING

.proc INIT_NES
    JSR DISABLE_APU_FRAME_IRQ
    JSR DISABLE_PPU_RENDERING
    JSR DISABLE_NMI_INTERRUPTS
    JSR DISABLE_DMC_INTERRUPTS
    ; some APU disable stuff might be missing here
    JSR CLEAR_RAM
    JSR WAIT_PPU_READY
    RTS
.endproc

; clear ram but not the stack frame between $100 and $1FF
.proc CLEAR_RAM
    LDA #0
    TAX
  CLEAR_MEM:
    STA $000, X
    STA $200, X
    STA $300, X
    STA $400, X
    STA $500, X
    STA $600, X
    STA $700, X
    INX
    BNE CLEAR_MEM
    RTS
.endproc