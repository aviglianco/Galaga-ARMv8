.ifndef entry_s
.equ entry_s,0

.include "background.s"
.include "data.s"
.include "graphics.s"
.include "logic.s"

/*
	En este archivo se gestiona la animación de entrada y salida de las naves
	a la pantalla.
*/

/*
	Se realiza la animación de entrada de las naves (tanto la del jugador como las enemigas).
*/
entry_ships:
	sub sp,sp,#8
	stur lr,[sp]
	mov x16,#30

	entry_ships_loop:
		bl background
		bl draw_player_ship

		ldr x9,=ship_player
		ldur w1,[x9,#4]
		sub x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy1
		ldr x17, =ship_enemy1
		bl draw_enemy_ship

		ldr x9,=ship_enemy1
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy2
		ldr x17, =ship_enemy2
		bl draw_enemy_ship

		ldr x9,=ship_enemy2
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy3
		ldr x17, =ship_enemy3
		bl draw_enemy_ship

		ldr x9,=ship_enemy3
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy4
		ldr x17,=ship_enemy4
		bl draw_enemy_ship

		ldr x9,=ship_enemy4
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		bl frame_update
		bl delay

		sub x16,x16,#1
		cbnz x16,entry_ships_loop
	ldur lr,[sp]
	add sp,sp,8
	br lr

.endif
 