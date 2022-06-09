.ifndef logic_s
.equ logic_s,0
.include "data.s"

update_playership:
	ldr x10,=navea
	ldur w0,[x10]
	ldur w1,[x10,4]
	add w0,w0,1
	stur w0,[x10]
	stur w1,[x10,4]
	br lr

.endif
