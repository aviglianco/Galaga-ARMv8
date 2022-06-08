.ifndef data_s
.equ data_s, 0
/*
    Este archivo contiene toda la información relacionada con valores
    constantes que se utilizan repetidamente a lo largo del programa
*/

.data
//retardo: .dword 0xffffff
.equ retardo, 0xffffff 
// Colores
.equ white,        0xFFFFFF
.equ black,         0x000000
.equ orange,        0xED8B2E

// Pantalla 
buffersecundario: .skip BYTES_FRAMEBUFFER

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ BYTES_PER_PIXEL,    4   
.equ SCREEN_PIXELS,     SCREEN_HEIGH*SCREEN_WIDTH
.equ BYTES_FRAMEBUFFER,  SCREEN_PIXELS * BYTES_PER_PIXEL

.endif

