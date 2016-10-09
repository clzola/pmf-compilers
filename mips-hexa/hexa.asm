.data
	hexa_prefix: .asciiz "0x"

.text
	main:
		la $a0, hexa_prefix
		li $v0, 4
		syscall
	
		li $a0, 568412
		jal print_hexa
		
		# Terminate
		li $v0, 10
		syscall
		
	# $a0 - number
	print_hexa:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		beq $a0, 0, else1
		li $t0, 16
		div $a0, $t0
		
		addi $sp, $sp, -4
		mfhi $t0
		sw $t0, 0($sp)
		
		mflo $a0
		jal print_hexa
		
		lw $t0, 0($sp)
		addi $sp, $sp, 4
		
		move $a0, $t0
		jal print_hexa_digit
		
	  else1:
		
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra
		
	# $a0 - digit
	print_hexa_digit:
		bgt $a0, 9, else2
		li $v0, 1
		syscall
		j return_digit
		
	  else2:
	  	addi $a0, $a0, 87
	  	li $v0, 11
	  	syscall
	  	
	  return_digit:
		jr $ra