.import START_GAME_LOOP, INIT_NES
.global VBLANK, RESET, IRQ

.segment "TILES"
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
  IRQ:
    RTI