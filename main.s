#include <xc.inc>
    
psect	code, abs
main:
    org 0x0
    goto setup
    org 0x100

setup:
    clrf TRISD, A
    
    clrf TRISE, A
    
    
    clrf LATE
    
    bcf	    LATD, 0
    bra led_test

bigdelay:
    movlw 0x00
dloop:
    decf    0x11,f,A
    subwfb  0x10,f,A
    bc	    dloop
    decfsz  0x12,A
    bra	    bigdelay
    return
    
led_test:
    // 0000 00ab  a: CP, b: OE
    
    incf LATE
    
    
    
    bcf	    LATD, 1
    
    movlw   high(0xFFFF)
    movwf   0x10, A
    movlw   low(0xFFFF)
    movwf   0x11, A
    movlw   0xFF
    movwf   0x12, A
    call    bigdelay
    
    bsf	    LATD, 1
    
    bra led_test
    
    end main

