.include "include/gamepad.inc"
.include "include/macros.asm"

.import DISABLE_APU_FRAME_IRQ

.segment "HEADER"
  .byte "NES", $1A  ; iNES header identifier
  .byte 2           ; 2x 16KB PRG-ROM Banks
  .byte 1           ; 1x  8KB CHR-ROM
  .byte $01, $00    ; mapper 0, vertical mirroring

.segment "VECTORS"
  .word VBLANK
  .word RESET
  .word IRQ

.segment "ZEROPAGE"
  GAMEPAD_1: .res 1  ; 8 bit variable containing flags for buttons
  GAMEPAD_STATUS: .res 1
  A_STATUS: .res 1

.segment "CODE"

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

.proc INIT_NES
  JSR DISABLE_APU_FRAME_IRQ
  ; disable NMI, rendering, DMC IRQs
  LDX #0
  STX $2000
  STX $2001
  STX $4010
  JSR WAIT_PPU_READY
  RTS
.endproc

RESET:
  SEI
  CLD
  LDX #$FF
	TXS
  JSR INIT_NES
MAIN_LOOP:
  JSR READ_GAMEPAD_1

  ; store final result of game pad at memory location 1
  LDA GAMEPAD_1
  STA 1

  set 1, GAMEPAD_1

  ; check single button
  LDA GAMEPAD_1
  AND #GAMEPAD_BTN_A_MASK
  BEQ A_NOT_PRESSED
  LDA #5
  STA A_STATUS
  JMP END_A_NOT_PRESSED
A_NOT_PRESSED:
  LDA #6
  STA A_STATUS
END_A_NOT_PRESSED:
  JMP MAIN_LOOP

VBLANK:
IRQ:
  RTI

; 132 cycles
; 38 instructions
READ_GAMEPAD_1:
  LDA #1
  STA REG_GAMEPAD_1
  STA GAMEPAD_1
  LDA #0
  STA REG_GAMEPAD_1  
GAMEPAD_READ_LOOP:
  LDA REG_GAMEPAD_1
  LSR A
  ROL GAMEPAD_1
  BCC GAMEPAD_READ_LOOP
  RTS


.segment "TILES"
.segment "OAM"
.segment "STARTUP"




.segment "CHARS"