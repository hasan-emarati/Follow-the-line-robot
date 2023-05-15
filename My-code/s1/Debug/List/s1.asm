
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*******************************************************
;Project :
;Version :  1.8.0
;Date    : 16/01/2023
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega16A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include <mega16a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;void main(void)
; 0000 0015 {

	.CSEG
_main:
; .FSTART _main
; 0000 0016     // Input/Output Ports initialization
; 0000 0017     // Port A initialization
; 0000 0018     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0019     DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 001A     // Port B initialization
; 0000 001B     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 001C     DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(248)
	OUT  0x17,R30
; 0000 001D     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 001E     PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (1<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(8)
	OUT  0x18,R30
; 0000 001F 
; 0000 0020     // Port C initialization
; 0000 0021     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0022     DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(15)
	OUT  0x14,R30
; 0000 0023     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0024     PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0025 
; 0000 0026     // Port D initialization
; 0000 0027     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0028     DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0029     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 002A     PORTD=(1<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(128)
	OUT  0x12,R30
; 0000 002B 
; 0000 002C     while (1)
_0x3:
; 0000 002D     {
; 0000 002E         if (PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==0&&PINA.4==1&&PINA.5==1&&PINA.6==1||PINA.0==0&&PINA.1==0&&PINA.2==0 ...
	SBIS 0x19,0
	RJMP _0x7
	SBIS 0x19,1
	RJMP _0x7
	SBIS 0x19,2
	RJMP _0x7
	SBIC 0x19,3
	RJMP _0x7
	SBIS 0x19,4
	RJMP _0x7
	SBIS 0x19,5
	RJMP _0x7
	SBIC 0x19,6
	RJMP _0x9
_0x7:
	SBIC 0x19,0
	RJMP _0xA
	SBIC 0x19,1
	RJMP _0xA
	SBIC 0x19,2
	RJMP _0xA
	SBIC 0x19,3
	RJMP _0xA
	SBIC 0x19,4
	RJMP _0xA
	SBIC 0x19,5
	RJMP _0xA
	SBIS 0x19,6
	RJMP _0x9
_0xA:
	SBIC 0x19,0
	RJMP _0xC
	SBIC 0x19,1
	RJMP _0xC
	SBIC 0x19,2
	RJMP _0xC
	SBIS 0x19,3
	RJMP _0xC
	SBIC 0x19,4
	RJMP _0xC
	SBIC 0x19,5
	RJMP _0xC
	SBIS 0x19,6
	RJMP _0x9
_0xC:
	SBIS 0x19,0
	RJMP _0xE
	SBIC 0x19,1
	RJMP _0xE
	SBIC 0x19,2
	RJMP _0xE
	SBIS 0x19,3
	RJMP _0xE
	SBIC 0x19,4
	RJMP _0xE
	SBIC 0x19,5
	RJMP _0xE
	SBIS 0x19,6
	RJMP _0x9
_0xE:
	SBIS 0x19,0
	RJMP _0x10
	SBIS 0x19,1
	RJMP _0x10
	SBIC 0x19,2
	RJMP _0x10
	SBIS 0x19,3
	RJMP _0x10
	SBIC 0x19,4
	RJMP _0x10
	SBIC 0x19,5
	RJMP _0x10
	SBIS 0x19,6
	RJMP _0x9
_0x10:
	SBIS 0x19,0
	RJMP _0x12
	SBIS 0x19,1
	RJMP _0x12
	SBIS 0x19,2
	RJMP _0x12
	SBIS 0x19,3
	RJMP _0x12
	SBIC 0x19,4
	RJMP _0x12
	SBIC 0x19,5
	RJMP _0x12
	SBIS 0x19,6
	RJMP _0x9
_0x12:
	SBIS 0x19,0
	RJMP _0x14
	SBIS 0x19,1
	RJMP _0x14
	SBIS 0x19,2
	RJMP _0x14
	SBIS 0x19,3
	RJMP _0x14
	SBIS 0x19,4
	RJMP _0x14
	SBIC 0x19,5
	RJMP _0x14
	SBIS 0x19,6
	RJMP _0x9
_0x14:
	SBIS 0x19,0
	RJMP _0x16
	SBIS 0x19,1
	RJMP _0x16
	SBIS 0x19,2
	RJMP _0x16
	SBIS 0x19,3
	RJMP _0x16
	SBIS 0x19,4
	RJMP _0x16
	SBIS 0x19,5
	RJMP _0x16
	SBIS 0x19,6
	RJMP _0x9
_0x16:
	SBIS 0x19,0
	RJMP _0x18
	SBIS 0x19,1
	RJMP _0x18
	SBIS 0x19,2
	RJMP _0x18
	SBIS 0x19,3
	RJMP _0x18
	SBIS 0x19,4
	RJMP _0x18
	SBIS 0x19,5
	RJMP _0x18
	SBIC 0x19,6
	RJMP _0x9
_0x18:
	SBIS 0x19,0
	RJMP _0x1A
	SBIC 0x19,1
	RJMP _0x1A
	SBIS 0x19,2
	RJMP _0x1A
	SBIS 0x19,3
	RJMP _0x1A
	SBIC 0x19,4
	RJMP _0x1A
	SBIC 0x19,5
	RJMP _0x1A
	SBIS 0x19,6
	RJMP _0x9
_0x1A:
	SBIC 0x19,0
	RJMP _0x1C
	SBIC 0x19,1
	RJMP _0x1C
	SBIS 0x19,2
	RJMP _0x1C
	SBIS 0x19,3
	RJMP _0x1C
	SBIC 0x19,4
	RJMP _0x1C
	SBIC 0x19,5
	RJMP _0x1C
	SBIS 0x19,6
	RJMP _0x9
_0x1C:
	SBIC 0x19,0
	RJMP _0x1E
	SBIC 0x19,1
	RJMP _0x1E
	SBIS 0x19,2
	RJMP _0x1E
	SBIS 0x19,3
	RJMP _0x1E
	SBIS 0x19,4
	RJMP _0x1E
	SBIC 0x19,5
	RJMP _0x1E
	SBIS 0x19,6
	RJMP _0x9
_0x1E:
	SBIC 0x19,0
	RJMP _0x20
	SBIC 0x19,1
	RJMP _0x20
	SBIS 0x19,2
	RJMP _0x20
	SBIS 0x19,3
	RJMP _0x20
	SBIS 0x19,4
	RJMP _0x20
	SBIS 0x19,5
	RJMP _0x20
	SBIS 0x19,6
	RJMP _0x9
_0x20:
	SBIC 0x19,0
	RJMP _0x22
	SBIS 0x19,1
	RJMP _0x22
	SBIS 0x19,2
	RJMP _0x22
	SBIS 0x19,3
	RJMP _0x22
	SBIS 0x19,4
	RJMP _0x22
	SBIS 0x19,5
	RJMP _0x22
	SBIS 0x19,6
	RJMP _0x9
_0x22:
	SBIC 0x19,0
	RJMP _0x24
	SBIC 0x19,1
	RJMP _0x24
	SBIS 0x19,2
	RJMP _0x24
	SBIS 0x19,3
	RJMP _0x24
	SBIS 0x19,4
	RJMP _0x24
	SBIS 0x19,5
	RJMP _0x24
	SBIS 0x19,6
	RJMP _0x9
_0x24:
	SBIS 0x19,0
	RJMP _0x26
	SBIC 0x19,1
	RJMP _0x26
	SBIS 0x19,2
	RJMP _0x26
	SBIC 0x19,3
	RJMP _0x26
	SBIS 0x19,4
	RJMP _0x26
	SBIC 0x19,5
	RJMP _0x26
	SBIC 0x19,6
	RJMP _0x9
_0x26:
	SBIS 0x19,0
	RJMP _0x28
	SBIC 0x19,1
	RJMP _0x28
	SBIS 0x19,2
	RJMP _0x28
	SBIS 0x19,3
	RJMP _0x28
	SBIS 0x19,4
	RJMP _0x28
	SBIC 0x19,5
	RJMP _0x28
	SBIC 0x19,6
	RJMP _0x9
_0x28:
	SBIC 0x19,0
	RJMP _0x2A
	SBIC 0x19,1
	RJMP _0x2A
	SBIS 0x19,2
	RJMP _0x2A
	SBIS 0x19,3
	RJMP _0x2A
	SBIS 0x19,4
	RJMP _0x2A
	SBIS 0x19,5
	RJMP _0x2A
	SBIS 0x19,6
	RJMP _0x9
_0x2A:
	RJMP _0x6
_0x9:
; 0000 002F         {
; 0000 0030             PORTB.4=1;
	SBI  0x18,4
; 0000 0031             PORTB.5=0;
	CBI  0x18,5
; 0000 0032             PORTB.6=1;
	SBI  0x18,6
; 0000 0033             PORTB.7=0;
	CBI  0x18,7
; 0000 0034         }
; 0000 0035         if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==1&&PINA.6==1) // R
_0x6:
	SBIC 0x19,0
	RJMP _0x36
	SBIC 0x19,1
	RJMP _0x36
	SBIC 0x19,2
	RJMP _0x36
	SBIC 0x19,3
	RJMP _0x36
	SBIS 0x19,4
	RJMP _0x36
	SBIS 0x19,5
	RJMP _0x36
	SBIC 0x19,6
	RJMP _0x37
_0x36:
	RJMP _0x35
_0x37:
; 0000 0036         {
; 0000 0037             PORTB.4=1;
	RCALL SUBOPT_0x0
; 0000 0038             PORTB.5=0;
; 0000 0039             PORTB.6=0;
; 0000 003A             PORTB.7=0;
; 0000 003B         }
; 0000 003C         if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==1) // R
_0x35:
	SBIC 0x19,0
	RJMP _0x41
	SBIC 0x19,1
	RJMP _0x41
	SBIC 0x19,2
	RJMP _0x41
	SBIC 0x19,3
	RJMP _0x41
	SBIC 0x19,4
	RJMP _0x41
	SBIC 0x19,5
	RJMP _0x41
	SBIC 0x19,6
	RJMP _0x42
_0x41:
	RJMP _0x40
_0x42:
; 0000 003D         {
; 0000 003E             PORTB.4=1;
	SBI  0x18,4
; 0000 003F             PORTB.5=0;
	CBI  0x18,5
; 0000 0040             PORTB.6=0;
	CBI  0x18,6
; 0000 0041             PORTB.7=1;
	SBI  0x18,7
; 0000 0042         }
; 0000 0043         if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==0&&PINA.6==0) // R
_0x40:
	SBIC 0x19,0
	RJMP _0x4C
	SBIC 0x19,1
	RJMP _0x4C
	SBIC 0x19,2
	RJMP _0x4C
	SBIC 0x19,3
	RJMP _0x4C
	SBIS 0x19,4
	RJMP _0x4C
	SBIC 0x19,5
	RJMP _0x4C
	SBIS 0x19,6
	RJMP _0x4D
_0x4C:
	RJMP _0x4B
_0x4D:
; 0000 0044         {
; 0000 0045             PORTB.4=1;
	RCALL SUBOPT_0x0
; 0000 0046             PORTB.5=0;
; 0000 0047             PORTB.6=0;
; 0000 0048             PORTB.7=0;
; 0000 0049         }
; 0000 004A         if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==1&&PINA.6==0)// R
_0x4B:
	SBIC 0x19,0
	RJMP _0x57
	SBIC 0x19,1
	RJMP _0x57
	SBIC 0x19,2
	RJMP _0x57
	SBIC 0x19,3
	RJMP _0x57
	SBIC 0x19,4
	RJMP _0x57
	SBIS 0x19,5
	RJMP _0x57
	SBIS 0x19,6
	RJMP _0x58
_0x57:
	RJMP _0x56
_0x58:
; 0000 004B         {
; 0000 004C             PORTB.4=1;
	RCALL SUBOPT_0x0
; 0000 004D             PORTB.5=0;
; 0000 004E             PORTB.6=0;
; 0000 004F             PORTB.7=0;
; 0000 0050         }
; 0000 0051         if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==0&&PINA.6==1)// R
_0x56:
	SBIC 0x19,0
	RJMP _0x62
	SBIC 0x19,1
	RJMP _0x62
	SBIC 0x19,2
	RJMP _0x62
	SBIC 0x19,3
	RJMP _0x62
	SBIS 0x19,4
	RJMP _0x62
	SBIC 0x19,5
	RJMP _0x62
	SBIC 0x19,6
	RJMP _0x63
_0x62:
	RJMP _0x61
_0x63:
; 0000 0052         {
; 0000 0053             PORTB.4=1;
	RCALL SUBOPT_0x0
; 0000 0054             PORTB.5=0;
; 0000 0055             PORTB.6=0;
; 0000 0056             PORTB.7=0;
; 0000 0057         }
; 0000 0058         if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==1&&PINA.6==1)// R
_0x61:
	SBIC 0x19,0
	RJMP _0x6D
	SBIC 0x19,1
	RJMP _0x6D
	SBIC 0x19,2
	RJMP _0x6D
	SBIC 0x19,3
	RJMP _0x6D
	SBIC 0x19,4
	RJMP _0x6D
	SBIS 0x19,5
	RJMP _0x6D
	SBIC 0x19,6
	RJMP _0x6E
_0x6D:
	RJMP _0x6C
_0x6E:
; 0000 0059         {
; 0000 005A             PORTB.4=1;
	RCALL SUBOPT_0x0
; 0000 005B             PORTB.5=0;
; 0000 005C             PORTB.6=0;
; 0000 005D             PORTB.7=0;
; 0000 005E         }
; 0000 005F         if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==1&&PINA.6==0)// R
_0x6C:
	SBIC 0x19,0
	RJMP _0x78
	SBIC 0x19,1
	RJMP _0x78
	SBIC 0x19,2
	RJMP _0x78
	SBIC 0x19,3
	RJMP _0x78
	SBIS 0x19,4
	RJMP _0x78
	SBIS 0x19,5
	RJMP _0x78
	SBIS 0x19,6
	RJMP _0x79
_0x78:
	RJMP _0x77
_0x79:
; 0000 0060         {
; 0000 0061             PORTB.4=1;
	RCALL SUBOPT_0x0
; 0000 0062             PORTB.5=0;
; 0000 0063             PORTB.6=0;
; 0000 0064             PORTB.7=0;
; 0000 0065         }
; 0000 0066         if (PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
_0x77:
	SBIS 0x19,0
	RJMP _0x83
	SBIS 0x19,1
	RJMP _0x83
	SBIS 0x19,2
	RJMP _0x83
	SBIC 0x19,3
	RJMP _0x83
	SBIC 0x19,4
	RJMP _0x83
	SBIC 0x19,5
	RJMP _0x83
	SBIS 0x19,6
	RJMP _0x84
_0x83:
	RJMP _0x82
_0x84:
; 0000 0067         {
; 0000 0068             PORTB.4=0;
	RCALL SUBOPT_0x1
; 0000 0069             PORTB.5=0;
; 0000 006A             PORTB.6=1;
; 0000 006B             PORTB.7=0;
; 0000 006C         }
; 0000 006D         if (PINA.0==1&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
_0x82:
	SBIS 0x19,0
	RJMP _0x8E
	SBIC 0x19,1
	RJMP _0x8E
	SBIC 0x19,2
	RJMP _0x8E
	SBIC 0x19,3
	RJMP _0x8E
	SBIC 0x19,4
	RJMP _0x8E
	SBIC 0x19,5
	RJMP _0x8E
	SBIS 0x19,6
	RJMP _0x8F
_0x8E:
	RJMP _0x8D
_0x8F:
; 0000 006E         {
; 0000 006F             PORTB.4=0;
	CBI  0x18,4
; 0000 0070             PORTB.5=1;
	SBI  0x18,5
; 0000 0071             PORTB.6=1;
	SBI  0x18,6
; 0000 0072             PORTB.7=0;
	CBI  0x18,7
; 0000 0073         }
; 0000 0074         if (PINA.0==0&&PINA.1==1&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
_0x8D:
	SBIC 0x19,0
	RJMP _0x99
	SBIS 0x19,1
	RJMP _0x99
	SBIC 0x19,2
	RJMP _0x99
	SBIC 0x19,3
	RJMP _0x99
	SBIC 0x19,4
	RJMP _0x99
	SBIC 0x19,5
	RJMP _0x99
	SBIS 0x19,6
	RJMP _0x9A
_0x99:
	RJMP _0x98
_0x9A:
; 0000 0075         {
; 0000 0076             PORTB.4=0;
	RCALL SUBOPT_0x1
; 0000 0077             PORTB.5=0;
; 0000 0078             PORTB.6=1;
; 0000 0079             PORTB.7=0;
; 0000 007A         }
; 0000 007B         if (PINA.0==0&&PINA.1==0&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
_0x98:
	SBIC 0x19,0
	RJMP _0xA4
	SBIC 0x19,1
	RJMP _0xA4
	SBIS 0x19,2
	RJMP _0xA4
	SBIC 0x19,3
	RJMP _0xA4
	SBIC 0x19,4
	RJMP _0xA4
	SBIC 0x19,5
	RJMP _0xA4
	SBIS 0x19,6
	RJMP _0xA5
_0xA4:
	RJMP _0xA3
_0xA5:
; 0000 007C         {
; 0000 007D             PORTB.4=0;
	RCALL SUBOPT_0x1
; 0000 007E             PORTB.5=0;
; 0000 007F             PORTB.6=1;
; 0000 0080             PORTB.7=0;
; 0000 0081         }
; 0000 0082         if (PINA.0==1&&PINA.1==0&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
_0xA3:
	SBIS 0x19,0
	RJMP _0xAF
	SBIC 0x19,1
	RJMP _0xAF
	SBIS 0x19,2
	RJMP _0xAF
	SBIC 0x19,3
	RJMP _0xAF
	SBIC 0x19,4
	RJMP _0xAF
	SBIC 0x19,5
	RJMP _0xAF
	SBIS 0x19,6
	RJMP _0xB0
_0xAF:
	RJMP _0xAE
_0xB0:
; 0000 0083         {
; 0000 0084             PORTB.4=0;
	RCALL SUBOPT_0x1
; 0000 0085             PORTB.5=0;
; 0000 0086             PORTB.6=1;
; 0000 0087             PORTB.7=0;
; 0000 0088         }
; 0000 0089         if (PINA.0==1&&PINA.1==1&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
_0xAE:
	SBIS 0x19,0
	RJMP _0xBA
	SBIS 0x19,1
	RJMP _0xBA
	SBIC 0x19,2
	RJMP _0xBA
	SBIC 0x19,3
	RJMP _0xBA
	SBIC 0x19,4
	RJMP _0xBA
	SBIC 0x19,5
	RJMP _0xBA
	SBIS 0x19,6
	RJMP _0xBB
_0xBA:
	RJMP _0xB9
_0xBB:
; 0000 008A         {
; 0000 008B             PORTB.4=0;
	RCALL SUBOPT_0x1
; 0000 008C             PORTB.5=0;
; 0000 008D             PORTB.6=1;
; 0000 008E             PORTB.7=0;
; 0000 008F         }
; 0000 0090         if (PINA.0==0&&PINA.1==1&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
_0xB9:
	SBIC 0x19,0
	RJMP _0xC5
	SBIS 0x19,1
	RJMP _0xC5
	SBIS 0x19,2
	RJMP _0xC5
	SBIC 0x19,3
	RJMP _0xC5
	SBIC 0x19,4
	RJMP _0xC5
	SBIC 0x19,5
	RJMP _0xC5
	SBIS 0x19,6
	RJMP _0xC6
_0xC5:
	RJMP _0xC4
_0xC6:
; 0000 0091         {
; 0000 0092             PORTB.4=0;
	RCALL SUBOPT_0x1
; 0000 0093             PORTB.5=0;
; 0000 0094             PORTB.6=1;
; 0000 0095             PORTB.7=0;
; 0000 0096         }
; 0000 0097         if (PINB.0==1||PINB.1==1)
_0xC4:
	SBIC 0x16,0
	RJMP _0xD0
	SBIS 0x16,1
	RJMP _0xCF
_0xD0:
; 0000 0098         {
; 0000 0099             PORTB.4=0;
	CBI  0x18,4
; 0000 009A             PORTB.5=0;
	CBI  0x18,5
; 0000 009B             PORTB.6=0;
	CBI  0x18,6
; 0000 009C             PORTB.7=0;
	CBI  0x18,7
; 0000 009D         }
; 0000 009E     }
_0xCF:
	RJMP _0x3
; 0000 009F }
_0xDA:
	RJMP _0xDA
; .FEND

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x0:
	SBI  0x18,4
	CBI  0x18,5
	CBI  0x18,6
	CBI  0x18,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	CBI  0x18,4
	CBI  0x18,5
	SBI  0x18,6
	CBI  0x18,7
	RET


	.CSEG
;END OF CODE MARKER
__END_OF_CODE:
