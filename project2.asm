# Thu vien TIME bang MIPS

        .data
msg_day:
	.asciiz "Nhap ngay DAY: "
msg_month:
	.asciiz "Nhap thang MONTH: "
msg_year:
	.asciiz "Nhap nam YEAR: "
TIME_1:
	.space 20
TIME_2:
	.space 20
time_temp:
	.space 20
temp_1:
	.space 20
temp_2:
	.space 20
msg_select:
	.asciiz "----Ban hay chon 1 trong cac thao tac duoi day----\n"
select_1:
	.asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
select_2:
	.asciiz "2. Xuat chuoi TIME thanh mot trong cac dinh dang sau\n   A. MM/DD/YYYY\n   B. Month DD, YYYY\n   C. DD Month, YYYY\n"
select_2_type:
	.asciiz "Chon dinh dang A, B hay C : "
select_3:
	.asciiz "3. Cho biet ngay vua nhap la thu may trong tuan\n"
select_4:
	.asciiz "4. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n"
select_5:
	.asciiz "5. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2\n"
select_6:
	.asciiz "6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME\n"
select_7:
	.asciiz "7. Kiem tra bo du lieu dau vao khi nhap, neu du lieu khong hop le thi yeu cau nguoi dung nhap lai\n"
msg_choose:
	.asciiz "Lua chon: "
msg_result:
	.asciiz "Ket qua: "
msg_type_invalid:
	.asciiz "Type khong phai A, B, C\n"
msg_select_invalid:
	.asciiz "Yeu cau nhap vao khong phai tu 1 den 7\n"
msg_leap:
	.asciiz "La nam nhuan\n"
msg_no_leap:
	.asciiz "Khong phai nam nhuan\n"
msg_input_valid:
	.asciiz "Hop le\n"
msg_input_invalid:
	.asciiz "Khong hop le\n"
msg_next_2_leap_year:
	.asciiz "Hai nam nhuan tiep theo la : "
str_Jan:
	.asciiz "January"
str_Feb:
	.asciiz "February"
str_Mar:
	.asciiz "March"
str_Apr:
	.asciiz "April"
str_May:
	.asciiz "May"
str_Jun:
	.asciiz "June"
str_Jul:
	.asciiz "July"
str_Aug:
	.asciiz "August"
str_Sep:
	.asciiz "September"
str_Oct:
	.asciiz "October"
str_Nov:
	.asciiz "November"
str_Dec:
	.asciiz "December"
str_Mon:
	.asciiz "Mon"
str_Tue:
	.asciiz "Tues"
str_Wed:
	.asciiz "Wed"
str_Thu:
	.asciiz "Thurs"
str_Fri:
	.asciiz "Fri"
str_Sat:
	.asciiz "Sat"
str_Sun:
	.asciiz "Sun"

        .text
# Ham main yeu cau nguoi dung nhap ngay, thang, nam luu vao TIME_1
# Yeu cau nhap lai neu khong hop le
# 	$s0 luu chuoi TIME_1
# 	$s1 luu tinh hop le cua chuoi TIME_1 : 	1 - hop le, 0 - khong hop le
# 	$s2 luu lua chon cua nguoi dung
main:

main_time_input:
	la $a0, TIME_1
	la $a1, time_temp
	jal time_input
	add $s0, $0, $v0	# luu TIME_1
	add $s1, $0, $v1	# luu tinh hop le TIME_1
	beq $s1, $0, main_time_input_again 	# khong hop le
	j main_select
main_time_input_again:
	la $a0, msg_input_invalid
	addi $v0, $0, 4
	syscall
	j main_time_input

main_select:
	la $a0, msg_select
	addi $v0, $0, 4	
	syscall
	la $a0, select_1
	addi $v0, $0, 4	
	syscall
	la $a0, select_2
	addi $v0, $0, 4	
	syscall
	la $a0, select_3
	addi $v0, $0, 4	
	syscall
	la $a0, select_4
	addi $v0, $0, 4	
	syscall
	la $a0, select_5
	addi $v0, $0, 4	
	syscall
	la $a0, select_6
	addi $v0, $0, 4	
	syscall
	la $a0, select_7
	addi $v0, $0, 4	
	syscall

	# Doc yeu cau cua nguoi dung, luu vao $s2
	la $a0, msg_choose
	addi $v0, $0, 4
	syscall
	
	addi $v0, $0, 5
	syscall
	add $s2, $0, $v0

	addi $t0, $0, 1		# yeu cau 1
	beq $s2, $t0, main_select_1
	addi $t0, $0, 2		# yeu cau 2
	beq $s2, $t0, main_select_2
	addi $t0, $0, 3		# yeu cau 3
	beq $s2, $t0, main_select_3
	addi $t0, $0, 4 	# yeu cau 4
	beq $s2, $t0, main_select_4
	addi $t0, $0, 5 	# yeu cau 5
	beq $s2, $t0, main_select_5
	addi $t0, $0, 6 	# yeu cau 6
	beq $s2, $t0, main_select_6
	addi $t0, $0, 7 	# yeu cau 7
	beq $s2, $t0, main_select_7

	j main_select_invalid
main_select_1:
	# Print DD/MM/YYYY
	la $a0, msg_result
	addi $v0, $0, 4
	syscall
	
	add $a0, $0, $s0	# TIME_1
	addi $v0, $0, 4	
	syscall
	j main_exit

main_select_2:
	# Chon dinh dang A, B hay C
	la $a0, select_2_type
	addi $v0, $0, 4	
	syscall
	addi $v0, $0, 12	
	syscall
	add $s2, $0, $v0	# $s2 = type

	# print new line
	add $a0, $0, 10	# 10 = '\n'
	addi $v0, $0, 11	
	syscall

	# Convert
	add $a0, $0, $s0	# TIME_1
	add $a1, $0, $s2	
	jal Convert
	
	la $a0, msg_result
	addi $v0, $0, 4
	syscall
	
	add $a0, $0, $s0
	addi $v0, $0, 4	
	syscall
	j main_exit

main_select_3:
	addi $sp, $sp, -4
	add $a0, $0, $s0
	jal Weekday
	sw $v0, 0($sp)
	
	la $a0, msg_result
	addi $v0, $0, 4
	syscall
	
	lw $a0, 0($sp)
	addi $v0, $0, 4	
	syscall
	addi $sp, $sp, 4
	j main_exit

main_select_4:
	la $a0, msg_result
	addi $v0, $0, 4
	syscall
	add $a0, $0, $s0	# TIME_1
	jal LeapYear
	beq $v0, $0, main_select_4_no_leap
	la $a0, msg_leap
	addi $v0, $0, 4	
	syscall
	jal main_select_4_exit
main_select_4_no_leap:
	la $a0, msg_no_leap
	addi $v0, $0, 4	
	syscall
	jal main_select_4_exit
main_select_4_exit:
	j main_exit

main_select_5:
	addi $sp, $sp, -4
	# doc TIME_2
	la $a0, TIME_2
	la $a1, time_temp
	jal time_input

	# Tinh khoang cach
	la $a0, TIME_1
	la $a1, TIME_2
	jal GetTime
	sw $v0, 0($sp)
	
	la $a0, msg_result
	addi $v0, $0, 4
	syscall
	
	lw $a0, 0($sp)
	addi $v0, $0, 1	
	syscall
	addi $sp, $sp, 4
	j main_exit

main_select_6:
	la $a0, msg_result
	addi $v0, $0, 4
	syscall
	la $a0, msg_next_2_leap_year
	addi $v0, $0, 4	
	syscall

	add $a0, $0, $s0
	jal next_leap_year
	add $a0, $0, $v0	# luu nam nhuan 1
	add $s3, $0, $v1	# luu nam nhuan 2
	addi $v0, $0, 1 	
	syscall

	add $a0, $0, 32	# 32 = ' '
	addi $v0, $0, 11	
	syscall

	add $a0, $0, $s3 
	addi $v0, $0, 1	
	syscall
	j main_exit

main_select_7:
	la $a0, msg_result
	addi $v0, $0, 4
	syscall
	
	beq $s1, $0, main_select_7_input_invalid
	la $a0, msg_input_valid
	addi $v0, $0, 4	
	syscall
	j main_select_7_exit
main_select_7_input_invalid:
	la $a0, msg_input_invalid
	addi $v0, $0, 4	
	syscall
main_select_7_exit:
	j main_exit

main_select_invalid:
	la $a0, msg_select_invalid
	addi $v0, $0, 4	
	syscall
	j main_select

main_exit:
        addi $v0, $0, 10
        syscall

# Ham tra ve chuoi TIME theo dinh dang DD/MM/YYYY
#       $a0 : day
#       $a1 : month
#       $a2 : year
#       $a3 : chuoi TIME
#		$v0 : chuoi TIME dang DD/MM/YYYY
Date:
	# day -> DD
	addi $t1, $0, 10
	div $a0, $t1
	mflo $t2			# $t2 = day / 10
	mfhi $t3			# $t3 = day % 10
	addi $t2, $t2, 48	# chuyen $t2 tu kieu int sang kieu char
	addi $t3, $t3, 48	# chuyen $t3 tu kieu int sang kieu char
	sb $t2, 0($a3)		# TIME[0] = $t2
	sb $t3, 1($a3)		# TIME[1] = $t3
	addi $t4, $0, 47	# 47 = '/'
	sb $t4, 2($a3)		# TIME[2] = '/'

	# month -> MM
	addi $t1, $0, 10
	div $a1, $t1
	mflo $t2			# $t2 = month / 10
	mfhi $t3			# $t3 = month % 10
	addi $t2, $t2, 48	# $t2 from int to char
	addi $t3, $t3, 48	# $t3 from int to char
	sb $t2, 3($a3)		# TIME[3] = $t2
	sb $t3, 4($a3)		# TIME[4] = $t3
	addi $t4, $0, 47	# 47 = '/'
	sb $t4, 5($a3)		# TIME[5] = '/'

	# year -> YYYY
	add $t0, $0, $a2	# $t0 luu year
	addi $t1, $0, 1000
	div $t0, $t1
	mflo $t2			# $t2 = year / 1000
	mfhi $t0			# $t0 = year % 1000
	addi $t2, $t2, 48
	sb $t2, 6($a3)		# TIME[6] = $t2

	addi $t1, $0, 100
	div $t0, $t1
	mflo $t2			# $t2 = (year % 1000) / 100
	mfhi $t0			# $t0 = year % 100
	addi $t2, $t2, 48
	sb $t2, 7($a3)		# TIME[7] = $t2

	addi $t1, $0, 10
	div $t0, $t1
	mflo $t2			# $t2 = (year % 100) / 10
	mfhi $t0			# $t0 = year % 10
	addi $t2, $t2, 48
	addi $t0, $t0, 48
	sb $t2, 8($a3)		# TIME[8] = $t2
	sb $t0, 9($a3)		# TIME[9] = $t0

	sb $0, 10($a3)		# TIME[10] = '\0'
	add $v0, $0, $a3	# tra ve dia chi TIME
	jr $ra

# Ham chuyen doi dinh dang DD/MM/YYYY
#	$a0 : TIME
#	$a1 : type		A, B, C
#	+ type 'A': MM/DD/YYYY
#	+ type 'B': Month DD, YYYY
#	+ type 'C': DD Month, YYYY
Convert:
	addi $t0, $0, 65	# 65 = 'A'
	beq $a1, $t0, Convert_A
	addi $t0, $0, 66	# 66 = 'B'
	beq $a1, $t0, Convert_B
	addi $t0, $0, 67	# 67 = 'C'
	beq $a1, $t0, Convert_C
	j Convert_invalid
Convert_A:
	# DD/MM/YYYY -> MM/DD/YYYY
	lb $t0, 0($a0)		# $t0 = TIME[0]
	lb $t1, 1($a0)		# $t1 = TIME[1]
	lb $t3, 3($a0)		# $t3 = TIME[3]
	lb $t4, 4($a0)		# $t4 = TIME[4]
	
	#$t1,$t2 = DD	$t3,$t4 = MM
	# hoan doi DD va MM
	sb $t3, 0($a0)		# TIME[0] = $t3
	sb $t4, 1($a0)		# TIME[1] = $t4
	sb $t0, 3($a0)		# TIME[3] = $t0
	sb $t1, 4($a0)		# TIME[4] = $t1
	j Convert_exit
Convert_B:
	# DD/MM/YYYY -> Month DD, YYYY
	addi $sp, $sp, -24
	sw $ra, 20($sp)
	sw $a0, 16($sp)
	sw $a1, 12($sp)

	# TIME = month + '" DD, " +  YYYY = temp_1 + month + temp_2
	
	# Chuyen thang MM thanh string tuong ung 	Vd: Thang 1 -> January
	jal Month
	add $a0, $0, $v0	# $a0 = month
	jal Month_to_string
	sw $v0, 8($sp)		# luu month (string)

	lw $a0, 16($sp)		# $a0 = TIME

	# Copy xau " DD, " tu TIME[0-1] vao temp_1
	la $t0, temp_1
	addi $t1, $0, 32	# 32 = ' '
	sb $t1, 0($t0)		# temp_1[0] = ' '

	lb $t1, 0($a0)		# $t1 = TIME[0]
	sb $t1, 1($t0)		# temp_1[1] = $t1
	lb $t1, 1($a0)		# $t2 = TIME[1]
	sb $t1, 2($t0)		# temp_1[2] = $t2

	addi $t1, $0, 44	# 44 = ','
	sb $t1, 3($t0)		# temp_1[3] = ','
	addi $t1, $0, 32	# 32 = ' '
	sb $t1, 4($t0)		# temp_1[4] = ' '
	sb $0, 5($t0)		# temp_1[5] = '\0'
	sw $t0, 4($sp)		# luu temp_1

	# Copy YYYY tu TIME[6:9] vao temp_2
	la $t0, temp_2
	lb $t1, 6($a0) 		# $t1 = TIME[6]
	sb $t1, 0($t0)		# temp_2[0] = $t1
	lb $t1, 7($a0) 		# $t1 = TIME[7]
	sb $t1, 1($t0)		# temp_2[1] = $t1
	lb $t1, 8($a0) 		# $t1 = TIME[8]
	sb $t1, 2($t0)		# temp_2[2] = $t1
	lb $t1, 9($a0) 		# $t1 = TIME[9]
	sb $t1, 3($t0)		# temp_2[3] = $t1
	sb $0, 4($t0)		# temp_2[4] = '\0'
	sw $t0, 0($sp) 		# luu temp_2

	# Ghep month, temp_1, temp_2 vao TIME
	lw $a1, 8($sp)		# $a1 = month 
	jal strcpy

	# Noi " DD, " luu trong temp_1 vao TIME
	lw $a1, 4($sp)		# $a1 = temp_1
	jal strcat

	# Noi "YYYY" luu trong temp_2 vao TIME
	lw $a1, 0($sp)		# $a1 = temp_2
	jal strcat

	lw $ra, 20($sp)
	lw $a0, 16($sp)
	lw $a1, 12($sp)
	addi $sp, $sp, 24

	j Convert_exit
Convert_C:
	# DD/MM/YYYY -> DD Month, YYYY
	
	addi $sp, $sp, -24
	sw $ra, 20($sp)
	sw $a0, 16($sp)
	sw $a1, 12($sp)

	# TIME = "DD " + month + ", YYYY" = temp_1 + month + temp_2
	
	jal Month
	add $a0, $0, $v0	# $a0 = month (int)
	jal Month_to_string
	sw $v0, 8($sp)		# luu month (string)

	lw $a0, 16($sp)		# $a0 = TIME

	# Copy "DD " vao temp_1
	la $t0, temp_1
	lb $t1, 0($a0)		# D1 = TIME[0]
	sb $t1, 0($t0)		# temp_1[0] = D1
	lb $t1, 1($a0)		# D2 = TIME[1]
	sb $t1, 1($t0)		# temp_1[1] = D2

	addi $t1, $0, 32	# 32 = ' '
	sb $t1, 2($t0)		# temp_1[2] = ' '
	sb $0, 3($t0)	# temp_1[3] = '\0'
	sw $t0, 4($sp)		# luu temp_1

	# Copy ", YYYY" vao temp_2
	la $t0, temp_2
	addi $t1, $0, 44	# 44 = ','
	sb $t1, 0($t0)		# temp_2[0] = ','
	addi $t1, $0, 32	# 32 = ' '
	sb $t1, 1($t0)		# temp_2[1] = ' '

	lb $t1, 6($a0) 		# $t1 = TIME[6]
	sb $t1, 2($t0)		# temp_2[2] = $t1
	lb $t1, 7($a0) 		# $t1 = TIME[7]
	sb $t1, 3($t0)		# temp_2[3] = $t1
	lb $t1, 8($a0) 		# $t1 = TIME[8]
	sb $t1, 4($t0)		# temp_2[4] = $t1
	lb $t1, 9($a0) 		# $t1 = TIME[9]
	sb $t1, 5($t0)		# temp_2[5] = $t1
	sb $0, 6($t0)	# TIME_2[6] = '\0'
	sw $t0, 0($sp) 		# luu temp_2

	# Ghep temp_1, month va temp_2 vao TIME
	lw $a1, 4($sp)		# $a1 = temp_1
	jal strcpy

	lw $a1, 8($sp)		# $a1 = month (string)
	jal strcat

	lw $a1, 0($sp)		# $a1 = temp_2
	jal strcat

	lw $ra, 20($sp)
	lw $a0, 16($sp)
	lw $a1, 12($sp)
	addi $sp, $sp, 24

	j Convert_exit
Convert_invalid:
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $a1, 0($sp)

	la $a0, msg_type_invalid
	addi $v0, $0, 4	
	syscall

	lw $a0, 4($sp)
	lw $a1, 0($sp)
	addi $sp, $sp, 8
	j main_select_2
Convert_exit:
	add $v0, $0, $a0	# tra ve dia chi TIME
	jr $ra

# Ham tra ve ngay trong TIME theo dinh dang DD/MM/YYYY
#	$a0 : chuoi TIME
#	$v0 : ngay trong TIME
Day:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# ngay luu tu vi tri 0 den vi tri 1 trong TIME
	add $a1, $0, $0
	addi $a2, $0, 1
	jal string_to_int_part

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham tra ve thang trong TIME theo dinh dang DD/MM/YYYY
#	$a0 : chuoi TIME
# 	$v0 : thang trong TIME
Month:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# ngay luu tu vi tri 3 den vi tri 5 trong TIME
	addi $a1, $0, 3
	addi $a2, $0, 4
	jal string_to_int_part

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham tra ve nam trong TIME theo dinh dang DD/MM/YYYY
#	$a0 : chuoi TIME
# 	$v0 : nam trong TIME
Year:
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Nam luu tu vi tri 6 den vi tri 9 trong TIME
	addi $a1, $0, 6
	addi $a2, $0, 9
	jal string_to_int_part

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham kiem tra nam nhuan voi input la TIME
#	$a0 : TIME
# 	$v0 : 1 - la nam nhuan, 0 - khong phai nam nhuan
LeapYear:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	jal Year
	add $a0, $0, $v0
	jal is_leap_year

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
# Ham tinh so nam cach biet giua TIME_1 va TIME_2
#	$a0 : TIME_1
#	$a1 : TIME_2
GetTime:
	addi $sp, $sp, -40
	sw $ra, 36($sp)
	sw $a0, 32($sp)
	sw $a1, 28($sp)
	
	# a0 = TIME_1
	jal Year
	sw $v0, 24($sp)	# year TIME_1
	jal Month
	sw $v0, 20($sp) # month TIME_1
	jal Day
	sw $v0, 16($sp) # day TIME_1
	
	lw $a0, 28($sp)	# a0 = TIME_2
	jal Year
	sw $v0, 12($sp)	# year TIME_2
	jal Month
	sw $v0, 8($sp) # month TIME_2
	jal Day
	sw $v0, 4($sp) # day TIME_2
	
	
	lw $t0, 24($sp)
	lw $t1, 12($sp)
	sub $v0, $t1, $t0
	
	# neu year (a0) = year (a1) => ket qua do chenh lech nam luon la 0
	beq $v0, $0, GetTime_exit
	
	slt $t0, $v0, $0
	bne $t0, $0, GetTime_Swap
	j GetTime_case_1
GetTime_Swap:
	lw $a0, 28($sp)
	lw $a1, 32($sp)
	sub $v0, $0, $v0
GetTime_case_1:
	sw $v0, 0($sp)		# luu tam ket qua vao stack
	# hien tai a0 > a1
	# Neu (month (a1) > month (a0)) || (month (a1) == month (a0) && day (a1) > day (a0)) thi lay ket qua tru 1
	# case 1 : month (a1) > month (a0)
	lw $t1, 20($sp)	# t1 = month (a0)

	lw $t2, 8($sp)	# t2 = month (a1)
	
	slt $t0, $t1, $t2
	bne $t0, $0, GetTime_exit	# month (a1) < month (a0) => Ket qua khong doi
	
	beq $t1, $t2, GetTime_case_2	# month (a1) = month (a0) => xet case 2
	
	lw $v0, 0($sp)
	addi $v0, $v0, -1	# month (a1) > month (a0) => lay ket qua tru 1
	sw $v0, 0($sp)
	j GetTime_exit
GetTime_case_2:	
	# case 2 : month (a1) == month (a0) && day (a1) > day (a0)
	lw $t1, 16($sp)	# t1 = day (a0)
	lw $t2, 4($sp)	# t2 = day (a1)
	slt $t0, $t2, $t1
	beq $t0, $0, GetTime_exit
	lw $v0, 0($sp)
	addi $v0, $v0, -1
	sw $v0, 0($sp)
GetTime_exit:	
	lw $ra, 36($sp)
	lw $a0, 32($sp)
	lw $a1, 28($sp)
	lw $v0, 0($sp)
	addi $sp, $sp, 40
	jr $ra
	
# Ham tra ve thu trong tuan cua ngay trong TIME
# Cong thuc Gauss tinh thu trong tuan :
# WeekDay = (d + m + Y + C) mod 7
#	d : day
#	m : month code
# 	Month:	1	2	3	4	5	6	7	8	9	10	11	12
#	Code:	0	3	2	5	0	3	5	1	4	6	2	4
#	Y : year code		Y = y + y div 4		voi y la 2 chu so cuoi trong year
#	C : century code 	C = ( c div 4 - 2 * c ) mod 7 voi c la 2 chu so dau cua year
#	Weekday:	0	1	2	3	4	5	6
#	Result:	Sun	Mon	Tue	Wed	Thu	Fri	Sat
#	$a0 : TIME
#	$v0 : Thu trong tuan
Weekday:
	addi $sp, $sp, -32
	sw $ra, 28($sp)
	sw $a0, 24($sp)
	
	jal Day
	sw $v0, 20($sp)	
	
	jal Month
	sw $v0, 16($sp)
	
	jal Year
	sw $v0, 12($sp)
	
	lw $a0, 16($sp)
	jal get_month_code
	sw $v0, 8($sp)
	
	lw $a0, 12($sp)
	jal get_year_code
	sw $v0, 4($sp)
	
	lw $a0, 12($sp)
	jal get_century_code
	sw $v0, 0($sp)
	
	lw $t0, 20($sp)		# t0 = d
	lw $t1, 8($sp)		# t1 = m
	lw $t2, 4($sp)		# t2 = Y
	lw $t3, 0($sp)		# t3 = C
	
	add $v0, $v0, $t0
	add $v0, $v0, $t1
	add $v0, $v0, $t2
	add $v0, $v0, $t3	# v0 = t0 + t1 + t2 + t3
	
	addi $t0, $0, 7	
	div $v0, $t0
	mfhi $t0		# t0 = v0 mod 7
	
	beq $t0, $0, Sun	# t0 = 0 => Sunday
	
	addi $t1, $0, 1
	beq $t0, $t1, Mon	# t0 = 1 => Monday
	
	addi $t1, $0, 2
	beq $t0, $t1, Tue	# Tuesday
	
	addi $t1, $0, 3
	beq $t0, $t1, Wed	# Wednesday
	
	addi $t1, $0, 4
	beq $t0, $t1, Thu	# Thursday
	
	addi $t1, $0, 5
	beq $t0, $t1, Fri	# Friday
	
	addi $t1, $0, 6
	beq $t0, $t1, Sat	# Saturday
Sun:
	la $v0, str_Sun
	j Weekday_exit
Mon:
	la $v0, str_Mon
	j Weekday_exit
Tue:
	la $v0, str_Tue
	j Weekday_exit
Wed:
	la $v0, str_Wed
	j Weekday_exit
Thu:
	la $v0, str_Thu
	j Weekday_exit
Fri:
	la $v0, str_Fri
	j Weekday_exit
Sat:
	la $v0, str_Sat
Weekday_exit:
	lw $ra, 28($sp)
	lw $a0, 24($sp)
	addi $sp, $sp, 32
	jr $ra
	
# Ham nhap thoi gian theo ngay, thang, nam
# Nhap bang string, sau do kiem tra hop le:
#	- only digits (syntax, "ab/2/1000" = no-valid)
#	- valid date (logic, "30/2/2000" = no-valid)
#	$a0 TIME 		luu DD/MM/YYYY
#	$a1 time_temp		bien tam
# 	$v0 TIME 		tra ve vi tri TIME
#	$v1 tinh hop le 	1 - hop le, 0 - khong hop le
time_input:
	
	addi $sp, $sp, -36
	sw $s0, 32($sp)		# luu tinh hop le chuoi ngay, thang, nam
	sw $ra, 28($sp)
	sw $a0, 24($sp)
	sw $a1, 20($sp)

	# $s0 kiem tra hop le bang cach
	# tinh tong hop le ngay thang nam
	# neu $s0 == 3, ngay thang nam deu hop le
	add $s0, $0, $0

	# Nhap chuoi ngay
	addi $v0, $0, 4	
	la $a0, msg_day
	syscall
	addi $v0, $0, 8	# syscall read string
	lw $a0, 20($sp)		# $a0 luu time_temp
	addi $a1, $0, 20	# max size of time_temp
	syscall
	jal is_only_digits	# kiem tra hop le syntax ngay
	add $s0, $s0, $v0 	# $s0 += hop le ngay
	# Chuyen ngay string -> int
	lw $a0, 20($sp)		# $a0 luu time_temp
	jal string_to_int_all
	sw $v0, 16($sp)		# luu ngay dang int vao stack

	# Nhap chuoi thang
	addi $v0, $0, 4	
	la $a0, msg_month
	syscall
	addi $v0, $0, 8	# syscall read string
	lw $a0, 20($sp)		# $a0 luu time_temp
	addi $a1, $0, 20 	# max size of time_temp
	syscall
	jal is_only_digits 	# kiem tra hop le syntax thang
	add $s0, $s0, $v0	# $s0 += hop le thang
	# Chuyen thang string -> int
	lw $a0, 20($sp)		# $a0 luu time_temp
	jal string_to_int_all
	sw $v0, 12($sp) 	# luu thang dang int vao stack

	# Nhap chuoi nam
	addi $v0, $0, 4	
	la $a0, msg_year
	syscall
	addi $v0, $0, 8 	# syscall read string
	lw $a0, 20($sp) 	# $a0 luu time_temp
	addi $a1, $0, 20 	# max size of time_temp
	syscall
	jal is_only_digits 	# kiem tra hop le syntax nam
	add $s0, $s0, $v0	# $s0 += hop le nam
	# Chuyen nam string -> int
	lw $a0, 20($sp) 	# $a0 luu time_temp
	jal string_to_int_all
	sw $v0, 8($sp) 		# luu nam dang int vao stack

	# Nhap vap TIME theo chuan DD/MM/YYYY
	lw $a0, 16($sp)		# ngay dang int
	lw $a1, 12($sp)		# thang dang int
	lw $a2, 8($sp) 		# nam dang int
	lw $a3, 24($sp) 	# dia chi luu TIME
	jal Date

	# Kiem tra TIME hop le syntax
	addi $t0, $0, 3	# tong hop le ngay thang nam
	bne $s0, $t0, time_input_invalid

	# Kiem tra TIME hop le logic
	lw $a0, 24($sp)
	jal check_time_valid
	beq $v0, $0, time_input_invalid

	addi $v1, $0, 1	# $v1 = 1, hop le
	j time_input_exit
time_input_invalid:
	add $v1, $0, $0	# $v1 = 0, khong hop le
time_input_exit:
	
	lw $s0, 32($sp)
	lw $ra, 28($sp)
	lw $a0, 24($sp)
	lw $a1, 20($sp)
	addi $sp, $sp, 36

	add $v0, $0, $a0	# $v0 tra ve dia chi TIME
	jr $ra	

# Ham kiem tra tinh hop le cua ngay, thang, nam vua nhap
# 	$a0 TIME
# 	$v0 tinh hop le 	1 - hop le, 0 - khong hop le
check_time_valid:
	
	addi $sp, $sp, -12
	sw $ra, 8($sp)

	# Check month in 1..12
	jal Month
	add $t1, $0, $v0			# $t1 = month
	slti $t0, $t1, 1
	bne $t0, $0, check_time_valid_khong 	# neu month < 1
	slti $t0, $t1, 13
	beq $t0, $0 , check_time_valid_khong 	# neu month >= 13
	sw $t1, 4($sp)				# $t1 will lose in next jal

	# Check day in month
	jal Day
	add $t2, $0, $v0			# $t2 = day
	lw $t1, 4($sp)				# restore $t1 after jal

	addi $t3, $0, 1			# $t3 = thang 1
	beq $t1, $t3, check_31_ngay
	addi $t3, $0, 2			# $t3 = thang 2
	beq $t1, $t3, check_thang_2
	addi $t3, $0, 3
	beq $t1, $t3, check_31_ngay
	addi $t3, $0, 4
	beq $t1, $t3, check_30_ngay
	addi $t3, $0, 5
	beq $t1, $t3, check_31_ngay
	addi $t3, $0, 6
	beq $t1, $t3, check_30_ngay
	addi $t3, $0, 7
	beq $t1, $t3, check_31_ngay
	addi $t3, $0, 8
	beq $t1, $t3, check_31_ngay
	addi $t3, $0, 9
	beq $t1, $t3, check_30_ngay
	addi $t3, $0, 10
	beq $t1, $t3, check_31_ngay
	addi $t3, $0, 11
	beq $t1, $t3, check_30_ngay
	addi $t3, $0, 12
	beq $t1, $t3, check_31_ngay
check_31_ngay:
	slti $t0, $t2, 1
	bne $t0, $0, check_time_valid_khong	# neu day < 1
	slti $t0, $t2, 32
	beq $t0, $0, check_time_valid_khong	# neu day >= 32
	j check_time_valid_co
check_30_ngay:
	slti $t0, $t2, 1
	bne $t0, $0, check_time_valid_khong	# neu day < 1
	slti $t0, $t2, 31
	beq $t0, $0, check_time_valid_khong	# neu day >= 31
	j check_time_valid_co
check_thang_2:
	slti $t0, $t2, 1
	bne $t0, $0, check_time_valid_khong	# neu day <
	slti $t0, $t2, 30
	beq $t0, $0, check_time_valid_khong	# neu day >= 30
	sw $t2, 0($sp)				# luu $t2 before jal
	jal LeapYear
	add $t4, $0, $v0			# check nam khong nhuan
	lw $t2, 0($sp)				# restore $t2 after jal
	beq $t4, $0, check_thang_2_khong_nhuan	# neu nam khong nhuan
	j check_time_valid_co
check_thang_2_khong_nhuan:
	addi $t5, $0, 29
	beq $t2, $t5, check_time_valid_khong	# neu day = 29
	j check_time_valid_co
check_time_valid_co:
	addi $v0, $0, 1			# $v0 = 1, hop le
	j check_time_valid_exit
check_time_valid_khong:
	add $v0, $0, $0			# $v0 = 0, khong hop le
	j check_time_valid_exit
check_time_valid_exit:
	
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

# Ham kiem tra tinh hop le cua ngay, thang, nam trong TIME
# TIME hop le neu ngay thang nam deu chi chua chu so [0-9]
# 	$a0 : chuoi ngay, thang, nam can kiem tra
# 	$v0 : tinh hop le 	1 - hop le, 0 - khong hop le
is_only_digits:
	add $t0, $0, $a0	
	addi $v0, $0, 1				# $v0 = 1, mac dinh la hop le
is_only_digits_loop:
	lb $t1, 0($t0)				# $t1 = *p
	beq $t1, $0, is_only_digits_exit 	# $t1 = '\0' = NULL
	addi $t2, $0, 10
	beq $t1, $t2, is_only_digits_exit 	# $t1 = '\n'
	slti $t2, $t1, 48			# 48 la '0'
	bne $t2, $0, is_only_digits_no	# $t1 < '0'
	slti $t2, $t1, 58			# 57 la '9'
	beq $t2, $0, is_only_digits_no	# $t1 > '9'
	addi $t0, $t0, 1	
	j is_only_digits_loop
is_only_digits_no:
	add $v0, $0, $0				# $v0 = 0, khong hop le
is_only_digits_exit:
	jr $ra

# Ham tra ve ten thang trong nam
#	$a0 month (integer)
# 	$v0 month (string)
Month_to_string:
	slti $t0, $a0, 2 	# month = 1
	bne $t0, $0, Jan 	

	slti $t0, $a0, 3 	# month = 2
	bne $t0, $0, Feb 	

	slti $t0, $a0, 4	# month = 3
	bne $t0, $0, Mar 	

	slti $t0, $a0, 5 	# month = 4
	bne $t0, $0, Apr 	

	slti $t0, $a0, 6 	# month = 5
	bne $t0, $0, May 	

	slti $t0, $a0, 7 	# month = 6
	bne $t0, $0, Jun 	

	slti $t0, $a0, 8 	# month = 7
	bne $t0, $0, Jul 	

	slti $t0, $a0, 9 	# month = 8
	bne $t0, $0, Aug 	

	slti $t0, $a0, 10 	# month = 9
	bne $t0, $0, Sep 	

	slti $t0, $a0, 11 	# month = 10
	bne $t0, $0, Oct 	

	slti $t0, $a0, 12 	# month = 11
	bne $t0, $0, Nov 	

	j Dec 			# month = 12
Jan:
	la $v0, str_Jan
	j Month_to_string_exit
Feb:
	la $v0, str_Feb
	j Month_to_string_exit
Mar:
	la $v0, str_Mar
	j Month_to_string_exit
Apr:
	la $v0, str_Apr
	j Month_to_string_exit
May:
	la $v0, str_May
	j Month_to_string_exit
Jun:
	la $v0, str_Jun
	j Month_to_string_exit
Jul:
	la $v0, str_Jul
	j Month_to_string_exit
Aug:
	la $v0, str_Aug
	j Month_to_string_exit
Sep:
	la $v0, str_Sep
	j Month_to_string_exit
Oct:
	la $v0, str_Dec
	j Month_to_string_exit
Nov:
	la $v0, str_Nov
	j Month_to_string_exit
Dec:
	la $v0, str_Dec
Month_to_string_exit:
	jr $ra
	
# Ham kiem tra nam nhuan chi voi nam
# 	$a0 year
is_leap_year:
	addi $t0, $0, 400
	div $a0, $t0
	mfhi $t1				# $t1 = year % 400
	beq $t1, $0, is_leap_year_true	# neu year chia het cho 400

	addi $t0, $0, 4
	div $a0, $t0
	mfhi $t1 				# $t1 = year % 4
	bne $t1, $0, is_leap_year_false # neu year khong chia het cho 4

	addi $t0, $0, 100
	div $a0, $t0
	mfhi $t1 				# $t2 = year % 100
	beq $t1, $0, is_leap_year_false # neu year chia het cho 4 va 100
is_leap_year_true:
	addi $v0, $0, 1			# $t0 tra ve 1 la nam nhuan
	j is_leap_year_exit
is_leap_year_false:
	add $v0, $0, $0			# $t0 tra ve 0 la nam khnog nhuan
is_leap_year_exit:
	jr $ra

# Ham lay code tu month
#	$a0 : month
#	$v0 : month code
get_month_code:

case_1:	
	addi $t0, $0, 1
	bne $a0, $t0, case_2	# month != 1 -> xet TH2
	add $v0, $0, $0
	j get_month_code_exit
case_2:	
	addi $t0, $0, 2
	bne $a0, $t0, case_3	# month != 2 -> xet TH3
	addi $v0, $0, 3
	j get_month_code_exit
case_3:	
	addi $t0, $0, 3
	bne $a0, $t0, case_4	# month != 3 -> xet TH4
	addi $v0, $0, 2
	j get_month_code_exit
case_4:	
	addi $t0, $0, 4
	bne $a0, $t0, case_5
	addi $v0, $0, 5
	j get_month_code_exit
case_5:	
	addi $t0, $0, 5
	bne $a0, $t0, case_6	
	add $v0, $0, $0
	j get_month_code_exit
case_6:	
	addi $t0, $0, 6
	bne $a0, $t0, case_7	
	addi $v0, $0, 3
	j get_month_code_exit
case_7:	
	addi $t0, $0, 7
	bne $a0, $t0, case_8	
	addi $v0, $0, 5
	j get_month_code_exit
case_8:	
	addi $t0, $0, 8
	bne $a0, $t0, case_9	
	addi $v0, $0, 1
	j get_month_code_exit
case_9:	
	addi $t0, $0, 9
	bne $a0, $t0, case_10	
	addi $v0, $0, 4
	j get_month_code_exit
case_10:	
	addi $t0, $0, 10
	bne $a0, $t0, case_11	
	addi $v0, $0, 6
	j get_month_code_exit
case_11:	
	addi $t0, $0, 11
	bne $a0, $t0, case_12	
	addi $v0, $0, 2
	j get_month_code_exit
case_12:	
	addi $v0, $0, 4
get_month_code_exit:
	jr $ra
	
# Ham lay year code tu 2 chu so cuoi cua year
#	$a0 : year
#	$v0 : year code
get_year_code:
	addi $t0, $0, 100
	div $a0, $t0
	mfhi $t0	# t0 = year % 100
	addi $t1, $0, 4
	div $t0, $t1
	mflo $t1	# t1 = (year % 100) div 4
	add $v0, $t0, $t1
	jr $ra
	
# Ham lay century code tu 2 chu so dau cua year
#	$a0 : year
#	$v0 : year code
get_century_code:
	addi $t0, $0, 100
	div $a0, $t0
	mflo $t0	# t0 = year div 100 = c
	
	addi $t1, $0, 4
	div $t0, $t1
	mflo $t1	# t1 = (year div 100) div 4
	
	sll $t0, $t0, 1	# t0 = t0 * 2
	sub $t2, $t1, $t0	# t2 = t1 - t0 = c div 4 - 2 * c
	
	addi $t0, $0, 7
	div $t2, $t0
	mfhi $v0	# v0 = t2 % 7
	
	# Kiem tra v0 < 0
	slt $t0, $v0, $0
	beq $t0, $0, get_century_code_exit
	addi $v0, $v0, 7
get_century_code_exit:
	jr $ra	

# Ham tra ve hai nam nhuan gan TIME nhat
# 	$a0 TIME
#	$v0 nam nhuan 1
#	$v1 nam nhuan 2
next_leap_year:
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $a0, 8($sp)

	jal Year
	addi $v0, $v0, 1
	sw $v0, 4($sp)		# i = year + 1
next_leap_year_loop:
	lw $a0, 4($sp)		# get i
	jal is_leap_year
	bne $v0, $0, next_leap_year_next
	lw $t0, 4($sp)
	addi $t0, $t0, 1	# i += 1
	sw $t0, 4($sp)		# luu i
	j next_leap_year_loop
next_leap_year_next:
	lw $a0, 4($sp)		# get i
	addi $a0, $a0, 4	# i += 4 
	sw $a0, 0($sp)
	jal is_leap_year
	bne $v0, $0, next_leap_year_exit
	lw $t0, 4($sp)
	addi $t0, $t0, 8	# i += 8 
	sw $t0, 0($sp)
next_leap_year_exit:
	lw $ra, 12($sp)
	lw $v0, 4($sp)
	lw $v1, 0($sp)
	addi $sp, $sp, 16
	jr $ra
	
# Ham chuyen string tu vi tri i den vi tri j thanh kieu int
#	$a0 : string
#	$a1 : i
#	$a2 : j
#	$v0 : int
string_to_int_part:
	add $v0, $0, $0	# $v0 = result
	add $t0, $a0, $a1		# vi tri bat dau
	add $t1, $a0, $a2		# vi tri ket thuc
	addi $t1, $t1, 1
string_to_int_part_loop:
	slt $t2, $t0, $t1
	beq $t2, $0, string_to_int_part_exit	# gap vi tri ket thuc => ngung vong lap
	# result = result * 10 + $t3 - '0'
	addi $t3, $0, 10
	mult $v0, $t3
	mflo $v0			# result = result * 10
	lb $t3, 0($t0)		# 
	addi $t3, $t3, -48	# chuyen ki tu so thanh kieu int
	add $v0, $v0, $t3	
	addi $t0, $t0, 1	
	j string_to_int_part_loop
string_to_int_part_exit:
	jr $ra

# Ham chuyen toan bo string sang kieu int
# 	$a0 : string
#	$v0 : int
string_to_int_all:
	add $v0, $0, $0		# $v0 = result
	add $t0, $0, $a0	# vi tri bat dau
string_to_int_all_loop:
	lb $t1, 0($t0)							# lay tung ki tu
	beq $t1, $0, string_to_int_all_exit		# gap ki tu ket thuc chuoi '\0'
	# result = result * 10 + *p - '0'
	addi $t2, $0, 10
	beq $t1, $t2, string_to_int_all_exit	# gap ki tu xuong dong '\n'
	mult $v0, $t2
	mflo $v0								# result = result * 10
	addi $t1, $t1, -48						# chuyen ki tu so sang kieu int
	add $v0, $v0, $t1
	add $t0, $t0, 1	
	j string_to_int_all_loop
string_to_int_all_exit:
	jr $ra

# Ham copy string y vao string x
#	$a0 : string x
#	$a1 : string y
strcpy:
	addi $sp, $sp, -4
	sw $s0, 0($sp)

	add $s0, $0, $0 			# i = 0
strcpy_loop:
	add $t0, $s0, $a1			# $t0 = &y[i]
	lb $t1, 0($t0) 				# $t1 = y[i]
	add $t2, $s0, $a0 			# $t2 = &x[i]
	sb $t1, 0($t2) 				# x[i] = y[i]
	beq $t1, $0, strcpy_exit	# Neu x[i]
	addi $s0, $s0, 1			# i += 1
	j strcpy_loop
strcpy_exit:
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham noi string y vao sau string x
#	$a0 : string x
#	$a1 : string y
strcat:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	add $s0, $0, $0			# i = 0
	add $s1, $0, $0 		# j = 0
strcat_find_end_loop:
	add $t3, $a0, $s0
	lb $t4, 0($t3) 			# $t4 = x[i]
	beq $t4, $0, strcat_append_loop	# x[i] = '\0'
	addi $s0, $s0, 1  		# i += 1
	j strcat_find_end_loop
strcat_append_loop:
	add $t4, $a1, $s1 			# $t4 = &y[j]
	lb $t5, 0($t4) 				# $t5 = y[j]
	add $t3, $a0, $s0 			# $t3 = &x[i]
	sb $t5, 0($t3) 				# x[i] = y[j]
	beq $t5, $0, strcat_exit	# neu x[i] = '\0'
	addi $s0, $s0, 1			# i += 1
	addi $s1, $s1, 1			# j += 1
	j strcat_append_loop
strcat_exit:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra

