.data
 	Message: .asciiz "Hello : " 
 	Input: .space  15 #reserving space for 15 chars
 	newline: .asciiz "\n" 
 	Name: .asciiz "Please enter your name\n"         
.text  
	li $v0,4 
	la $a0, Name #prompt user for entering a name 
	syscall    
	li $v0, 8 #for reading array of char  
	la $a0, Input  
	li $a1, 15 #you have to specify the max number of chars #that you read  
	syscall    
	li $v0, 4    # loading $vo with 4 is used for printing  #string   
	la $a0, Message   
	syscall    
	li $v0,4 
	la $a0, Input 
	syscall  
	li $v0, 4 
	la $a0, newline 
	syscall       
 	li $v0,10 
 	syscall     #this is to exit