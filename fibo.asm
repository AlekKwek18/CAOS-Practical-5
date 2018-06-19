%include "io.inc"
;SINGAPORE POLYTECHNIC DIMT DISM
;CA 1 QUESTION ONE
;NAME: Alek Kwek
;ADMIN NUMBER:1804247
;Practical 05 CA1
;Fibonacci Sequence
;Date written: 13 May 2018
section .data
string_error: dd "You have enter a value that is not within the range of between 3 and 25(inclusive) or you have entered a negative value! The value you have entered is ", 0xD,0x0;disply error message 
string_output: dd "Fibonacci sequence for " , 0xD,0xA ;Output message
string_output_part2: dd " values is:" ,0xD,0xA;Output_message_part_2
string_message: dd"Please enter a value between 3 and 25(inclusive)", 0xD,0x0 ;prompt the user to enter a value between 3 and 25
section .bss
fibo: resd 26;declare array with dword size of 26
a: resd 4;initialize  a 
b: resd 4;initialize  b
c: resd 4;initialize  c
section .text
global CMAIN
CMAIN:
    mov ebp,esp ;for correct debugging   
    xor eax,eax ;set eax to 0
    xor esi,esi ;set esi to 0   
;setup fibo(0)=a
;fibo(1)=b
;push a to fibo(0) and b to fibo(1)
Setup:    
    mov dword[a],0; let a be 0
    mov dword[b],1; let b be 1
    mov esi, dword[a];store a into esi
    mov dword[fibo],esi;store contents of esi into fibo(0)
    inc eax;increment eax by 1 to point to fibo(1)
    mov esi, dword[b];store b into esi
    mov dword[fibo + eax*2],esi;store contents of esi into fibo(1)
;c=a+b
User_input:    
    PRINT_STRING string_message ;Ask user to input a number between 3 to 25 (inclusive)
    NEWLINE; Creating NEWLINE
    GET_DEC 4,ebx;store input values into ebx
    cmp ebx,0;check whether the user has input any number
    je Error_End;jump to the End instruction if there is no input 
    cmp ebx,0;check whether input is negative
    jl Error_End; if number is negative, terinmate the program  
    cmp ebx,25; check whether number is bigger than 25
    jg Error_End; if number is bigger than 25, terinmate the program
    cmp ebx,3; check whether the input is less than 3
    jl Error_End;terinmate the program if its less than 3
Addition:       
    inc eax; Increment to change to the enxt pointer
    mov esi,[a];move a into eax
    add esi,[b];a + b
    mov [c],esi;c = a + b
    mov esi,[c];store c into esi
    mov dword[fibo + eax*2],esi;move c into fibo(2)    
;a=b and b=c    
Moving_variables:
    mov esi,[b];store b into esi
    mov ecx,[c];store c into ecx
    mov [a],esi;store esi into a: a=b
    mov [b],ecx;store ecx into b: b=c    
Looping:
    cmp eax , ebx;compare whether the pointer is equal to the values inputed 
    je EAX_set_0;Jump to clear eax    
    inc eax; increment eax by 1 to point to fibo()
    mov esi,dword[a];store a into esi
    add esi,dword[b];add a + b
    mov dword[c],esi ;c = a + b
    mov esi,dword[c];move c into esi
    mov dword[fibo + eax*2],esi;move esi into fibo()      
    mov esi,dword[b];store b into esi
    mov ecx,dword[c];store c into ecx
    mov dword[a],esi;store esi into a: a=b
    mov dword[b],ecx;store ecx into b: b=c 
    jmp Looping ;jump to Looping to repeat 
EAX_set_0:
    xor eax,eax ;to set eax to 0 to clear out 
    PRINT_STRING string_output; Outputs a message
    PRINT_UDEC 4,ebx; Prints the integer
    PRINT_STRING string_output_part2;Prints message
    NEWLINE;Prints Newline
    jmp Output ;proceed to jump to Print instruction    
Output:  
    mov esi, dword[fibo + eax*2];mov the value of fibo() into esi
    PRINT_UDEC 2,esi;print the contents of esi
    NEWLINE ;Prints Newline
    inc eax ;increment eax to point to the next location in fibo()
    cmp eax,ebx; compare the values of eax and the user input value of ebx
    je End;jump if equal
    jmp Output;Repeat if its not equal
End:    
    xor eax, eax;set eax to zero
    ret; terinmate the program
Error_End:
    xor eax,eax;set eax to zero
    PRINT_STRING string_error;Prints message
    PRINT_DEC 4,ebx;Prints the wrong input
    ret    