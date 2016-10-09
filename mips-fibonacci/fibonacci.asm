.text
	main:
		li $a0, 8
		jal fibonacci
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		# Terminate
		li $v0, 10
		syscall
		
	# $a0 - number
	fibonacci:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		bgt $a0, 2, else
		li $v0, 1
		j return
		
	  else:
		subi $a0, $a0, 1
		jal fibonacci

		lw $a0, 0($sp)
				
		addi $sp, $sp, -4
		sw $v0, 0($sp)
		
        subi $a0, $a0, 2
        jal fibonacci
		
		lw $t0, 0($sp)
		addi $sp, $sp, 4
		add $v0, $v0, $t0
		
	  return:
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra