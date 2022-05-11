###########################################################
#  Assignment #: 6
#  Name: SM Tanjim
#  ASU email: stanjim@asu.edu
#  Course: CSE/EEE230, TTh 6:00pm
#  Description: This program asks user to input numbers as elements 
#				for two different arrays and then switch the elements
#				with in the two arrays and print it. Asking for user
#				input, switching and printing is done through three
#				different function calls staring from main. 
###########################################################

				.data

msg1a:	.asciiz "Specify how many numbers should be stored in the arrays 1 (at most 10):\n"
#number of array to put in array 2
msg1b:	.asciiz "Specify how many numbers should be stored in the arrays 2 (at most 10):\n"
#number of array to put in array 2
msg2: 	.asciiz "Enter an integer \n"
# repeats to populate every element the user wanted
msg3a: 	.asciiz "\nThe array 1 content:\n"
#shows what was put in array 1
msg3b: 	.asciiz "\nThe array 2 content:\n"
#shows what was was put in array 2
msg4a:	.asciiz "\nResult array 1 Content:\n"
#Prints the switched array
msg4b:	.asciiz "\nResult array 1 Content: \n"
#Prints the switched array

numbers1:     .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
#dummy array values 
numbers2:     .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#dummy array values


				.text
				.globl main

main:

#initilize teh array 	
	la	$s1, numbers1
	la	$s2, numbers1

# call swamElemts to start the onward march of processing array elements  
	jal swapElements

#after printing jump to exit program 

	jr finalExit



############################################################################
# Procedure/Function swapElement
# Description: asks for element # and then 
# parameters: $a0 = address of array
# return value: $v0 = length
# registers to be used: $s3 and $s4 will be used.
############################################################################
swapElements:

  
#callfir first array 

			la $a0, msg1a	# prints "Specify how many ... array1"
			li $v0, 4
			syscall 



	#store the number 
			li $v0, 5 		# v0 has the input number 
			syscall
	#move number to 
			move 	$a0, $v0 # a0 has input number

	#jump to readArray to populate array 1
		jal readArray
#				>>>>> goes to readArray 




#callfir second array 
			la $a0, msg1b	# prints "Specify how many ... array2"
			li $v0, 4
			syscall 
	#store the number 
			li $v0, 5 		# v0 has the input number 
			syscall
	#move number to 
			move 	$a1, $v0 # a0 has input number

	#jump to readArray to populate array 1
		jal readArray
#########
###########
#after setting the arrays 
########
##########




		jr	$ra # returnt to the main

############################################################################
# Procedure/Function readArray
# Description: loop untill specified to populate array
# parameters: $a0 = address of array
# return value: $v0 = length
# registers to be used: $s3 - s4, t0-t3
############################################################################
readArray:

li		$s0, 0
move	$s1, $a0 #<<<<<<<< s1 has  element count

#### now to itterate and plug in the array 




loopRead:
# position of the array 
		slt 	$s3, $s0, $s1	

#branch after the last element 
		beq		$s3, $zero, exitRead	

				sll $s1, $s0, 2		#t1 is shift value 
																	
				add $t2, $t1, $s6	#t2 = i*4+base address(t1) , shifter address of [i].
														
				lw $t3, 0($t2)		#t3 has element of array pointer 

					###. get the input 

					la  $a0, msg2
					li 	$v0, 4
					syscall # prints "Enter an integer:"


					li 		$v0, 5
					syscall				#gets the element from user 

				move $t4, $v0		# form v0 to t4 >>> to save

													
				sw		$t4, 0($t2) # same
				addi 	$s0, $s0, 1 #	add 1 to counter to get the next number 

									## jump to the top to intterate 
				j 	loopRead 						#line >> loopPrint 


exitRead: 	#comes hear after reaching the end 

		jr	$ra #return to the swapElements




############################################################################
# Procedure/Function printArray
# Description: prints out the manuplated array 
# parameters: array length
# return value: $v0 returns the while array  
# registers to be used: s6, s3, t0 - t3
############################################################################
printArray:

#s6		has 1[] 
#s7		has 2[] 

	move $s6, $a0
	move $s7, $a1  

	li $t0, 0 #counter 


loopPrint:

	#s3 1 ot 0
	slt 	$s3, $t0, $s6
	#branch after the last element 
	beq		$s3, $zero, exitPrint	


			sll $t1, $t0, 2		#t1 is shift value 
										
			add $t2, $t1, $s6	#t2 = i*4+base address(t1) , shifter address of [i].
							
			lw $t3, 0($t2)		#t3 has element of array pointer 



			move 	$a0, $t3
			li 		$v0, 1
			syscall				#print the element

						
			sw		$t4, 0($t2)
			addi 	$t0, $t0, 1 #	add 1 to counter to get the next number 

							## jump to the top to intterate 
			j 	loopPrint 						#line >> loopPrint 


	exitPrint: 	#comes hear after reaching the end 

		jr	$ra #return to the swap elements 




finalExit:

		jr 		$ra







