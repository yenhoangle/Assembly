#program that reads 3 integers, performs W= (X-Y)(X+Y)(X-Z), stores in W, prints W
.data
	prompt: .asciiz "Please enter an integer: \n"
	result: .asciiz "The result of w = (x-y)(x+y)(x-z) is: \n"
	x: .word 0
	y: .word 0
	z: .word 0
	w: .word 0
.text
	#prints prompt
	li $v0, 4
	la $a0, prompt 
	syscall
	#reads an integer
	li $v0, 5
	syscall
	#stores an integer
	move $t0, $v0
	sw $t0, x($zero)

	#prints prompt
	li $v0, 4
	la $a0, prompt 
	syscall
	#reads an integer
	li $v0, 5
	syscall
	#stores an integer
	move $t0, $v0
	sw $t0, y($zero)
	
	#prints prompt
	li $v0, 4
	la $a0, prompt 
	syscall
	#reads an integer
	li $v0, 5
	syscall
	#stores an integer
	move $t0, $v0
	sw $t0, z($zero)
	
	#load into registers
	lw $a1, x
	lw $a2, y
	lw $a3, z
	#perform x-y
	sub $t1, $a1, $a2
	#perform x+y
	add $t2, $a1, $a2
	#perform x-z
	sub $t3, $a1, $a3
	#perform (x-y)(x+y)(x-z)
	mul $s1, $t1, $t2
	mul $s2, $s1, $t3
	
	#store in w
	sw $s2, w($zero)
	#print W
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	lw $a0, w
	syscall
	
	#exit
	li $v0, 10
	syscall
	
	
	
	