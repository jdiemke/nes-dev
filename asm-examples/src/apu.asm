.export DISABLE_APU_FRAME_IRQ
.export DISABLE_DMC_INTERRUPTS

APU_MOD_CTRL = $4010
APU_FRAME    = $4017

.proc DISABLE_APU_FRAME_IRQ
    LDX #$40
    STX APU_FRAME
    RTS
.endproc

.proc DISABLE_DMC_INTERRUPTS
    LDX #0
    STX APU_MOD_CTRL    ; disable DMC interrupts
    RTS
.endproc
