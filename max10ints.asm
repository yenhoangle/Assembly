.data 
	prompt: .asciiz "Please enter an integer: "
	confirm: .asciiz "The integer you entered was: "
	newline: .asciiz "\n"
	result: .asciiz "The maximum integer is: "
.text
main:
	#init values
	li $t0, -10000
	li $s0, 1
	li $s1, 10 
while:
	bgt $s0, $s1, out
	addi $s0, $s0, 1
	
	#get number from user
	li $v0, 4
	la $a0, prompt
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 #t1 stores input
	jal conf
	jal comp
	j while
out:
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	b exit
exit:
	li $v0, 10
	syscall
	
comp:
	bgt $t0, $t1, done
	move $t0, $t1
done: 
	jr $ra
conf:
	li $v0, 4
	la $a0, confirm
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
	


	
	
	
	