.segment "HEADER"
  .byte "NES", $1A  ; iNES header identifier
  .byte 2           ; 2x 16KB PRG-ROM Banks
  .byte 1           ; 1x  8KB CHR-ROM
  .byte $01, $00    ; mapper 0, vertical mirroring
  .byte $00, $00, $00, $00, $00, $00, $00, $00