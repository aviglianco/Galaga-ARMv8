.ifndef data_s
.equ data_s, 0

/*
    Este archivo contiene toda la información relacionada con valores
    constantes que se utilizan repetidamente a lo largo del programa
*/

.data
buffer_secundary: .skip BYTES_FRAMEBUFFER
delay_time: .dword 0xffffA9
//arreglos de posiciones
/*
las naves tendran este arreglo de posiciones que se organizan de la sig forma:
ship_player <ejex>,<ejey>,<state>

ship_enemyX <ejex>,<ejey>,<dead>

dead se inicializa en 0 e indica si hay que pintar o no la correspondiente nave
cuando el campo <dead>==1, la nave no se pintara mas
 */
ship_player: .word  320,400
ship_enemy1: .word 135,40,0
ship_enemy2: .word 270,40,0
ship_enemy3: .word 405,40,0
ship_enemy4: .word 540,40,0
/*
tendremos un arreglo global para cada bala. la estructura
se organiza de la siguiente forma
bullet_X: <ejex>,<ejey>,<disparada>

al coincidir el eje x de ship_player
con el eje x de cualquier ship_enemyX, se disparara
la correspondiente bullet_X.
de modo que cuando la posicion del eje y coincida con el eje y de
la ship_enemyX, el campo <dead> se seteara en 1, indicando que
no hay que volver a pintarla
 */
bullet_one:  .word 0,0,0

// Colores
white: .word    0xFFFFFF
red: .word      0xFF0000
green: .word    0x66CC00
purple: .word   0x990099
yellow: .word   0xFFFF00
grey: .word     0x808080
blue: .word     0x001933

// Pantalla 

.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ BYTES_PER_PIXEL,    4   
.equ SCREEN_PIXELS,     SCREEN_HEIGH*SCREEN_WIDTH
.equ BYTES_FRAMEBUFFER,  SCREEN_PIXELS * BYTES_PER_PIXEL


.endif

