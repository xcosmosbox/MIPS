.data

	newline:	.asciiz		"\n"
	space:		.asciiz		" "

.text

jal main

addi $v0, $0, 10
syscall



insertion_sort:
		# memory diagram
            ###########################
            # key         : -16($fp)  #
            # j           : -12($fp)  #
            # i           : -8($fp)   #
            # length      : -4($fp)   #
            # fp          : ($fp)     #
            # ra          : 4($fp)    #
            # arr         : 8($fp)    #
            ###########################
            
	# make space to store $fp and $ra
        addi $sp, $sp, -8
        sw $fp, ($sp)
        sw $ra, 4($sp)
        
        # copy $sp to $fp
        addi $fp, $sp, 0
	
	#four local variable
	addi $sp, $sp, -16

	#init length
	lw $t0, 8($fp)# load the address of the arr
        lw $t1, ($t0) # load the length of the arr == 5
        sw $t1,-4($fp)# length = 5
        
        #init i
        addi $t0,$0,1
        sw $t0,-8($fp)
        
        #goto outer_for_loop
        j outer_for_loop
        
        
        outer_for_loop:
        	#check i<length
        	lw $t0,-8($fp)#load i
        	lw $t1,-4($fp)#load length
        	slt $s0,$t0,$t1#if i<length, then s0=1
        	beq $s0,$0,end_outer_for_loop
        	
        	#init key and get arr[i]
        	lw $t0,8($fp)#load arr
        	lw $t1,-8($fp)#load i
        	addi $t2,$0,4 #4 bytes
		mult $t1,$t2 #4*i
		mflo $t3
		add $t3,$t3,$t2 #i= 4*i + 4
		add $t3,$t3,$t0 #the addr for arr[i]
		lw $t4,($t3) #get the value of arr[i]
		sw $t4,-16($fp)#key = arr[i]
		
		#init j
		lw $t0,-8($fp)#load i
		addi $t0,$t0,-1#i-1
		sw $t0,-12($fp)#j=i-1
		
		j inner_while_loop
		
		inner_while_loop:
			#check j>=0
			lw $t0,-12($fp)#load j
			slt $s0,$t0,$0#if j<0 is true, then s0=1
			bne $s0,$0,end_inner_while_loop
			
			#check key < the_list[j]	
			lw $t0,8($fp)#load arr
        		lw $t1,-12($fp)#load j
        		addi $t2,$0,4 #4 bytes
			mult $t1,$t2 #4*j
			mflo $t3
			add $t3,$t3,$t2 #j= 4*j + 4
			add $t3,$t3,$t0 #the addr for arr[j]
			lw $t4,($t3) #get the value of arr[j]
			lw $t5,-16($fp)#load key
			slt $s0,$t5,$t4#if key < arr[j], then s0=1
			beq $s0,$0,end_inner_while_loop
			
			#set arr[j + 1] = arr[j]
			#get arr[j]
			lw $t0,8($fp)#load arr
        		lw $t1,-12($fp)#load j
        		addi $t2,$0,4 #4 bytes
			mult $t1,$t2 #4*j
			mflo $t3
			add $t3,$t3,$t2 #j= 4*j + 4
			add $t3,$t3,$t0 #the addr for arr[j]
			lw $t4,($t3) #get the value of arr[j]
			#get arr[j+1]
			lw $t0,8($fp)#load arr
        		lw $t1,-12($fp)#load j
        		addi $t2,$0,4 #4 bytes
			mult $t1,$t2 #4*j
			mflo $t3
			add $t3,$t3,$t2 #j= 4*j + 4
			add $t3,$t3,$t2 #j= 4*j + 8
			add $t3,$t3,$t0 #the addr for arr[j+1]
			#lw $t5,($t3) #get the value of arr[j+1]
			#the_list[j + 1] = the_list[j]
			sw $t4, ($t3)
			
			#set j-=1
        		lw $t0,-12($fp)#j
        		addi $t0,$t0,-1#j+1
        		sw $t0,-12($fp)#j+=1
			
			#goto inner_while_loop
			j inner_while_loop
			
        	end_inner_while_loop:
        		#get arr[j+1]
			lw $t0,8($fp)#load arr
        		lw $t1,-12($fp)#load j
        		addi $t2,$0,4 #4 bytes
			mult $t1,$t2 #4*j
			mflo $t3
			add $t3,$t3,$t2 #j= 4*j + 4
			add $t3,$t3,$t2 #j= 4*j + 8
			add $t3,$t3,$t0 #the addr for arr[j+1]
        		#the_list[j + 1] = key
        		lw $t4,-16($fp)#load key
			sw $t4, ($t3)
			
			#i+=1
			lw $t0,-8($fp)
			addi $t0,$t0,1#i+1
        		sw $t0,-8($fp)#i+=1
        		
        		#goto outer_for_loop
        		j outer_for_loop
        		
        		
        end_outer_for_loop:
        	#remove local variable
        	addi $sp, $sp, 16
        	#restore $fp and $ra and deallocate
		lw $fp,($sp)
		lw $ra,4($sp)
		addi $sp,$sp,8
	
		jr $ra
		
        




main:
                # memory diagram
            ###########################
            # i             : -8($fp) #
            # arr           : -4($fp) #
            # fp            :   ($fp) #
            # ra            :  4($fp) #
            ###########################
	# store $fp and $ra
        addi $sp, $sp, -8
        sw $fp, ($sp)
        sw $ra, 4($sp)
        
        # copy $sp to $fp
        addi $fp, $sp, 0
        
        # make space for two local variable
        addi $sp, $sp, -8

        # make space for one argument
        addi $sp, $sp, -4
        
        #allocate memory for array
	addi $v0,$zero, 9
	addi $a0,$zero, 24 #(5*4)+4
	syscall
	
	#init the local arr
	sw $v0,-4($fp) #arr=[]
	addi $t0,$zero,5
	sw $t0, ($v0) # store the length as the first element
	
	# add the elements to the array
    	lw $t0, -4($fp) # load the starting address of the list
	
	# add 6
    	addi $t1, $0, 6
    	sw $t1, 4($t0)
    	# add -2
    	addi $t1, $0, -2
    	sw $t1, 8($t0)
    	# add 7
    	addi $t1, $0, 7
    	sw $t1, 12($t0)
    	# add 4
    	addi $t1, $0, 4
    	sw $t1, 16($t0)
    	# add 10
    	addi $t1, $0, -10
    	sw $t1, 20($t0)
    	
    	#init i
    	addi $t1,$0,0
    	sw $t1,-8($fp)  #i=0
    	

        # store arr as the argument
        lw $t0,-4($fp)
        sw $t0, ($sp) #insertion_sort(arr)


        # call the insertion_sort(arr) funtion
        jal insertion_sort
        

        # deallocate the space for the argument
        addi $sp, $sp, 4
        
        
        #goto for-loop
        j mian_for_loop
        
        
        mian_for_loop:
        	#check i<len(arr)
        	lw $t0, -4($fp)# load the address of the arr
        	lw $t1, ($t0)  # load the length of the arr == 5
        	lw $t2,-8($fp) # load i
        	slt $s0,$t2,$t1 #t2<t1, s0==1
        	bne $s0, $0, print_arr_i
        	j exit
        
        print_arr_i:
        	#get arr[i]
        	lw $t0,-4($fp)#load arr
        	lw $t1,-8($fp)#load i
        	addi $t2,$0,4 #4 bytes
		mult $t1,$t2 #4*i
		mflo $t3
		add $t3,$t3,$t2 #i= 4*i + 4
		add $t3,$t3,$t0 #the addr for arr[i]
		
		lw $a0,($t3) #get the value of arr[i]
        	addi $v0, $0, 1 #print arr[i]
        	syscall
        	
        	#print space
        	la $a0, space
        	addi $v0, $0, 4
        	syscall
        	
        	#i+=1
        	lw $t0,-8($fp)#i
        	addi $t0,$t0,1#i+1
        	sw $t0,-8($fp)#i+=1
        	
        	j mian_for_loop
        	
        	                
        
        exit:
		# print newline
        	la $a0, newline
        	addi $v0, $0, 4
        	syscall
        
        	# deallocate space for local var
        	addi $sp, $sp, 8

        	# restore $fp and $ra
        	lw $fp, ($sp)
        	lw $ra, 4($sp)
        	# deallocate space for $fp and $ra
        	addi $sp, $sp, 8

        	jr $ra
        