.exportzp GAMEPAD_1
.exportzp GAMEPAD_STATUS
.exportzp A_STATUS, COLOR, COUNTER

.segment "ZEROPAGE"
  GAMEPAD_1:        .res 1
  GAMEPAD_STATUS:   .res 1
  A_STATUS:         .res 1
  COLOR:            .res 1
  COUNTER:          .res 1
