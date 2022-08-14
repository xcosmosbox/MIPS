.data
	my_list:	.word		0
	my_list_length:	.word		0
	my_list_index:	.word		0


	Hulk_SMASH:	.asciiz		"Hulk SMASH! >:("
	Hulk_Sad:	.asciiz		"Hulk Sad :("
	left:		.asciiz		"Hulk smashed "
	right:		.asciiz		" people"
	newLine: 	.asciiz 	"\n"












.text


	main:
		#copy $sp into $fp
		addi $fp,$sp,0
		
		#allocate 12 bytes for local var
		addi $sp,$sp,-12
		
		#initalize first local variable
		sw $zero,-12($fp) #my_list = 0
	
		#allocate memory for array
		addi $v0,$zero, 9
		addi $a0,$zero, 16 #(3*4)+4
		syscall
		#sw $v0,my_list #my_list = address # initalize the local variable
		sw $v0,-12($fp) #my_list = []
		addi $t0,$zero, 3 #t0=3
		sw $t0,($v0) #my_list.length = 3
		
		#init array
		lw $t0,-12($fp) #-4($fp) == my_list
		
		# init 10
		addi $t6,$t6,10
			#lw $t7,my_list_index
			#addi $t7,$t7,4
			#sw $t7,my_list_index
			#lw $s0,my_list_index
		#sw $t6,$s0($t0)
		sw $t6,4($t0)
		addi $t6,$zero,0 #reset $t6
		
		#init 14
		addi $t6,$t6,14
			#lw $t7,my_list_index
			#addi $t7,$t7,4
			#sw $t7,my_list_index
		#sw $t6,my_list_index($t0)
		sw $t6,8($t0)
		addi $t6,$zero,0 #reset $t6
		
		#init 16
		addi $t6,$t6,16
			#lw $t7,my_list_index
			#addi $t7,$t7,4
			#sw $t7,my_list_index
		#sw $t8,my_list_index($t0)
		sw $t6,12($t0)
		addi $t6,$zero,0 #reset $t6
		
		#init hulk_power
		addi $t7,$zero,15 #hulk_power = 15
		sw $t7,-8($fp)
		
		#init ret
		sw $zero,-4($fp) #ret = 0
		
		#call smash_or_sad(my_list, hulk_power)
		# push 2*4 = 8 bytes of arguments
		addi $sp,$sp,-8
		
		#arg1 = mylist
		lw $t7,-12($fp)#load mylist≠
		sw $t7,0($sp)#arg2 = mylit
		
		#arg2 = hulk_power
		lw $t7,-8($fp)#load hulk_power
		sw $t7,4($sp)#arg2 = hulk_power
		
		#link and goto smash_or_sad(my_list, hulk_power)
		jal smash_or_sad
		
		#remove arguments, they are no longer needed
		# 2*4=8
		addi $sp,$sp,8
		
		#store return value
		#result = 
		sw $v0,-4($fp)
		
		# print left
        	la $a0, left
        	addi $v0, $0, 4
        	syscall
        	
        	#print result
        	lw $a0, -4($fp)
        	addi $v0, $0, 1
        	syscall
        	
        	# print right
        	la $a0, right
        	addi $v0, $0, 4
        	syscall
		

	
	#exit the program
	# Print newline
	addi $v0, $0, 4
	la $a0, newLine
	syscall
	#addi $v0,$0,4
	#la $a0, TEST
	#syscall
	addi $v0, $0, 10
	syscall	
	
	
	
	smash_or_sad:
		#save $ra and $fp in stack
		addi $sp,$sp,-8 #make space
		sw $ra,4($sp)#save $ra
		sw $fp,0($sp)#save $fp
		
		#copy $sp to $fp
		addi $fp,$sp,0
		
		#Allocate local variable
		#5*4=20 bytes
		addi $sp,$sp,-20
		
		#init smash_count
		sw $zero,-20($fp) #smash_count=0
		
		#init i(maybe)
		sw $zero,-16($fp) #i=0
		
		#init len(the_list)   (maybe)
		
		
		#goto for-loop
		j print_loop
		
		
		
		print_loop:
			lw $t0,-16($fp)#i
			lw $t1,8($fp)#my_list
			lw $t2,($t1)#load the length of my_list
			slt $t0, $t0,$t2# check if i < len(my_list)
			beq $t0,$zero,end_print_loop#if the condition fails(fails means i>=len(my_list)), exit loop
			
			#get my_list[i] and i
			lw $t0,8($fp)
			lw $t1,-16($fp)#i
			sll $t1,$t1,2#i*4
			add $t0,$t0,$t1# &(my_list[i])-4
			lw $t3,4($t0)#t3 = my_list[i]
			
			#check the_list[i] <= hulk_power
			lw $t4,12($fp)#get hulk_power
			slt $s0,$t4,$t3
			bne $s0,$zero,print_SAD
			j print_SMASH
			
			
			
			
		print_SMASH:	
			# print a Hulk_SMASH
        		la $a0, Hulk_SMASH
        		addi $v0, $0, 4
        		syscall
        		
        		# print a newLine
        		la $a0, newLine
        		addi $v0, $0, 4
        		syscall
        		
        		#set smash_count
        		lw $t0,-20($fp)
        		addi $t0,$t0,1
        		sw $t0,-20($fp)
        		
        		# increment i
        		lw $t1, -16($fp)
        		addi $t1, $t1, 1
        		sw $t1, -16($fp)
        		
        		j print_loop
        		
        	print_SAD:	
			# print a Hulk_SAD
        		la $a0, Hulk_Sad
        		addi $v0, $0, 4
        		syscall
        		
        		# print a newLine
        		la $a0, newLine
        		addi $v0, $0, 4
        		syscall
        		
        		#set smash_count
        		#lw $t0,-20($fp)
        		#addi $t0,$t0,1
        		#sw $t0,-20($fp)
        		
        		# increment i
        		lw $t1, -16($fp)
        		addi $t1, $t1, 1
        		sw $t1, -16($fp)
        		
        		j print_loop
        		
        				
        	end_print_loop:
        		#return smash_count in $v0
        		lw $v0,-20($fp) #$v0=smash_count
        		
        		#remove local var
        		addi $sp,$sp,20
        		
        		#restore $fp and $ra
        		lw $fp,0($sp)
        		lw $ra,4($sp)
        		addi $sp,$sp,8 #deallocate
        		
        		#return to caller
        		jr $ra
			
			
			
			
			
		
		
		
		
		









	
	
	















