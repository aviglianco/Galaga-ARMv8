rectangulo:
	//x0 posicion del rectangulo
	//x1 ancho del rectangulo
	//x2 alto del rectangulo
	mov x9,x0 //puntero del rectangulo
	rectangulofilaloop:
		mov x10,x1 //Restablezco el ancho de la fila
		rectangulocolloop:
			stur x20,[x9] //Seteo el color
			add x9,x9,4 //Avanzo a la siguiente posicion
			sub x10,x10,#1 //Resto 1 al ancho restante
			cbnz x10, rectangulocolloop //Si sigue habiendo ancho restante sigo
			sub x9,x9,x1, lsl #2 //Restablezco el puntero a la posicion inicial de la fila
			add x9,x9,x25, lsl #2 //Avanzo una fila al puntero
			sub x2,x2,#1 //Resto 1 a las filas restantes
			cbnz x2, rectangulofilaloop //Si sigue habiendo filas restantes sigo
	BR LR //return

pixel:
	//x0 posicion x del pixel
	//x1 posicion y del pixel
	//retorno en x0
	mul x1,x1,x25 //fila.|Columnas|
	add x0,x0,x1 //fila.|Columnas| + columna
	add x0,x27,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	BR LR //return