.export WAIT_PPU_READY
.export DISABLE_PPU_RENDERING
.export DISABLE_NMI_INTERRUPTS,HELLO_WORLD
.export SET_BACKGROUND_COLOR, ENABLE_PPU_RENDERING, ENABLE_NMI_INTERRUPTS, SET_PALETTE

PPU_CTRL    = $2000
PPU_STATUS  = $2002
PPU_MASK 	  = $2001

PPU_SCROLL  = $2005
PPU_ADDR    = $2006
PPU_DATA    = $2007

MASK_BG   = $08
CTRL_NMI  = $80

.importzp X_POS, Y_POS

Palette:
	.dword $1389fc3c	;background 0
  .dword $0212223c	;background 1
  .dword $0211213c	;background 2
  .dword $0112223c	;background 3
  .dword $00293932	;sprite 0
  .dword $1a2a3a2c	;sprite 1
  .dword $1b2b3b1c	;sprite 2
  .dword $1c2c3c0c	;sprite 3
HelloMsg:
.byte "HELLO NINTENDO", $10, $00

.proc HELLO_WORLD
    LDA #$21
    STA PPU_ADDR
    LDA #$e9
    STA PPU_ADDR
    
	  ldy #0		; set Y counter to 0
  loop:
    lda HelloMsg,y	; get next character
    beq end	; is 0? exit loop
    sta PPU_DATA	; store+advance PPU
    iny		; next character
    bne loop	; loop
  end:
    LDA #0
    STA PPU_ADDR
    STA PPU_ADDR
    LDA X_POS
    sta PPU_SCROLL
    LDA Y_POS
    sta PPU_SCROLL
    rts		; return to caller
.endproc

.proc SET_BACKGROUND_COLOR
    LDA #$3f
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    LDA #$05
    STA PPU_DATA
    RTS
.endproc

.proc SET_PALETTE
    LDA #$3f
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    LDY #0
  LOOPP:
    LDA Palette, Y
    STA PPU_DATA
    INY
    CPY #32
    bne LOOPP
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
