.ifndef graphics_s
.include "data.s"
/* 
    Este archivo contiene todas las funciones relacionadas con
    los gráficos que se realizan en el programa.
*/


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
        x20 = color del circulo 
        x2 = radio del circulo
        x3 = posicion del centro en X
        x4 = posicion del centro en y
    Retorno:
        modifica:
            x21 x22 x2 
*/
circulo:
            sub x21, x3,x2  // calcula la esquina izquierda (en x) del cuadrado a recorrer para pintar el circulo 
            sub x22, x4,x2  // calcula la altura de la esquina izq(en y) para el cuadrado  
            
            mul x6,x2,x2 //radio al cuadrado
            add x7,x2,x2 //contador ancho del cuadrado
            add x8,x2,x2 //contador alto del cuadrado
            b loop_c
    movy:
            add x22,x22,1 //aumento el y
            sub x21,x3,x2 //vuelvo a setear x
            sub x8,x8,1   //le quito uno a mi contador de eje y
            add x7,x2,x2  //vuelvo a setear el ancho 
            cbz x8, c_ret 
            b loop_c
    circle_l: 
            mov x0,x21
            mov x1,x22
            BL pixel
            stur w20,[x0]
            add x21,x21,1 //me muevo al sig x
            sub x7,x7,1  //actualizo contador del ancho
            cbz x7, movy // si me pase de linea, reseteo al ancho de vuelta y aumento mi 'y' y vuelvo a setear x en el inicio de la linea
    loop_c:
            sub x14,x21,x3 //x-a
            sub x15,x22,x4 //y-b
            madd x14,x14,x14,xzr //(x-a)^2
            madd x15,x15,x15,xzr //(y-b)^2
            add x16,x14,x15 // (x- a)^2 + (y - b)^2
            cmp x16,x6 // (x- a)^2 + (y - b)^2 <= r^2
            B.LE circle_l //si pertenece al circulo pintamos
            sub x7,x7,1
            add x21,x21,1
            cbnz x7,loop_c
            cbz x7, movy
c_ret:
        BR LR

.endif
