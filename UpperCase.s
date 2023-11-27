.include "macrolib.s"

.global UpperCase

.eqv TEXT_SIZE 4096

.data
	newString: .space TEXT_SIZE
	
	
	# GLOBAL VARIABLE
	# t2 - adress buffer newString
	
	# LOCAL VARIABLE
	# s0 - move t0 (length string)
	# s1 - symbol string
	# s2 - left board small letters without 'a'
	# s3 - ascii 'e'
	# s4 - ascii 'i'
	# s5 - ascii 'o'
	# s6 - ascii 'u'
	# s7 - ascii 'y'
	# s8 - right board small letters
	
	
.text
UpperCase:
	# Save ascii code in registers
	mv s0 t0
	li s2 98
	li s3 101
	li s4 105
	li s5 111
	li s6 117
	li s7 121
	li s8 122
	la t2 newString
	
	# Check on correct letter and change size need letters
	loop:
		beqz s0 end_loop
		lb s1 (t1)
		
		blt s1 s2 next
		bgt s1 s8 next
		beq s1 s3 next
		beq s1 s4 next
		beq s1 s5 next
		beq s1 s6 next
		beq s1 s7 next
		
		addi s1 s1 -32
				
		next:
			sb s1 (t2)
			addi t1 t1 1
			addi t2 t2 1
			addi s0 s0 -1
			b loop
	end_loop:
	
	# Destruction of subroutine variables
	zeroing_variable(s0)
    	zeroing_variable(s1)
    	zeroing_variable(s2)
    	zeroing_variable(s3)
    	zeroing_variable(s4)
	zeroing_variable(s5)
    	zeroing_variable(s6)
    	zeroing_variable(s7)
    	zeroing_variable(s8)

	ret
