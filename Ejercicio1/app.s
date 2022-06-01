.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ square_width,     	300
.equ square_heigh,     	300
.equ circle_width,		3
.equ circle_heigth,		300
.equ half_height,       272

.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x26, SCREEN_HEIGH //  Guardamos la altura de la pantalla en x26
	mov x25, SCREEN_WIDTH // Guardamos el ancho de la pantalla en x25
 	mov x27, x0

	//---------------- CODE HERE ------------------------------------
	
/* 
	Utilizaremos los registros x9-x15 para almacenar los distintos colores
*/

	// color marrón tierra
	movz x10, 0x6C, lsl 16
	movk x10, 0x3A10, lsl 00

	//color azul noche
	movz x11, 0x0F, lsl 16
	movk x11, 0x1126, lsl 00

	// color verde pasto
	movz x12, 0x33, lsl 16
	movk x12, 0x6600, lsl 0 

	// color blanco
	movz x13, 0xFF,lsl 16
	movk x13, 0xFFFF,lsl 00

	// color rojo
	movz x14, 0xE3, lsl 16
	movk x14, 0x171A, lsl 0

	mov x9,0x280 //guardo 640 en hex para poder usarlo para calcular
				  // posiciones en el frame

/* Pintamos el cielo de color azul noche */
	mov x2, half_height         // Y Size 
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w11,[x0]	   // Set color of pixel N
	add x0,x0,4	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump

/* Pintamos el piso de color verde pasto */
		mov x2, SCREEN_HEIGH
		sub x2, x2, half_height
floor:
		mov x1, SCREEN_WIDTH         // X Size
	loop_f1:
		stur w12,[x0]	   // Set color of pixel N
		add x0,x0,4	   // Next pixel
		sub x1,x1,1	   // decrement X counter
		cbnz x1,loop_f1	   // If not end row jump
		sub x2,x2,1	   // Decrement Y counter
		cbnz x2,floor	   // if not last row, jump

/* Pintamos las estrellas en el cielo */
		mov x3, 0x0
		mov x4,0x0
		//add x0, xzr, x20
		mov x2, half_height
stars:
		madd x5,x4,x9,x3 //x5 = x9 +(x4*x9) calculo el inicio de la linea del cuadrado
		lsl x5,x5,2 //multiplico por 4
		add x0,x27,x5 //x0 = direc.base.frame + 4*(x+(y*640)) inicio de mi nueva linea
		mov x1, SCREEN_WIDTH

	loop_e2:
		stur w13, [x0]
		add x0, x0, 80
		sub x1, x1, 20
		cbnz x1, loop_e2
		add x3, x3, 12
		add x4, x4, 8
		sub x2, x2, 8
		cbnz x2, stars

/* Pintamos la estructura de la casa */
		mov x3, 0x50
		mov x4,0xF0
		mov x2, 120
house:
		madd x5,x4,x9,x3
		lsl x5,x5,2
		add x0,x27,x5
		mov x1,131
	loop_h1:
		stur w13,[x0]
		add x0,x0,4
		sub x1,x1,1
		cbnz x1,loop_h1
		add x4,x4,1
		sub x2,x2,1
		cbnz x2,house

/* Pintamos el techo de la casa */
		mov x3, 0x91
		mov x4, 0xD0
		mov x2, 38
		mov x6, 1
ceiling:
		madd x5,x4,x9,x3
		lsl x5,x5,2
		add x0,x27,x5
		add x1, xzr, x6
	loop_ceiling:
		stur w14,[x0]
		add x0,x0,4
		sub x1,x1,1
		cbnz x1,loop_ceiling
		add x6, x6, 4
		sub x2,x2,1
		add x4,x4,1 //aumento mi'y' para calcular la base de la linea de abajo
		sub x3, x3, 2
		cbnz x2,ceiling

/* Pintamos el fondo del camino */
		mov x3,0x8c
		mov x4,0x168
		mov x2,50
path:
		madd x5,x4,x9,x3
		lsl x5,x5,2
		add x0,x27,x5
		mov x1,12
	loop_p1:
		stur w10,[x0]
		add x0,x0,4
		sub x1,x1,1
		cbnz x1,loop_p1
		sub x2,x2,1	
		add x3,x3,1
		add x4,x4,1
		cbnz x2,path

/*
	Para ubicar nuestro 'pincel', usamos la fórmula:
	pincel (guardado en registro) = direc.base.frame + 4*(x+(y*640))
*/
	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
