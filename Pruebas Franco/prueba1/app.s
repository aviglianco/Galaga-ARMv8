
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


.globl main
main:
	//x19 color cielo 66B2FF, x20 color cactus 00CC00, x21 color arena CCCC00
	//x25 cantidad de columnas
	//x26 cantidad de filas
	//x27 framebuffer base address
	mov x25, SCREEN_WIDTH
	mov x26, SCREEN_HEIGH
	mov x27, x0
	movz x19,0xB2FF, LSL 0
	movk x19,0x66,LSL 16

	movz x20,0xCC00, LSL 0

	movz x21,0xCC00, LSL 0
	movk x21,0xCC,LSL 16

	//x22 Pos Horizonte
	mov x22,250
	mul x22,x22,x25
	lsl x22,x22,2
	add x22,x22,x27

	//Seteo cielo
	BL cielo

	//Seteo arena
	BL arena

	mov x0,300
	mov x1,350
	BL pixel

	mov x1,40
	mov x2,60
	BL cactus


InfLoop: 
	b InfLoop


cielo:
	mov x10, x27 //Posicion del pixel 
cieloloop:
	stur w19,[x10] //Cargo el color
	add x10,x10,4 //Avanzo al siguiente pixel
	cmp x10,x22
	b.ne cieloloop //Me detengo en el horizonte
	BR LR //Return


arena:
	mov x10, x22 //Posicion del pixel

	//Posicion final
	mul x11,x25,x26
	sub x11,x11,#1
	lsl x11,x11,#2
	add x11,x11,x27

arenaloop:
	stur w21,[x10] //Cargo el color
	add x10,x10,4 //Avanzo al siguiente pixel
	cmp x10,x11
	b.ne arenaloop //Me detengo en el final
	BR LR //Return

cactus:
	//x0 posicion del cactus
	//x1 ancho del cactus
	//x2 alto del cactus
	mov x9,x0 //puntero del cactus
	cactusfilaloop:
		mov x10,x1 //Restablezco el ancho de la fila
		cactuscolloop:
			stur w20,[x9] //Seteo el color
			add x9,x9,4 //Avanzo a la siguiente posicion
			sub x10,x10,#1 //Resto 1 al ancho restante
			cbnz x10, cactuscolloop //Si sigue habiendo ancho restante sigo
			sub x9,x9,x1, lsl #2 //Restablezco el puntero a la posicion inicial de la fila
			add x9,x9,x25, lsl #2 //Avanzo una fila al puntero
			sub x2,x2,#1 //Resto 1 a las filas restantes
			cbnz x2, cactusfilaloop //Si sigue habiendo filas restantes sigo
	BR LR //return

pixel:
	//x0 posicion x del pixel
	//x1 posicion y del pixel
	//retorno en x0
	mul x1,x1,x25 //fila.|Columnas|
	add x0,x0,x1 //fila.|Columnas| + columna
	add x0,x27,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	BR LR //return

