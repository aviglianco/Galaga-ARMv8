.include "data.s"
.include "graphics.s"
.include "background.s"


.globl main
crearDelay:
        ldr x9, retardo
    loop_crearDelay:
        subs x9, x9, 1
        b.ne loop_crearDelay
        br lr

actualizarFrameBuffer:
        mov x9, SCREEN_WIDTH
        mov x10, SCREEN_HEIGH
    loop_actualizarFrameBuffer:
		madd x12,x10,x25,x9 
        ldr w11, [x26,x12,lsl 2] // copio el color de cada pixel del frame secundario
        str w11, [x27,x12,lsl 2] // lo pego en el principal
		sub x9,x9,1
		cbnz x9, loop_actualizarFrameBuffer
		//si x9 es 0, entonces vuelvo x9 a la derecha de la linea	
		mov x9, SCREEN_WIDTH
		sub x10,x10,1
		cbz x10,end_loop_actualizarFrameBuffer
        b loop_actualizarFrameBuffer
    end_loop_actualizarFrameBuffer:
        br lr // return

main:
	// X0 contiene la direccion base del framebuffer
	mov x25,SCREEN_WIDTH
	ldr x26,=buffersecundario
 	mov x27,x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
prueba:
	bl background

	ldr x22,=navea
	ldur w0,[x22]
	ldur w1,[x22,4]
	mov x3,20
	mov x2,20
	mov x4,white
	bl triangle

	bl actualizarFrameBuffer

	ldur w0,[x22]
	ldur w1,[x22,4]
	//add w1,w1,1
	add w0,w0,1
	stur w0,[x22]
	stur w1,[x22,4]
	
	bl crearDelay
	b prueba
//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
