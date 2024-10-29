.import INIT_NES
.import START_GAME_LOOP
.import HANDLE_NMI

.global VBLANK, RESET, IRQ


PPU_SCROLL  = $2005
PPU_ADDR    = $2006
PPU_DATA    = $2007

MASK_BG   = $08
CTRL_NMI  = $80

.importzp X_POS, Y_POS

.segment "OAM"
.segment "CODE"
  RESET:
    SEI
    CLD
    LDX #$FF
    TXS
    JSR INIT_NES
    JMP START_GAME_LOOP
  VBLANK:

    ;JSR HANDLE_NMI
    RTI
  IRQ:
    RTI