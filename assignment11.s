#################################################
# Assignment #:11
# Name: SM Tanjim
# ASU email: stanjim@asu.edu
# Course: CSE/EEE230, TTh 6:00pm
# Description: The program intakes float numbers from user and sets the 
#               duplicates to zero and prints the whole array 
#               only the last occurance of the of the number is kept
#################################################



            .data

msg1: .asciiz "Specify how many numbers should be stored in the array (at most 25 )\n"
msg2: .asciiz "\nEnter a number\n"
msg3: .asciiz "The original array contains the following:\n"
msg4: .asciiz "The result array contains the following:\n"

line: .asciiz "\n"


#25 empty places 
fNumbers:    .float     0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0



#   System Call     System Call
#   Operation       Description

#   print_float         $v0 = 2, $f12 = float number to be printed
#   print_string        $v0 = 4, $a0 = address of beginning of ASCIIZ string
#   read_float          $v0 = 6; user types a float number at keyboard; value is stored in $f0
#   read_string         $v0 = 8; user types a string at keybd;
#                                addr of beginning of string is stored in $a0;
#                                len in $a1
 
########reffrence

            .text
            .globl main
main:

#specify numebrs to be stored in array
        la $a0, msg1
        li $v0, 4
        syscall

#system read array size
        li $v0, 5
        syscall
        
#store size >>array[size] in $s0
        move $s0, $v0

 

#base address of array fNumbers
    la $s1, fNumbers 

#counter for loop
    li $t0, 0    #<<---array element itterator (address)
    li $t1, 0    #<<---array index counter 

#loop for s0 times
#loop to ask the user for all the array index
    inputLoop:

#check counter  s2 = 1 if t1 < s0
    slt $s2, $t1, $s0 #  s0 = (25)    t1(index counter)  < s0 (array lenght) 

#exit condition,  if  = array[$s0], then jump to   j after input 
    beq $s2, $zero, afterInput
                                # s2 is 0 only when count is no longer less than the array lenght 
                                # jumps to afterInput after storing   

        #print  msg2:  "Enter a number:"
            la $a0, msg2
            li $v0, 4
            syscall

        #system read floating     # v>>6 for floating
            li $v0, 6
            syscall
            
        # store size >>array[size] in $s0
            mov.s $f1, $f0

### storing element in array

            sll $t2, $t0, 2    # shift 2 = mult by 4 
        # t2 shoft by value,   s1 base address array,  2 <- shift by 
        # t0 is moving address by 4 bits 

#shift base address
            add $t3, $t2, $s1
            #t3 = shift about + base address 
        

        #save the element to the shifted address 
        s.s $f1, 0($t3)

        #incriment counter
        addi $t1, $t1, 1    #<--regular counter 
        addi $t0, $t0, 1    #<--sll for address 


        #go uo  for the next element   loop  >>line  69
        j   inputLoop








#after storing print the array   
    afterInput:



    #reload the base address of array 
        la $s1, fNumbers 

    #reinnitialize registers for element ans counter 
        li $t0, 0    #<<---array element itterator (address)
        li $t1, 0    #<<---array index counter 

########print array content   original
        la $a0, msg3
        li $v0, 4
        syscall 

########//Print out each number in the array
        printOriginal:

            #check for end of array 
                slt $s2, $t1, $s0 

            #branch to _____ after printing ends
                beq $s2, $zero, changeElement


            sll $t2, $t0, 2    # shift 2 = mult by 4 
        # t2 shoft by value,   s1 base address array,  2 <- shift by 

            add $t3, $t2, $s1
        
        #load the element from the shifted address 
        l.s $f1, 0($t3)
                                                                                                ##----
        # syscall print float
        mov.s $f12, $f1
        li $v0, 2 
        syscall
                ##mov.s to a0 form f1  

        #new line after printing 
        la $a0, line
        li $v0, 4 
        syscall


        #incriment counter
        addi $t1, $t1, 1    #<--regular counter 
        addi $t0, $t0, 1    #<--sll for address 



        #after printing jump back to printOriginal
            j   printOriginal



# registers user so far =   
# s0= lenght     s1 = address arr s2  


##################
# //check each element in the array from the end
# //to see if there is another number that is same.
# //In that case, set it to 0.

#limit the array length
# slt  $t0  

        changeElement:

           



###################################################################################################################################################################


 # base array address into s1 
            la $s1, fNumbers 

            #t0 has the lenght of array 
            add  $t0, $zero, $s0   
            addi $t0, $t0, -1       #<-- for the i loop             # take it out ?

    #floats to compare 


    
                iLoop:         #for (i = howMany-1; i >= 0; i--)


                   #check counter  s2 = 1 if zero < t0 lenght
                    slt $s2, $zero, $t0 #         0 < t0(25-1) ,, so  pass 1 in s2   t1(index counter)  < s0 (array lenght) 

                    #exit condition,  if  = array[$s0], then jump to   j after input 
                    beq $s2, $zero, indexClear
                                        #if s2 is 0, done! 


                                                    #load the float value from the index 
                                                    sll $t2, $t0, 2    # shift 2 = mult by 4 
                                                         
                                                    # t2 shift by value,   s1 base address array,  2 <- shift by 

                                                    add $t3, $s1, $t2  #t3 has    base address of array plus shift abount in t2 
                                                            
                                                    #load the element from the shifted address 
                                                    l.s $f1, 0($t3)
                                                        # f1 has the last element 


                                                                        #initililize j 
                                                                        addi $t1, $t0, -1    # t1 is  " j "


                                                                            jLoop:      # for (j = i-1; j >= 0; j--)

                                                                                #need -1 so it dosen't end early 
                                                                                li $t6, -1
                                                                                    slt $t4, $t6, $t1     #t1 is j
                                                                                    beq $t4, $zero, passNext

#getting the value in array to compare  
                                                                                    # value at j  
                                                                                    sll $t2, $t1, 2
#---------------------->                                                            #
                                                                                    add $s3, $s1, $t2 

                                                                                    l.s $f2, 0($s3)         # f2 has the j value 


                                                                                    # compare the elements 

                                                                                    li.s    $f3, 0.0001    # < then fe

                                                                                    li.s    $f4, -0.0001
                                                                                    #subtrat the floating numbers 
                                                                                    sub.s $f5, $f2, $f1      

                                                                                                                #(array[j] - array[i]) < 0.0001
                                                                                    # brach to next_J label if statemnt is false 
                                                                                    c.lt.s  $f5, $f3           
                                                                                    bc1f   next_J


                                                                                    # brach to next_J label if statemnt is false 
                                                                                    c.lt.s  $f4 , $f5          #(array[j] - array[i]) > -0.0001)
                                                                                    bc1f   next_J


                                                                                    # array[j] = 0.0;
                                                                                    li.s    $f2, 0.0


                                                                                    s.s $f2, 0($s3)     #<----------   savign the element 


                                                                    next_J:
                                                                            addi $t1, $t1, -1   #<-- incriment  

                                                                            j   jLoop   #jump back up for previous element 


                #next element to compare 

            passNext: 

                    addi $t0, $t0, -1         #decrament for the "i loop"                                   

                    j   iLoop   # move to the previous element 




################################################################################################################################################################






indexClear:






########pritn array content   fixed with zeros


    #reload the base address of array 
        la $s1, fNumbers 

    #reinnitialize registers for element ans counter 
        li $t0, 0    #<<---array element itterator (address)
        li $t1, 0    #<<---array index counter 

########print array content   original
        la $a0, msg4
        li $v0, 4
        syscall 

########//Print out each number in the array
        printFixed:

            #check for end of array 
                slt $s2, $t1, $s0 

            #branch to _____ after printing ends
                beq $s2, $zero, progFin



         sll $t2, $t0, 2    # shift 2 = mult by 4 
        # t2 shoft by value,   s1 base address array,  2 <- shift by 

            add $t3, $t2, $s1
        
        #load the element from the shifted address 
        l.s $f1, 0($t3)


        # syscall print float
        mov.s $f12, $f1             #<--- start the other loop
        li $v0, 2 
        syscall
                ##mov.s to a0 form f1  

        #new line after printing 
        la $a0, line
        li $v0,4 
        syscall


        #incriment counter
        addi $t1, $t1, 1    #<--regular counter 
        addi $t0, $t0, 1    #<--sll for address 



        #after printing jump back to printOriginal
            j   printFixed


progFin:

        jr  $ra






























