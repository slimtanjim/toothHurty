#################################################
#    Assignment #:3
#    Name: SM Tanjim
#     ASU email: stanjim@asu.edu
#    course: CSE/EEE230, TTh 6:00pm
#   Description: This program takes in user input and performs arithmatic
#                   operation such as addition, multiplication and modules
#                   and orints out their values
#################################################


            .data

#num1    .word
#num2    .word
#num3
#num4


###### asking for user input

msg1:       .asciiz "Enter a value\n"
msg2:       .asciiz "Enter another value\n"
msg3:       .asciiz "Enter one more value\n"
msg4:       .asciiz "Enter one more value\n"

##### after computation, output singd

msg5:       .asciiz "\nnum2 + num3 = "
msg6:       .asciiz "\nnum3 - num2 = "
msg7:       .asciiz "\nnum2 * num4 = "
msg8:       .asciiz "\nnum2 / num3 = "
msg9:       .asciiz "\nnum1 mod num4 = "
msg10:      .asciiz "\n(num3 / 4 + ((num2 - num4 * num1) mod 3) = "


msg0:       .asciiz "\n\nyou entered "




                .text
                .globl  main
main:
# asks for                          num1
        la      $a0, msg1
        li      $v0, 4
        syscall

#get the user input
        li      $v0, 5 # gets the number into $v0
        syscall

#move the value in a temp reg 0
        move    $t0, $v0

#move $a0, $t0
#li $v0,
#syscall


#################################################################################



# asks for                          num2
        la      $a0, msg2
        li      $v0, 4
        syscall

#get the user input
        li $v0, 5
        syscall

#move the value to temp reg 1
        move $t1, $v0


# asks for                          num3
        la      $a0, msg3
        li      $v0, 4
        syscall

#get the user input
        li $v0, 5
        syscall

#move the value to temp reg 2
        move $t2, $v0


# asks for                          num4
        la      $a0, msg4
        li      $v0, 4
        syscall

#get the user input
        li $v0, 5
        syscall

#move the value to temp reg 3
        move $t3, $v0






########## now the arithmatic part


#addition
#"num2+num3"
#  add     $s0, $t1, $t2

#print the sum
        la      $a0, msg5         #msg 5  #num2 + num3
        li      $v0, 4
        syscall


add     $s0, $t1, $t2       #num2 + num3
        move     $a0, $s0
        li      $v0, 1
        syscall


#substraction
#"num3-num2"

        la      $a0, msg6       #  prints msg 6
        li      $v0, 4
        syscall

#substraction
#"num3-num2"
sub     $s1, $t2, $t1
        move    $a0, $s1
        li      $v0, 1
        syscall


# multiplication
#num2*num4
        la      $a0, msg7       #  prints msg 7
        li      $v0, 4
        syscall

mul     $s2, $t1, $t3
        move    $a0, $s2
        li      $v0, 1
        syscall





#dividing num2 / num3

       la      $a0, msg8       # prints msg 8   "num2 / num3 = "
       li      $v0, 4
       syscall

div     $s3, $t1, $t2
        move    $a0, $s3      #move quitient to $a0
        li      $v0, 1
        syscall



#module
#num1 mod num4    8  mod   -3

        la      $a0, msg9       #prints "num1 mod num4 ="
        li      $v0, 4
        syscall

div     $s3, $t0, $t3           #

#mflo    $s0     #quotient
mfhi    $s1     #remainder


move    $a0, $s1
li      $v0, 1
syscall
######################################### done with the simple arithmatics



##(num3 / 4)+((num2 - num4 * num1) mod 3)=4



        la      $a0, msg10       #prints msg for big multi operation
        li      $v0, 4
        syscall




###first  divide num3 (11) by 4 , store in $s0

        li      $s0, 4
        div     $s0, $t2, $s0      ### $s0 has quotient 2


###seond multiply  num4 (-3) and num1 (8), store in $s1

        mul     $s1, $t3, $t0       ### $s1 contians product -24


###third subtract product in $s1 from num2 ($t1), store in $s2 ()

        sub     $s2, $t1, $s1       ###$s2 contains "differnce"29

###forth do the mod of 29 in $s2 and 3

        li      $s3, 3
        div     $s3, $s2, $s3

        mfhi    $s3     #remainder  move from hi register (the 2) to $s3



### finally fifth add both sides $s0 (2) and $s3 (2)    ////s3 has reminder

        add $s4, $s0, $s3  # add the 2 from 1st and the 2 from mod in 4th




#########now to print the thing (4)

        move    $a0, $s4
        li      $v0, 1
        syscall




        jr      $ra             # jump register to return  #yay!





##############
#testing out the methods

# asks for num1
#        la      $a0, msg1
#        li      $v0, 4
#        syscall

#get the user input
#        li      $v0, 5
#       syscall

#store the value in a temp register
#        move    $t0, $v0

# print out what the user entered
        #string
#       la      $a0, msg0
#       li      $v0, 4
#       syscall

# the number
#       move    $a0, $t0
#       li      $v0, 1
#       syscall

####################
