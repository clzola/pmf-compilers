.text
	main:
		li $a0, 5
		jal factoriel
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		# Termiante
		li $v0, 10
		syscall
		
	# $a0 - number
	factoriel:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		bne $a0, 1, else
		li $v0, 1
		j return
		
	  else:
	  	subi $a0, $a0, 1
	  	jal factoriel
	  	
	  	lw $a0, 0($sp)
	  	mulo $v0, $a0, $v0
	  
	  return:
	  	lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra