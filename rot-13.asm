;SINGAPORE POLYTECHNIC DMIT
;ROT-13
;Name:ALEK KWEK
;Number:1804247
;Assignment Number:Practical-5 CA 1
;Date written: 21 May 2018
%include "io.inc"
section .data
AskForInput: db "Please enter your sentance!(Max 64 Characters)" , 0xd,0x0 ;Prompt user to input a sentance 
String_in: times 65 db 0h ; max = 64 char, last ch=null
section .bss
ROT: equ 13; Let ROT = 13
Captial: equ 65; Let Captial = 65
Small: equ 97; Let Small = 97 
Divide: equ 26; Let Divide = 26
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax; set eax to 0
    xor edi, edi; set edi to 0
    xor edx, edx; set edx to 0
Input:
    PRINT_STRING AskForInput; ask user for input
    NEWLINE ;Creates a newline
;The check molube checks for the Ascii inputs and jump to their own instruction
;Anything larger than 96 but smaller than 122 is a small letter
;Anything larger than 65 but smaller than 91 is a captial letter
;Any other value aside from the ranges of values stated eailer will not be modified     
Check:
    GET_CHAR [String_in+edi]; Store user input into String_in where it will be in a form of ASCII 
    mov al , byte[String_in+edi];Store content of String_in into al
    cmp ax,96; ax > 96?
    jg Small_Letters; Jump to small letters rotation
    cmp ax,64; ax > 64?
    jg Captial_Letters; Jump to Capital letters rotation
    cmp ax,91; ax < 91?
    jl Captial_Letters; Jump to Capital letters rotation
;Substitution method for capital letters
;First capital letter Ascii code is subtracted by 65 to start from 0 instead of 65 onwards
;Using the formlua e(x) = (x+k)(mod 26) where x is the code of the letter and
;K is 13 as it is rotated by 13 and divisor is 26 as it has 26 letters in the alphabet 
;The remainder is then obtained and is translated back into letter by adding 65   
Captial_Letters:
    cmp ax,0; ax == 0?
    je End; Goto terinmate the program if there is no characters left
    cmp ax,32; ax == 32?
    je Other_charcters; Goto print other characters that is not a captial letter or small letter like * and !
    cmp ax,65; ax < 65?
    jl Other_charcters; Goto print other characters that is not a captial letter or small letter like * and !
    cmp ax,90; ax > 90
    jg Other_charcters; Goto print other characters that is not a captial letter or small letter like * and !
    mov edx,0 ; clear dividend, high
    sub ax , Captial; subtract 65 from ax
    add ax , ROT; add 13 to ax
    mov cx , Divide ; divisor = 26
    div cx ;Division of ax gives the remainder that is stored in dx
    add dx , Captial; add 65 to dx
    jmp Next_Character; repeat the process for the next character in the array
;Substitution method for small letters
;First capital letter Ascii code is subtracted by 97 to start from 0 instead of 97 onwards
;Using the formlua e(x) = (x+k)(mod 26) where x is the code of the letter and
;K is 13 as it is rotated by 13 and divisor is 26 as it has 26 letters in the alphabet 
;The remainder is then obtained and is translated back into letter by adding 97  
Small_Letters: 
    cmp eax,122; eax > 122
    jg Other_charcters; Goto print other characters that is not a captial letter or small letter like * and !
     mov edx,0 ; clear dividend, high
    sub ax , Small; subtract 97 from ax
    add ax , ROT; add 13 to ax
    mov cx , Divide  ; divisor = 26
    div cx ;Division of ax gives the remainder that is stored in dx
    add dx , Small; add 97 to dx
    jmp Next_Character; repeat the process for the next character in the array
;Other charcter that are not within the Ascii values of small or captial letters will be printed as nomral     
Other_charcters:
    PRINT_CHAR [String_in+edi]; Print the characters
    inc edi; increment index pointer by 1
    jmp Check; Repeat the process        
Next_Character:
    PRINT_CHAR dl; Prints one charcter at a time
    mov byte[String_in+edi], dl;store the content of dl into array String_in
    inc edi; increment index pointer by 1
    jmp Check; Repeat the process
;End the program after there is a null character
End:      
    xor eax, eax; set eax to 0
    ret; terinmate the program