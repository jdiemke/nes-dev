.export WAIT_PPU_READY
.export DISABLE_PPU_RENDERING
.export DISABLE_NMI_INTERRUPTS
.export SET_BACKGROUND_COLOR, ENABLE_PPU_RENDERING, ENABLE_NMI_INTERRUPTS

PPU_CTRL    = $2000
PPU_STATUS  = $2002
PPU_MASK 	  = $2001

PPU_SCROLL  = $2005
PPU_ADDR    = $2006
PPU_DATA    = $2007

MASK_BG   = $08
CTRL_NMI  = $80

.proc SET_BACKGROUND_COLOR
    LDA #$3f
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    LDA #$1c
    STA PPU_DATA
    RTS
.endproc

; PPU needs 2 VBLANK cycles to "warm up"
.proc WAIT_PPU_READY
    BIT PPU_STATUS  ; reset status register to defined value
    JSR WAIT_VBLANK
    JSR WAIT_VBLANK
    RTS
.endproc

.proc WAIT_VBLANK
  VBLANK:
    BIT PPU_STATUS
    BPL VBLANK
    RTS
.endproc

.proc DISABLE_PPU_RENDERING
    LDX #0
    STX PPU_MASK        ; disable PPU rendering
    RTS
.endproc

.proc ENABLE_PPU_RENDERING
    LDA #MASK_BG
    STA PPU_MASK
    RTS
.endproc

.proc ENABLE_NMI_INTERRUPTS
    LDA #CTRL_NMI
    STA PPU_CTRL
    RTS
.endproc

.proc DISABLE_NMI_INTERRUPTS
    LDX #0
    STX PPU_CTRL        ; disable NMI interrupt
    RTS
.endproc
