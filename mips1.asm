.data 
	MyMessage: .asciiz "Hello\n"
	next: .asciiz "John\n"
.text
	Li $v0, 4 #put 4 in $v0
	La $a0, MyMessage
	syscall 
	Li $v0, 4
	La, $a0, next
	syscall