.ifndef data_s
.equ data_s, 0

/*
    Este archivo contiene toda la información relacionada con valores
    constantes que se utilizan repetidamente a lo largo del programa
*/

.data
buffer_secundary: .skip BYTES_FRAMEBUFFER
delay_time: .dword 0xfffff
//arreglos de posiciones
ship_player: .word  320,400
ship_enemy1: .word 135,40
ship_enemy2: .word 270,40
ship_enemy3: .word 405,40
ship_enemy4: .word 540,40

// Colores
white: .word    0xFFFFFF
red: .word      0xFF0000
green: .word    0x66CC00
purple: .word   0x990099
yellow: .word   0xFFFF00
grey: .word     0x808080
blue: .word     0x001933

// Pantalla 

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ BYTES_PER_PIXEL,    4   
.equ SCREEN_PIXELS,     SCREEN_HEIGH*SCREEN_WIDTH
.equ BYTES_FRAMEBUFFER,  SCREEN_PIXELS * BYTES_PER_PIXEL


.endif

