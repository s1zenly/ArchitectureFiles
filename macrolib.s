.macro close_file(%x)
	li   a7, 57       
    	mv   a0, %x      
    	ecall 
.end_macro

.macro write_to_file(%descriptor, %buffer, %SIZE)
	li   a7, 64       
    	mv   a0, %descriptor       
    	la   a1, %buffer   
    	li   a2, %SIZE
    	ecall 
.end_macro

.macro zeroing_variable(%x)
	add %x x0 x0
.end_macro

.macro open_file_read
	li     a7 1024     
    	la     a0 file_name   
    	li     a1 0        
    	ecall 
.end_macro

.macro open_file_write
	li     a7 1024     
    	la     a0 file_name   
    	li     a1 1        
    	ecall 
.end_macro

.macro input_file_name
	la a0 file_name
	li a1 NAME_SIZE
	li a7 8
	ecall
.end_macro

.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

.macro if_number_more_zero(%x)
	bltz %x next
	addi t6 t6 1
	next:
.end_macro

.macro if_number_less_zero(%x)
	bgez %x next
	addi t6 t6 -1
	next:
.end_macro

.macro print_from_register(%x)
	lw a0 (%x)
        li a7 1
        ecall
.end_macro

.macro print_imm_int (%x)
    li a7, 1
    li a0, %x
    ecall
.end_macro

# Ввод целого числа с консоли в регистр a0
.macro read_int_a0
   li a7, 5
   ecall
.end_macro

# Ввод целого числа с консоли в указанный регистр,
# исключая регистр a0
.macro read_int(%x)
   push	(a0)
   li a7, 5
   ecall
   mv %x, a0
   pop	(a0)
.end_macro

.macro message (%x)
   .data
	str: .asciz %x
   .text
	   push (a0)
	   li a7, 4
	   la a0, str
	   ecall
	   pop	(a0)
.end_macro

.macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

.macro newline
   print_char('\n')
.end_macro

# Завершение программы
.macro exit
    li a7, 10
    ecall
.end_macro

# Сохранение заданного регистра на стеке
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

# Выталкивание значения с вершины стека в регистр
.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro
