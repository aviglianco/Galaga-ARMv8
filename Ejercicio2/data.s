.ifndef data_s
.equ data_s, 0
/*
    Este archivo contiene toda la información relacionada con valores
    constantes que se utilizan repetidamente a lo largo del programa
*/

.data
buffersecundario: .skip BYTES_FRAMEBUFFER
retardo: .dword 0xffffff 
//arreglos de posiciones
navea: .word  320,400
naveen: .word 320,40

// Colores
.equ white,         0xFFFFFF
.equ red,           0xFF0000
green: .word         0x66CC00
purple: .word         0x990099
yellow: .word         0xFFFF00
.equ blue,         0x001933

// Pantalla 

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ BYTES_PER_PIXEL,    4   
.equ SCREEN_PIXELS,     SCREEN_HEIGH*SCREEN_WIDTH
.equ BYTES_FRAMEBUFFER,  SCREEN_PIXELS * BYTES_PER_PIXEL


.endif

