.ifndef graphics_s

/* 
    Este archivo contiene todas las funciones relacionadas con
    los gráficos que se realizan en el programa.
*/

.include "data.s"

/*
    Realiza los cálculos necesarios para generar un "puntero" al pixel deseado.

    Parámetros:
        x0 = Posición deseada en x
        x1 = Posición deseada en y
    Retorno:
        x0 = Puntero al pixel en las coordenadas deseadas
*/
pixel:
	mul x1,x1,x25 //fila.|Columnas|
	add x0,x0,x1 //fila.|Columnas| + columna
	add x0,x27,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	BR LR

/* 
    Dibuja un rectángulo en pantalla.

    Se utilizan los registros x9 y x10 como registros internos para las operaciones

    Parámetros:
        x20 = Color del rectángulo
        x0 = Posición de la esquina izquierda
        x1 = Ancho del rectángulo
        x2 = Alto del rectángulo
    Retorno:
        Se modifican los registros x2, x9 y x10
*/
rectangulo:
	mov x9,x0 //puntero del rectangulo
	rectangulofilaloop:
		mov x10,x1 //Restablezco el ancho de la fila
		rectangulocolloop:
			stur w20,[x9] //Seteo el color
			add x9,x9,4 //Avanzo a la siguiente posicion
			sub x10,x10,#1 //Resto 1 al ancho restante
			cbnz x10, rectangulocolloop //Si sigue habiendo ancho restante sigo
			sub x9,x9,x1, lsl #2 //Restablezco el puntero a la posicion inicial de la fila
			add x9,x9,x25, lsl #2 //Avanzo una fila al puntero
			sub x2,x2,#1 //Resto 1 a las filas restantes
			cbnz x2, rectangulofilaloop //Si sigue habiendo filas restantes sigo
	BR LR

/* 
    Dibuja un círculo en la pantalla.

    Parámetros:

    Retorno:

*/