# Operands to multiply
.data
a: .word 0xBAD
b: .word 0xFEED

.text
main:   # Load data from memory
		la      t3, a
        lw      t3, 0(t3)
        la      t4, b
        lw      t4, 0(t4)
        
        # t6 will contain the result
        add		t6, x0, x0# sum

        # Mask for 16x8=24 multiply
        ori		t0, x0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        
####################
# Start of your code

# Use the code below for 16x8 multiplication
#   mul		<PROD>, <FACTOR1>, <FACTOR2>
#   and		<PROD>, <PROD>, t0


		#step one multiply uper bits 
		srli  a1, t3, 8       #  get upper 8 bits
		mul   t6, a1, t4      # multiply upper 8 bits of a with b
		and   t6, t6, t0      

		slli  t6, t6, 8       # shift left sum

		# --- step two multiply lower bits ---
		andi   a1, t3, 0xFF    # move the 8 lower bits of a to a1

		mul   t1, a1, t4      # temp = a_lower * b 
		and    t1, t1, t0      

		add   t6, t6, t1      # add to total sum




# End of your code
####################


	
	
		
finish: addi    a0, x0, 1
        addi    a1, t6, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall

