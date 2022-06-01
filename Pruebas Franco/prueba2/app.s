
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ WHITE, 0x00FFFFFF

.globl main
main:
	//x25 cantidad de columnas
	//x26 cantidad de filas
	//x27 framebuffer base address
	mov x25, SCREEN_WIDTH
	mov x26, SCREEN_HEIGH
	mov x27, x0

	mov x0, #100
	mov x1, #50
	mov x2, #70
	mov x3, #70
	mov x4, WHITE
	bl rectangulo

	mov x0, #500
	mov x1, #50
	mov x2, #70
	mov x3, #70
	mov x4, WHITE
	bl rectangulo

	mov x0, #100
	mov x1, #350
	mov x2, #460
	mov x3, #60
	mov x4, WHITE
	bl rectangulo

InfLoop: b InfLoop

rectangulo:
	//x0 posicion x del rectangulo
	//x1 posicion y del rectangulo
	//x2 ancho del rectangulo
	//x3 alto del rectangulo
	//x4 color

	//Save return address
	sub sp,sp,#8
	stur lr,[sp]

	//Obtengo el pixel en x0
	bl pixel
	
	mov x9,x0 //Puntero del rectangulo
	rectangulofilaloop:
		mov x10,x2 //Restablezco el ancho de la fila
		rectangulocolloop:
			stur w4,[x9] //Seteo el color
			add x9,x9,4 //Avanzo a la siguiente posicion
			sub x10,x10,#1 //Resto 1 al ancho restante
			cbnz x10, rectangulocolloop //Si sigue habiendo ancho restante sigo
			sub x9,x9,x2, lsl #2 //Restablezco el puntero a la posicion inicial de la fila
			add x9,x9,x25, lsl #2 //Avanzo una fila al puntero
			sub x3,x3,#1 //Resto 1 a las filas restantes
			cbnz x3, rectangulofilaloop //Si sigue habiendo filas restantes sigo
	ldur lr,[sp] //Recupero el return address
	br lr //return

pixel:
	//x0 posicion x del pixel
	//x1 posicion y del pixel
	//retorno en x0
	madd x0, x1, x25, x0 //fila.|Columnas| + columna
	add x0,x27,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	br lr //return
	