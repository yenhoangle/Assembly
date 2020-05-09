#program that reads 3 integers, print them, stores them, and add them together and print the result
.data
	prompt: .asciiz "Please enter an integer: \n"
	confirm: .asciiz "The integers obtained are: \n"
	result: .asciiz "The result of adding the integers is: \n"
	newline: .asciiz "\n"
	x: .word 0
	y: .word 0
	z: .word 0
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
	
	#prints confirmation prompt
	li $v0, 4
	la $a0, confirm 
	syscall
	#prints the 3 integers obtained
	li $v0, 1
	lw $a0, x
	syscall
	li $v0, 4
	la $a0, newline 
	syscall
	li $v0, 1
	lw $a0, y
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 1
	lw $a0, z
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	
	#add the three integers together
	move $a1, $zero
	#current total + x
	lw $t0, x
	add $a1, $a1, $t0
	#current total + y
	lw $t0, y
	add $a1, $a1, $t0
	#current total + z
	lw $t0, z
	add $a1, $a1, $t0

	#prints results
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $a1
	syscall
	
	#exit
	li $v0, 10
	syscall
	