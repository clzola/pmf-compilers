.text
	main:
		li $a0, 10
		jal suma
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		# Terminate
		li $v0, 10
		syscall
		
	# $a0 - number
	suma:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		beq $a0, 0, else
		subi $a0, $a0, 1
		jal suma
		
		lw $t0, 0($sp)
		add $v0, $v0, $t0
		
	  else:
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra