.ifndef data_s
.equ data_s, 0
/*
    Este archivo contiene toda la información relacionada con valores
    constantes que se utilizan repetidamente a lo largo del programa
*/

.data
retardo: .dword 0xffffff
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

.endif

