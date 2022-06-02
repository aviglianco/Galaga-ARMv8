.include "data.s"
.include "graphics.s"

.globl main
actualizarFrameBuffer:
        mov x9, SCREEN_WIDTH
        mov x10, SCREEN_HEIGH
		mov x25, SCREEN_WIDTH
    loop_actualizarFrameBuffer:
		madd x12,x10,x25,x9
		//ldr w13, [x27, x12] 
        ldr w11, [x28,x12,lsl 2] // copio el color de cada pixel del frame secundario
        str w11, [x27,x12,lsl 2] // lo pego en el principal
		//str w13, [x28, x12]
		sub x9,x9,1
		cbnz x9, loop_actualizarFrameBuffer
		//si x9 es 0, entonces vuelvo x9 a la derecha de la linea	
		mov x9, SCREEN_WIDTH
		sub x10,x10,1
		cbz x10,end_loop_actualizarFrameBuffer
        b loop_actualizarFrameBuffer
    end_loop_actualizarFrameBuffer:
        br lr // return

crearDelay:
        mov x9, retardo
    loop_crearDelay:
        subs x9, x9, 1
        b.ne loop_crearDelay

        br lr

main:

	// X0 contiene la direccion base del framebuffer
	mov x26, SCREEN_HEIGH //  Guardamos la altura de la pantalla en x26
	mov x25, SCREEN_WIDTH // Guardamos el ancho de la pantalla en x25
	mov x27, x0
	ldr x28, =buffersecundario //guardamos la base del frame secundario

	//---------------- CODE HERE ------------------------------------


	movz x11, 0x0F, lsl 16
	movk x11, 0xF5ee, lsl 00 //color celeste

	mov x2, SCREEN_HEIGH         // Y Size 
	mov x0,0
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	str w11,[x28,x0]
	//str w11,[x27,x0]
	add x0,x0,4	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump

	//bl actualizarFrameBuffer

	mov x20,0xFFFFFF
	mov x21,60
	mov x22,240
	 
	mov x2,20 //ancho rect
	mov x3,30 //alto rect
	mov x0,300 //centro en y
	mov x1,50
	bl rectangle
	bl actualizarFrameBuffer


mainzz:
	mov x23,0
	mov x24,70
	zigzag:
		mov x2,21 //radio del circulo
		mov x3,x21 //centro en x
		mov x4,x22 //centro en y
		bl circulo
		bl actualizarFrameBuffer  //pego lo del secundario en el buffer principal
		
		movz x11, 0x0F, lsl 16
		movk x11, 0xF5ee, lsl 00 //color celeste
		bl clean_circle

		mov x2,21 //ancho rect
		mov x3,21 //alto rect
		mov x0,x21 //centro en y
		mov x1,50
		bl rectangle
		//decido si me voy para arriba o abajo
		add x21,x21,1
		add x23,x23,1
		sub x24,x24,1
		cmp x23,35
		B.LE down
		sub x22,x22,1
		b	del 	  //voy al final del loop
	down:
		add x22,x22,1
	del:
		bl crearDelay
		cbnz x24,zigzag
		b mainzz

//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
