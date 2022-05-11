#################################################
#    Assignment #:5
#    Name: SM Tanjim
#     ASU email: stanjim@asu.edu
#    course: CSE/EEE230, TTh 6:00pm
#   Description: The user input two numbers and the program manupilate 
#					the elements in the array by seeing if it is divisible 
#					by second input number and if so, then add the product
#					of that number and 2 to the element of that array 
#					(mod = 0). Then it prints all 11 elements 
#################################################




			.data

msg1:	.asciiz "Enter an ending index:\n"
#store in $s0
msg2: 	.asciiz "Enter an interger:\n"
#store in $s1
msg3:	.asciiz "Result Array Content:\n"

#new line fro printing
msg4:	.asciiz "\n"


numbers_len:	.word     11
numbers:		.word     -27, 3, 46, -7, 24, -9, 14, -18, 12, -5, 24


			.text
			.globl	main 
main:


#ask for ending index 

	la 	$a0, msg1
	li	$v0, 4
	syscall 

		#get the user input
    li $v0, 5
    syscall

			#move the value to temp reg 7
    move $s0, $v0


#ask for integer 
	la 	$a0, msg2
	li	$v0, 4
	syscall

		#get the user input 
	li 	$v0, 5
	syscall 

			#move the value to temp reg 6
	move $s1, $v0



#####################################################


#array address into s6
	la 	$s6, numbers
#reset the "i",	$s0 to zero 
	li 	$s2, 0

Loop:


#s2 (counter) < endIndex
	slt 	$s3, $s2, $s0	# s3 as 1 or 0  s2(0 and itterates) s0 it ending index number
	beq		$s3, $zero, Next

#    &&

#s2 (counter) < 11
	slti	$t0, $s2, 11  # t0 has 1 or 0 (yes or no).    $s0 < 11 ?  1:0
	beq 	$t0, $zero, Exit1  


##########################################################################################################


# since t0 == 1 &&  s3 == 1
#>>>>
	sll $t1, $s2, 2			#.          0001. <<<	==. 0100
			#t1 is shift value 

	add $t2, $t1, $s6		# t2 = i*4+base address =.    shifter address of [i]. 
	######what is $s6

	lw $t3, 0($t2)			#t3 has element of array pointer 


######after loading the index to t3 
######	now check to manupilate 

		div 	$t4, $t3, $s1 		#div -27 by 3 
		mfhi	$t4					#has remainder 0

#li t6, 1

#	slt 	$t5, $t4, $t6		#compare if mod == 0 

	bne		$t4, $zero, Exit1 	#if not == 0, then mul and add below 

Next:
		li 		$t7, 2 # to multiply 
		mul 	$t7, $s1, $t7			# t7 should have 6. --( 3 * 2)

		add 	$t4, $t7, $t3			# add 6 (t7) to -27 (t3) = t4 (final value )

## save changes then add




	sw		$t4, 0($t2)
	addi	$s2, $s2, 1



## jump to the top to intterate 
	j 	Loop


#second part of asss 5 








##############################################
##############################################
# print the values 
##############################################
##############################################
Exit1:

#PrintResult:
				#first prints the string
la	$a0, msg3	# "Result Array Content"
li 	$v0, 4
syscall



#array address into s6
	la 		$s6, numbers
#reset the "i",	$s0 to zero 
	li 		$s0 , 0

fLoop:

	slti	$t0, $s0, 11  # t0 has 1 or 0 (yes or no).    $s0 < 11 ?  1:0

	beq $t0, $zero, Exit   
# since t0 = 1
#>>>>
	sll $t1, $s0, 2			#.          0001. <<<	==. 0100

	add $t2, $t1, $s6		# t2 = i*4+base address =current address of [i].
	######what is $s6

	lw $t3, 0($t2)			#t3 has address of array pointer 


	move $a0, $t3 	 #printing element from address 
	li $v0, 1
	syscall


	la $a0, msg4	# printing new line
	li $v0, 4
	syscall 


	addi $s0, $s0, 1 	# i = i+1 # keeps track of the loop 

			#jump to loop back and itter
	j 	fLoop


Exit:
		jr 	$ra





