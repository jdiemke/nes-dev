.export DISABLE_APU_FRAME_IRQ

.proc DISABLE_APU_FRAME_IRQ
    LDX #$40
    STX $4017
    RTS
.endproc