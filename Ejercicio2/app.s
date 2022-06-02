.include "data.s"
.include "graphics.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x26, SCREEN_HEIGH //  Guardamos la altura de la pantalla en x26
	mov x25, SCREEN_WIDTH // Guardamos el ancho de la pantalla en x25
 	mov x27, x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
	
	
	mov x0,50
	mov x1,240
	mov x2,100
	mov x3,100
	mov x4,red
	bl rectangle
	
	mov x0,50 //centro en x
	mov x1,240 //centro en y
	mov x2,50 //radio del circulo
	mov x3,white //color blanco
	bl circulo

	mov x0,160
	mov x1,240
	mov x2,100
	mov x3,100
	mov x4,white
	bl rectangle

	mov x0,160 //centro en x
	mov x1,240 //centro en y
	mov x2,50 //radio del circulo
	mov x3,red //color blanco
	bl circulo

	mov x0,270
	mov x1,240
	mov x2,100
	mov x3,100
	mov x4,white
	bl rectangle

	mov x0,270 //centro en x
	mov x1,240 //centro en y
	mov x2,50 //radio del circulo
	mov x3,xzr //color negro
	bl circulo

	mov x0,380
	mov x1,240
	mov x2,100
	mov x3,100
	mov x4,red
	bl rectangle

	mov x0,380 //centro en x
	mov x1,240 //centro en y
	mov x2,50 //radio del circulo
	mov x3,xzr //color negro
	bl circulo
	

//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
