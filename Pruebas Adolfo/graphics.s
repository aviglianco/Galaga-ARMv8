.ifndef graphics_s
.include "data.s"
/* 
    Este archivo contiene todas las funciones relacionadas con
    los gráficos que se realizan en el programa.
*/


/*
    Realiza los cálculos necesarios para generar un "puntero" al pixel deseado.

    Parámetros:
        w20 = color 
        x0 = Posición deseada en x
        x1 = Posición deseada en y
    Retorno:
        x0 = Puntero al pixel en las coordenadas deseadas
*/
pintar_pixel:
    mov x25, SCREEN_WIDTH
    madd x25,x1,x25,x0
    str w20,[x28,x25,lsl 2] //pintamoms en el buffer secundario
	BR LR

/* 
    Dibuja un rectángulo en pantalla.
    Se utilizan los registros x9 y x10 como registros internos para las operaciones
    Parámetros:
        
        x0 = Posición x del centro
        x1 = Posición y del centro
        x2 = Ancho del rectángulo
        x3 = Alto del rectángulo
        x20 = Color del rectángulo
    Retorno:
        Se modifican los registros x0, x2, x3, x9 y x10
*/
pixel:
    mov x25, SCREEN_WIDTH
	madd x0, x1, x25, x0 //fila.|Columnas| + columna
	add x0,x28,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	br lr //return

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
			stur w20,[x9] //Seteo el color
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
        x20 = color del circulo 
        x2 = radio del circulo
        x3 = posicion del centro en X
        x4 = posicion del centro en y
    Retorno:
        modifica:
            x21 x22 x2 
*/
circulo:
            sub sp,sp,8
            stur lr,[sp]
            //guardo la direccion de retorno
            sub x9, x3,x2  // calcula la esquina izquierda (en x) del cuadrado a recorrer para pintar el circulo 
            sub x10, x4,x2  // calcula la altura de la esquina izq(en y) para el cuadrado  
            
            mul x6,x2,x2 //radio al cuadrado
            add x7,x2,x2 //contador ancho del cuadrado
            add x8,x2,x2 //contador alto del cuadrado
            b loop_c
    movy:
            add x10,x10,1 //aumento el y
            sub x9,x3,x2 //vuelvo a setear x
            sub x8,x8,1   //le quito uno a mi contador de eje y
            add x7,x2,x2  //vuelvo a setear el ancho 
            cbz x8, c_ret 
            b loop_c
    circle_l: 
            mov x0,x9
            mov x1,x10
            BL pintar_pixel
            add x9,x9,1 //me muevo al sig x
            sub x7,x7,1  //actualizo contador del ancho
            cbz x7, movy // si me pase de linea, reseteo al ancho de vuelta y aumento mi 'y' y vuelvo a setear x en el inicio de la linea
    loop_c:
            sub x14,x9,x3 //x-a
            sub x15,x10,x4 //y-b
            madd x14,x14,x14,xzr //(x-a)^2
            madd x15,x15,x15,xzr //(y-b)^2
            add x16,x14,x15 // (x- a)^2 + (y - b)^2
            cmp x16,x6 // (x- a)^2 + (y - b)^2 <= r^2
            B.LE circle_l //si pertenece al circulo pintamos
            sub x7,x7,1
            add x9,x9,1
            cbnz x7,loop_c
            cbz x7, movy
c_ret:
        ldur lr,[sp]
        BR LR

/*Elimina el circulo de la pantalla.

    Parámetros:
        x11 = decir que poner en lugar del circulo
        x2 = radio del circulo
        x3 = posicion del centro en X
        x4 = posicion del centro en y
    Retorno:

*/
clean_circle:
        sub x9, x3,x2  // calcula la esquina izquierda (en x) del cuadrado a recorrer para borrar el circulo 
        sub x10, x4,x2  // calcula la altura de la esquina izq(en y) para el cuadrado  
        add x7,x2,x2 //contador ancho del cuadrado
        add x8,x2,x2 //contador alto del cuadrado
    loop_clean:
		madd x12,x10,x25,x9
        str w11, [x28, x12,lsl 2] // pinto de negro donde estaba el circulo
        //ldr w11, [x28, x12,lsl 2] // copio el color de cada pixel del frame secundario
        //str w11, [x27, x12,lsl 2] // lo pego en el principal
		add x9,x9,1
        sub x7,x7,1
        cbz x7,resetear
		b loop_clean
	resetear:
        sub x9, x3,x2 //vuelvo a setear el x
		add x10,x10,1
        add x7,x2,x2 //reseteo contador de eje x
        sub x8,x8,1
		cbz x8,end_loop_clean
        b loop_clean
    end_loop_clean:
        br lr // return


.endif
