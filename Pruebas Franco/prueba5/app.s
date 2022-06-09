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
	
	bl entry_ships
	
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


entry_ships:
	sub sp,sp,#8
	stur lr,[sp]
	mov x16,#30

	entry_ships_loop:
		bl background
		ldr x9,=ship_player
		ldur w0,[x9]
		ldur w1,[x9,#4]
		mov x2, #30
		mov x3, #60
		ldr x4,white
		bl rectangle

		ldr x9,=ship_player
		ldur w1,[x9,#4]
		sub x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy1
		ldur w0,[x9]
		ldur w1,[x9,#4]
		mov x2, #30
		mov x3, #60
		ldr x4,red
		bl rectangle

		ldr x9,=ship_enemy1
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy2
		ldur w0,[x9]
		ldur w1,[x9,#4]
		mov x2, #30
		mov x3, #60
		ldr x4,red
		bl rectangle

		ldr x9,=ship_enemy2
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy3
		ldur w0,[x9]
		ldur w1,[x9,#4]
		mov x2, #30
		mov x3, #60
		ldr x4,red
		bl rectangle

		ldr x9,=ship_enemy3
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy4
		ldur w0,[x9]
		ldur w1,[x9,#4]
		mov x2, #30
		mov x3, #60
		ldr x4,red
		bl rectangle

		ldr x9,=ship_enemy4
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		bl frame_update
		bl delay

		sub x16,x16,#1
		cbnz x16,entry_ships_loop
	ldur lr,[sp]
	add sp,sp,8
	br lr
