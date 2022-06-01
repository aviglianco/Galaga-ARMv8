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
	mov x20,white

	mov x2,50 //radio del circulo
	mov x3,60 //centro en x
	mov x4,240 //centro en y
	bl circulo

	mov x2,50 //radio del circulo
	mov x3,160 //centro en x
	mov x4,240 //centro en y
	bl circulo
	

//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
