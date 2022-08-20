.globl print_combination
.globl combination_aux
.globl main


.data
newline:    .asciiz "\n"
space:	    .asciiz " "

.text

# go to main func
jal main

#exit the program
addi $v0, $0, 10
syscall



combination_aux:

            # memory diagram
            ###########################
            # j           : -4($fp)   #
            # fp          : ($fp)     #
            # ra          : 4($fp)    #
            # arr         : 8($fp)    #
            # n           : 12($fp)   #
            # r           : 16($fp)   #
            # index       : 20($fp)   #
            # data        : 24($fp)   #
            # i           : 28($fp)   #
            ###########################


        # make space to store $fp and $ra
        addi $sp, $sp, -8
        sw $fp, ($sp)
        sw $ra, 4($sp)

        # copy $sp to $fp
        addi $fp, $sp, 0

        # one local variable
        addi $sp, $sp, -4
        
	
	#init the local j=0
	addi $t0,$0,0
	sw $t0,-4($fp)
	
	#get index-r
	lw $t0,20($fp)#get index
	lw $t1,16($fp)#get r
	beq $t0,$t1,the_first_if#if index == r,then goto the_first_if
	
	#check i>=n
	lw $t0,28($fp)#get i
	lw $t1,12($fp)#get n
	slt $s0,$t0,$t1 #if i<n, then $s0=1, else $s0=0
	beq $s0,$0,the_sec_if # if i>=n, then goto the_sec_if
	
	#get arr[i]
	lw $t0,8($fp)#get the head of the arr
	lw $t1,28($fp)#get i
	addi $t2,$0,4 #4 bytes
	mult $t1,$t2 #4*i
	mflo $t3
	add $t3,$t3,$t2 #new_i = 4i+4
	add $t3,$t3,$t0 #the addr for arr[new_i]
	lw $t4,($t3) #get the value of arr[new_i]
	
	#get data[index]
	lw $t0,24($fp)#get the head of the data
	lw $t1,20($fp)#get index
	addi $t2,$0,4 #4 bytes
	mult $t1,$t2 #4*index
	mflo $t3
	add $t3,$t3,$t2 #new_index = 4*index + 4
	add $t3,$t3,$t0 #the addr for arr[new_index]
	
	#set data[index] = arr[i]
	sw $t4, ($t3)
	
	#Call combination_aux(arr, n, r, index + 1,data, i + 1)
	lw $t3,20($fp)#get index
	lw $t4,28($fp)#get i
	addi $t3,$t3,1#index + 1
	addi $t4,$t4,1#i+1
	#make space for six argument 
	addi $sp,$sp,-24
	# store arr as the first argument
        lw $t0,8($fp)
        sw $t0, ($sp) #(arr)
        # store n as the second argument
        lw $t0,12($fp)
        sw $t0, 4($sp) #(arr,n)
        # store r as the third argument
        lw $t0,16($fp)
        sw $t0, 8($sp) #(arr,n,r)
        # store index+1 as the fourth argument
        sw $t3, 12($sp) #(arr,n,r,index+1)
        # store data as the fifth argument
        lw $t0,24($fp)
        sw $t0, 16($sp) #(arr,n,r,index+1,data)
        # store i+1 as the sixth argument
        sw $t4, 20($sp) #(arr,n,r,index+1,data,i+1)
        # call the funtion
        jal combination_aux
        
        #remove space of 6 argument
        addi $sp,$sp,24	
        

        
        #Call function combination_aux(arr, n, r, index,data, i + 1)
	lw $t3,20($fp)#get index
	lw $t4,28($fp)#get i
	addi $t4,$t4,1#i+1
	#make space for six argument 
	addi $sp,$sp,-24
	# store arr as the first argument
        lw $t0,8($fp)
        sw $t0, ($sp) #(arr)
        # store n as the second argument
        lw $t0,12($fp)
        sw $t0, 4($sp) #(arr,n)
        # store r as the third argument
        lw $t0,16($fp)
        sw $t0, 8($sp) #(arr,n,r)
        # store index as the fourth argument
        sw $t3, 12($sp) #(arr,n,r,index)
        # store data as the fifth argument
        lw $t0,24($fp)
        sw $t0, 16($sp) #(arr,n,r,index,data)
        # store i+1 as the sixth argument
        sw $t4, 20($sp) #(arr,n,r,index,data,i+1)
        # call the funtion
        jal combination_aux
        
        #remove space of 6 argument
        addi $sp,$sp,24
        
        # remove local variable
        addi $sp, $sp, 4
        
        
	#restore $fp and $ra and deallocate
	lw $fp,($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	
	jr $ra
	
	
	
	
	
	
	
	the_first_if:
		lw $t0,-4($fp)#get j
		lw $t1,16($fp)#get r
		slt $s0,$t0,$t1#if j<r,then s0=1
		bne $s0,$0,print_data_j#j<r,goto print
		
		# print newline
        	la $a0, newline
        	addi $v0, $0, 4
        	syscall
        	
        
		#deallocate space for local variables
		addi $sp,$sp,4
	
		#restore $fp and $ra and deallocate
		lw $fp,($sp)
		lw $ra,4($sp)
		addi $sp,$sp,8
	
		jr $ra
			
	
	
	
	
	print_data_j:
		#get data[index]
		lw $t0,24($fp)#get the head of the data
		lw $t1,-4($fp)#get j
		addi $t2,$0,4 #4 bytes
		mult $t1,$t2 #4*j
		mflo $t3
		add $t3,$t3,$t2 #new_index = 4*j + 4
		add $t3,$t3,$t0 #the addr for data[j]
		
		#print data[j]
		lw $a0,($t3) #get the value of data[j]
        	addi $v0, $0, 1
        	syscall
        	
        	#print space
        	la $a0, space
        	addi $v0, $0, 4
        	syscall
        	
        	#j+=1
        	lw $t0,-4($fp)#j
        	addi $t0,$t0,1#j+1
        	sw $t0,-4($fp)#j+=1
        	
        	j the_first_if
        	
        	
		
	
	
	the_sec_if:
		#deallocate space for local variables
		addi $sp,$sp,4
	
		#restore $fp and $ra and deallocate
		lw $fp,($sp)
		lw $ra,4($sp)
		addi $sp,$sp,8
		
	
		jr $ra
	
	



print_combination:

            # memory diagram
            ###########################
            # data        : -4($fp)   #
            # fp          : ($fp)     #
            # ra          : 4($fp)    #
            # arr         : 8($fp)    #
            # n           : 12($fp)   #
            # r           : 16($fp)   #
            ###########################

        # make space to store $fp and $ra
        addi $sp, $sp, -8
        sw $fp, ($sp)
        sw $ra, 4($sp)

        # copy $sp to $fp
        addi $fp, $sp, 0

        # one local variable(maybe)
        addi $sp, $sp, -4
        
        # make space for six argument
        addi $sp, $sp, -24
        
        #allocate memory for array(data)
	addi $v0,$zero, 9 #allocate the memory system call
	addi $a0,$zero, 16 #(3*4)+4
	syscall
	
	#init the local data
	sw $v0,-4($fp) #data=[]
	addi $t0,$zero,3 #assign length
	sw $t0, ($v0) # store the length as the first element
	
	# add the elements to the array data
    	lw $t0, -4($fp) # load the starting address of the list
	
	# add 0
    	addi $t1, $0, 0
    	sw $t1, 4($t0)
        # add 0
    	addi $t1, $0, 0
    	sw $t1, 8($t0)
    	# add 0
    	addi $t1, $0, 0
    	sw $t1, 12($t0)
    	
    	
    	# store arr as the first argument
        lw $t0,8($fp)
        sw $t0, ($sp) #(arr)
        
        # store arr as the second argument
        lw $t0,12($fp)
        sw $t0, 4($sp) #(arr,n)
        
        # store arr as the third argument
        lw $t0,16($fp)
        sw $t0, 8($sp) #(arr,n,r)
        
        # store arr as the fourth argument
        addi $t0,$0,0
        sw $t0, 12($sp) #(arr,n,r,0)
        
        # store arr as the fifth argument
        lw $t0,-4($fp)
        sw $t0, 16($sp) #(arr,n,r,0,data)
        
        # store arr as the sixth argument
        addi $t0,$0,0
        sw $t0, 20($sp) #(arr,n,r,0,data,0)
        
        # call the funtion
        jal combination_aux
    
        # deallocate args
        addi $sp, $sp, 24

        # deallocate locals
        addi $sp, $sp, 4
        
        # restore $fp and $ra
        lw $fp, ($sp)
        lw $ra, 4($sp)

        # deallocate space for $fp and $ra
        addi $sp, $sp, 8

        jr $ra
                            
                                        
                                                    
                                                                
                                                                            
                                                                                                    
main:
                # memory diagram
            ###########################
            # n             : -12($fp)#
            # r             : -8($fp) #
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

        # make space for three local variable
        addi $sp, $sp, -12

        # make space for three argument
        addi $sp, $sp, -12
        
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
	
	# add 1
    	addi $t1, $0, 1
    	sw $t1, 4($t0)
    	# add 2
    	addi $t1, $0, 2
    	sw $t1, 8($t0)
    	# add 3
    	addi $t1, $0, 3
    	sw $t1, 12($t0)
    	# add 4
    	addi $t1, $0, 4
    	sw $t1, 16($t0)
    	# add 5
    	addi $t1, $0, 5
    	sw $t1, 20($t0)
    	
    	#init r 
    	addi $t1,$0,3
    	sw $t1,-8($fp)  #r=3
    	
    	#init n
    	lw $t1,-4($fp)#get arr
    	lw $t2,($t1)#get n=len(arr)==(5)
    	sw $t2,-12($fp)
    	       

        # store arr as the first argument
        lw $t0,-4($fp)
        sw $t0, ($sp) #(arr)
        
        # store r as the second argument
        lw $t0,-12($fp)
        sw $t0, 4($sp) #(arr,n)
        
        # store n as the third argument
        lw $t0,-8($fp)
        sw $t0, 8($sp) #(arr,n,r)
        
   

        # call the funtion
        jal print_combination
        

        # deallocate the space for the argument
        addi $sp, $sp, 12
        
        # deallocate space for local var
        addi $sp, $sp, 12

        # restore $fp and $ra
        lw $fp, ($sp)
        lw $ra, 4($sp)

        # deallocate space for $fp and $ra
        addi $sp, $sp, 8

        jr $ra


