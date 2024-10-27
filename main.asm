REG_GAMEPAD_1 = $4016

GAMEPAD_BTN_A_MASK      = %10000000
GAMEPAD_BTN_B_MASK      = %01000000
GAMEPAD_BTN_SELECT_MASK = %00100000
GAMEPAD_BTN_START_MASK  = %00010000
GAMEPAD_UP_MASK         = %00001000
GAMEPAD_DOWN_MASK       = %00000100
GAMEPAD_LEFT_MASK       = %00000010
GAMEPAD_RIGHT_MASK      = %00000001

.segment "HEADER"
  .byte "NES", $1a, $02, $01
  .byte %00000000
  .byte $00
  .byte $00
  .byte $00
  .byte $00
  .byte $00,$00,$00,$00,$00

.segment "TILES"
.segment "OAM"
.segment "STARTUP"
.segment "ZEROPAGE"
  GAMEPAD_1: .res 1  ; 8 bit variable containing flags for buttons
  GAMEPAD_STATUS: .res 1
  A_STATUS: .res 1
.segment "CODE"
RESET:
  SEI
  CLD
  ; disable APU frame IRQ
  LDX #$40
  STX $4017
  ; initialize stack
  LDX #$FF
	TXS
  ; disable NMI, rendering, DMC IRQs
  LDX #0
  STX $2000
  STX $2001
  STX $2010

  BIT $2002
VBLANK1:
  BIT $2002
  BPL VBLANK1
VBLANK2:
  BIT $2002
  BPL VBLANK2
MAIN_LOOP:
  JSR READ_GAMEPAD_1

  ; store final result of game pad at memory location 1
  LDA GAMEPAD_1
  STA 1

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

.segment "VECTORS"
  .word VBLANK
  .word RESET
  .word IRQ

.segment "CHARS"