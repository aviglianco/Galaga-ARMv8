.include "data.s"
.include "graphics.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
	ldr x26, SCREEN_HEIGH //  Guardamos la altura de la pantalla en x26
	ldr x25, SCREEN_WIDTH // Guardamos el ancho de la pantalla en x25
 	mov x27, x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
	





	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
