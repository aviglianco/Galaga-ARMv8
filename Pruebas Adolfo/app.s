.include "data.s"
.include "graphics.s"

.globl main
crearDelay:
        ldr x9, retardo
    loop_crearDelay:
        subs x9, x9, 1
        b.ne loop_crearDelay

        br lr
main:
	// X0 contiene la direccion base del framebuffer
	mov x26, SCREEN_HEIGH //  Guardamos la altura de la pantalla en x26
	mov x25, SCREEN_WIDTH // Guardamos el ancho de la pantalla en x25
 	mov x27, x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
	
	// color blanco
	mov x20,white
	mov x23,60
	
	circulo_m:

		mov x2,50 //radio del circulo
		mov x3,x23 //centro en x
		mov x4,240 //centro en y
		bl circulo

		add x23,x23,1
		bl crearDelay
		b circulo_m
		//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
