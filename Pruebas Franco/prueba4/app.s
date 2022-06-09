.include "data.s"
.include "graphics.s"

.globl main
main:
	mov x25, SCREEN_WIDTH // Guardamos el ancho de la pantalla en x25
	mov x26, SCREEN_HEIGH //  Guardamos la altura de la pantalla en x26
 	mov x27, x0	// Guardamos la dirección base del framebuffer en x27

	bl background

	mov x19, #30
	mov x20, #90

	mov w0,#320
	mov w1,#240

	ldr x21,=nave

	stur w0,[x21]
	stur w1,[x21,#4]

	mov x22,#50
movimiento:
	bl background
	ldur w0,[x21]
	ldur w1,[x21,#4]
	mov x2,x19
	mov x3,x20
	mov x4, white
	bl rectangle
	
	ldur w1,[x21,#4]
	add w1,w1,#1
	stur w1,[x21,#4]

	bl delay
	subs x22,x22,#1
	b.ne movimiento
InfLoop: b InfLoop

delay:
	movz x9,#0xFFFF,lsl 0
	movk x9,#0xFF,lsl 16
	delay_loop:
		subs x9,x9,#1
		b.ne delay_loop
	br lr
