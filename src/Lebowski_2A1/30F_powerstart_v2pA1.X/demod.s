.include "p30F4011.inc"
.include "defines.inc"

.text

.global demod
; w0: phase
; w4,5,6: phase currents
; after routine
; w8: I or X
; w9: Q or Y
;
; corrupted variables:
; w0, w1, w2, w3, w13
demod:
;--------------------------------------- find sin position in array [w13] before corrupting w0
    lsr w0, #7, w13
    bclr w13, #0
    bset w13, #11
;--------------------------------------- w3 = sin(120) * [w6-w5]
    sub w6, w5, w0
    mov #56756, w1
    mul.us w1, w0, w2
;--------------------------------------- w2 = w4 - [w5+w6]/2
    add w5, w6, w2
    asr w2, w2
    sub w4, w2, w2
;--------------------------------------- w9 = w2*sin(phi)
    mul.ss w2, [w13], w8
;--------------------------------------- w8 = w3*sin(phi)
    mul.ss w3, [w13], w0
	mov w1, w8
;--------------------------------------- to cos position in array
    add #128, w13
    bclr w13, #9
;--------------------------------------- w8 = w8 + w2*cos(phi)
    mul.ss w2, [w13], w0
    add w8, w1, w8
;--------------------------------------- w9 = w3*cos(phi) - w9
    mul.ss w3, [w13], w0
    sub w1, w9, w9
;--------------------------------------- end
    return
	
;*****************************************************************
/*
.global positive_demod
; w0: phase
; w4,5,6: phase currents
; after routine
; w8: I or X
; w9: Q or Y
;
; corrupted variables:
; w0, w1, w2, w3, w13
positive_demod:
;--------------------------------------- find sin position in array [w13] before corrupting w0
    lsr w0, #7, w13
    bclr w13, #0
    bset w13, #11
;--------------------------------------- w3 = sin(120) * [w5-w6]
    sub w5, w6, w0
    mov #56756, w1
    mul.us w1, w0, w2
;--------------------------------------- w2 = w4 - [w5+w6]/2
    add w5, w6, w2
    asr w2, w2
    sub w4, w2, w2
;--------------------------------------- w9 = w3*sin(phi)
    mul.ss w3, [w13], w8
;--------------------------------------- w8 = w2*sin(phi)
    mul.ss w2, [w13], w0
    mov w1, w8
;--------------------------------------- to cos position in array
    add #128, w13
    bclr w13, #9
;--------------------------------------- w9 = w2*cos(phi) - w9
    mul.ss w2, [w13], w0
    sub w1, w9, w9
;--------------------------------------- w8 = w8 + w3*cos(phi)
    mul.ss w3, [w13], w0
    add w8, w1, w8
;--------------------------------------- end
    return
*/
;*****************************************************************
/*
.global negative_demod
;
; same as positive demod
; but with w5 and w6 interchanged
; which only affects the calculation of (the internal variable) w3
;
; w0: phase
; w4,5,6: phase currents
; after routine
; w8: I or X
; w9: Q or Y
;
; corrupted variables:
; w0, w1, w2, w3, w13
negative_demod:
;--------------------------------------- find sin position in array [w13] before corrupting w0
    lsr w0, #7, w13
    bclr w13, #0
    bset w13, #11
;--------------------------------------- w3 = sin(120) * [w6-w5]
    sub w6, w5, w0
    mov #56756, w1
    mul.us w1, w0, w2
;--------------------------------------- w2 = w4 - [w5+w6]/2
    add w5, w6, w2
    asr w2, w2
    sub w4, w2, w2
;--------------------------------------- w9 = w3*sin(phi)
    mul.ss w3, [w13], w8
;--------------------------------------- w8 = w2*sin(phi)
    mul.ss w2, [w13], w0
    mov w1, w8
;--------------------------------------- to cos position in array
    add #128, w13
    bclr w13, #9
;--------------------------------------- w9 = w2*cos(phi) - w9
    mul.ss w2, [w13], w0
    sub w1, w9, w9
;--------------------------------------- w8 = w8 + w3*cos(phi)
    mul.ss w3, [w13], w0
    add w8, w1, w8
;--------------------------------------- end
    return

;*****************************************************************
*/
	
.end
