.include "data.s"
.include "graphics.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x26, SCREEN_HEIGH //  Guardamos la altura de la pantalla en x26
	mov x25, SCREEN_WIDTH // Guardamos el ancho de la pantalla en x25
 	mov x27, x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
	
	// color blanco
	movz x20, 0xFF,lsl 16
	movk x20, 0xFFFF,lsl 00

	mov x0,300
	mov x1,350
	BL pixel

	mov x1,40
	mov x2,60
	BL rectangulo

	mov x2,150 //radio del circulo
	mov x3,320 //centro en x
	mov x4,240 //centro en y
    bl circulo
	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
