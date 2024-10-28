.export READ_GAMEPAD_1

.importzp GAMEPAD_1

.include "include/gamepad.inc"

; READ GAMEPAD 1
; --------------
; cycles:       132 
; instructions: 38
; description: reads the first gamepad and stores result in zero page variable GAMEPAD_1
.proc READ_GAMEPAD_1
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
.endproc