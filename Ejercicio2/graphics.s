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
	madd x0, x1, x25, x0 //fila.|Columnas| + columna
	add x0,x27,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	br lr //return

/* 
    Dibuja un rectángulo en pantalla.

    Se utilizan los registros x9 y x10 como registros internos para las operaciones

    Parámetros:
        
        x0 = Posición x del centro
        x1 = Posición y del centro
        x2 = Ancho del rectángulo
        x3 = Alto del rectángulo
        x4 = Color del rectángulo
    Retorno:
        Se modifican los registros x0, x2, x3, x9 y x10
*/
rectangle:
	//Save return address
	sub sp,sp,#8
	stur lr,[sp]

    //Me muevo hacia la esquina izquierda desde donde voy a pintar
    sub x0,x0,x2,lsr #1 //Me muevo a la izquierda desde donde voy a pintar
	sub x1,x1,x3,lsr #1 //Me muevo hacia arriba desde donde voy a pintar
    
    //Obtengo el pixel en x0
	bl pixel

	mov x9,x0 //Puntero del rectangulo
	rectangle_row_loop:
		mov x10,x2 //Restablezco el ancho de la fila
		rectangle_col_loop:
			stur w4,[x9] //Seteo el color
			add x9,x9,4 //Avanzo a la siguiente posicion
			sub x10,x10,#1 //Resto 1 al ancho restante
			cbnz x10, rectangle_col_loop //Si sigue habiendo ancho restante repito
			sub x9,x9,x2, lsl #2 //Restablezco el puntero a la posicion inicial de la fila
			add x9,x9,x25, lsl #2 //Avanzo una fila al puntero
			sub x3,x3,#1 //Resto 1 a las filas restantes
			cbnz x3, rectangle_row_loop //Si sigue habiendo filas restantes repito
	ldur lr,[sp] //Recupero el return address
	br lr //return

/* 
    Dibuja un círculo en la pantalla.

    Parámetros:
        x0 = posicion del centro en x
        x1 = posicion del centro en y
        x2 = radio del circulo
        x3 = color del circulo

    Retorno:
        modifica los registros x0,x1,x4,x5,x6,x7,x8,x9 y x10
            
*/
circulo:
            sub sp,sp,8
            stur lr,[sp]
            //guardo la direccion de retorno

            mov x4, x0 //paso x0 a x4 para poder usar x0 como parametro mas tarde
            mov x5, x1 //paso x1 a x5 para poder usar x1 como parametro mas tarde

            sub x9, x4,x2  // calcula la esquina izquierda (en x) del cuadrado a recorrer para pintar el circulo 
            sub x10, x5,x2  // calcula la altura de la esquina izq(en y) para el cuadrado  
            

            mul x6,x2,x2 //radio al cuadrado
            add x7,x2,x2 //contador ancho del cuadrado
            add x8,x2,x2 //contador alto del cuadrado
    loop_c:
            sub x0,x9,x4 //x-a
            sub x1,x10,x5 //y-b
            madd x0,x0,x0,xzr //(x-a)^2
            madd x0,x1,x1,x0 //(x-a)^2 + (y-b)^2
            cmp x0,x6 // (x- a)^2 + (y - b)^2 <= r^2
            B.LE circle_l //si pertenece al circulo pintamos
            sub x7,x7,1
            add x9,x9,1
            cbnz x7,loop_c
    movy:
            add x10,x10,1 //aumento el y
            sub x9,x4,x2 //vuelvo a setear x
            sub x8,x8,1   //le quito uno a mi contador de eje y
            add x7,x2,x2  //vuelvo a setear el ancho 
            cbnz x8, loop_c 
    c_ret:
        ldur lr,[sp]
        BR LR
    
    circle_l: 
            mov x0,x9
            mov x1,x10
            BL pixel
            stur w3,[x0]
            add x9,x9,1 //me muevo al sig x
            sub x7,x7,1  //actualizo contador del ancho
            cbz x7, movy // si me pase de linea, reseteo al ancho de vuelta y aumento mi 'y' y vuelvo a setear x en el inicio de la linea
            b loop_c
    

.endif
