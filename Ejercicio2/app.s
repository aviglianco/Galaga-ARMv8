.include "background.s"
.include "data.s"
.include "entry.s"
.include "graphics.s"
.include "logic.s"


.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x25,SCREEN_WIDTH
	ldr x26,=secondary_buffer
 	mov x27,x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
	
	bl entry_ships
animation:
	bl background

	bl bullet_draw
	
	bl draw_player_ship

	bl draw_all_enemy_ships
	
	bl frame_update
	
	bl update_playership
	
	bl update_bullet
	bl shoot_logic
	
	bl delay

	bl end_animation
	cbnz x0, animation

	bl exit_ship
	bl entry_ships
	b animation
