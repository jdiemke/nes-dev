.export START_GAME_LOOP

.import READ_GAMEPAD_1
.importzp GAMEPAD_1, GAMEPAD_STATUS, A_STATUS

.include "include/gamepad.inc"
.include "include/macros.inc"

.proc START_GAME_LOOP
    MAIN_LOOP:
        JSR READ_GAMEPAD_1
        ; store final result of game pad at memory location 1
        set GAMEPAD_STATUS, GAMEPAD_1
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
.endproc