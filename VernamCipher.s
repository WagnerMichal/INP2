; Autor reseni: Michal Wagner xwagne12

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; DATA SEGMENT
                .data
login:          .asciiz "xwagne12"  ; sem doplnte vas login
cipher:         .space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize "funkce" print_string)

; CODE SEGMENT
                .text
                ;xwagne12-r13-r12-r22-r18-r0-r4
                ; ZDE NAHRADTE KOD VASIM RESENIM
main:
                daddi   r12, r0, 0   ; vozrovy vypis: adresa login: do r4
                
                ;w - -3
                ;a - -1    
loop:
    lb   r13, login(r12)
    slti r22, r13, 97 ;r22 = login[r13] < 97
    bnez r22, end
    

    daddi r13, r13, -3 
    ;DADDI r4, r0, 123 ; 122 < r13
    slti r22, r13, 97 ;r22 = 122 < login[r13]
    bnez r22, overflow2
    overflow_end2:

    sb r13, cipher(r12) ; cipher[r12] = r13
    DADDI r12, r12, 1

    lb   r13, login(r12)
    slti r22, r13, 97 ;r22 = login[r13] < 97
    bnez r22, end

    daddi r13, r13, -1
    ;DADDI r4, r0, 123 ; 122 < r13
    slti r22, r13, 97 ;r22 = 122 < login[r13]
    bnez r22, overflow
    overflow_end:

    sb r13, cipher(r12) ; cipher[r12] = r13
    DADDI r12, r12, 1
    b loop

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address

overflow:
    daddi r13, r13, 26
    b overflow_end

overflow2:
    daddi r13, r13, 26
    b overflow_end2
end:
    ;sb r13, cipher(r12)
    daddi   r4, r0, cipher 
    jal     print_string    ; vypis pomoci print_string - viz nize
    syscall 0   ; halt