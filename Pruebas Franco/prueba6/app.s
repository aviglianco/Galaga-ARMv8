.include "data.s"
.include "graphics.s"
.include "background.s"
.include "logic.s"
.include "entry.s"


.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x25,SCREEN_WIDTH
	ldr x26,=buffer_secundary
 	mov x27,x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
loop:
	bl entry_ships
	bl exit
	mov w9,#440
	ldr x10,=ship_player
	stur w9,[x10,#4]

	mov w9,#40
	ldr x10,=ship_enemy1
	stur w9,[x10,#4]

	mov w9,#40
	ldr x10,=ship_enemy2
	stur w9,[x10,#4]

	mov w9,#40
	ldr x10,=ship_enemy3
	stur w9,[x10,#4]

	mov w9,#40
	ldr x10,=ship_enemy4
	stur w9,[x10,#4]

	b loop
//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop

exit:
	sub sp,sp,#16
	stur lr,[sp]
	ldr x9,delay_time
	stur x9,[sp,#8]
	ldr x9,=delay_time
	movz x10,#0xffff, lsl 0
	movk x10,#0xf, lsl 16
	stur x10,[x9]
	mov x16,#410
	exit_loop:
		bl background
		bl draw_player_ship

		ldr x10,=ship_player
		ldur x11,[x10,#4]
		sub x11,x11,#1
		stur x11,[x10,#4]

		sub x16,x16,#1
		bl frame_update
		bl delay
		cbnz x16,exit_loop
	ldur lr,[sp]
	ldur x9,[sp,#8]
	ldr x10,=delay_time
	stur x9,[x10]
	add sp,sp,#16
	br lr
