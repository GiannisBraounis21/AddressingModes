TITLE Addressing Mode Problems
INCLUDE Irvine32.inc

.data
	array DWORD 10,20,30,40,50,60,70,80,90,100
	arraysize = ($ - array)/4

.code
main PROC
	COMMENT !
		We are using indirect addressing with 1 or 2 registers and optionally:
		Constant offset
		Scale Factor
	
	MOV ESI,OFFSET array ;ESI register points to the first object of the array
	MOV EAX,[ESI] ;EAX points where ESI points too
	ADD ESI,8 ;ESI now points in the 3rd element of the array
	MOV EAX,[ESI] ;EAX points where ESI points too

	MOV ESI,0 ;ESI points now in the first element of the array
	MOV EAX,[array+ESI] ;<-Is calculated by address generator unit,more efficient because the CPU is not involved
	ADD ESI,4
	MOV EAX,[array+ESI]
	
	;Using Scale Factor
	sf=4
	MOV ESI,0
	MOV EAX,[array+ESI*4]
	INC ESI
	MOV EAX,[array+ESI*4]
	!
	COMMENT !
		Find the sum of array elements
		What do we need?
		1) A loop							(LOOP)
		2) A loop counter					(ECX)
		3) An array index					(ESI)
		4) An accumulator to hold the sum	(EAX)
	
	;Everytime when loop runs it checks if ecx is 0
	;If 0 then loop ends otherwise it jumps to the ticket L1 and the code runs again
	MOV ECX,arraysize ;ECX is used for the loop and decreases every loop
	MOV ESI,0 ;ESI holds the index of the first array element
	MOV EAX,0
	L1:

		ADD EAX,[array +ESI*4]
		INC ESI

	LOOP L1
	!
	;L1 label cannot be used again
	MOV ECX,arraysize ;ECX is used for the loop and decreases every loop
	MOV ESI,OFFSET array ;ESI holds the address of the first array element
	MOV EAX,0
	L2:

		ADD EAX,[ESI]
		ADD ESI,4

	LOOP L2
	exit
main ENDP
END main