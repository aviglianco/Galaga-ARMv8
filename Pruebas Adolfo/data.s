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

// Pantalla 
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.endif

