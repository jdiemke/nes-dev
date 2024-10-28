.export INIT_NES
.import DISABLE_APU_FRAME_IRQ, WAIT_PPU_READY

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