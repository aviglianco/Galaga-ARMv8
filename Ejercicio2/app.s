.include "data.s"
.include "graphics.s"
.include "background.s"


.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x25,SCREEN_WIDTH
	ldr x26,=buffer_secundary
 	mov x27,x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
prueba:
	bl background

	ldr x22,=ship_player
	ldur w0,[x22]
	ldur w1,[x22,4]
	mov x2,20
	ldr w3,white
	bl triangle

	bl frame_update

	ldur w0,[x22]
	ldur w1,[x22,4]
	//add w1,w1,1
	add w0,w0,1
	stur w0,[x22]
	stur w1,[x22,4]
	
	bl delay
	b prueba
//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop

delay:
        ldr x9, delay_time
    delay_loop:
        subs x9, x9, 1
        b.ne delay_loop
        br lr

frame_update:
        mov x9, SCREEN_WIDTH
        mov x10, SCREEN_HEIGH
    frame_loop:
		madd x12,x10,x25,x9 
        ldr w11, [x26,x12,lsl 2] // copio el color de cada pixel del frame secundario
        str w11, [x27,x12,lsl 2] // lo pego en el principal
		sub x9,x9,1
		cbnz x9, frame_loop
		//si x9 es 0, entonces vuelvo x9 a la derecha de la linea	
		mov x9, SCREEN_WIDTH
		sub x10,x10,1
		cbnz x10,frame_loop
        br lr // return
