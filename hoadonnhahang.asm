.MODEL SMALL
.STACK 100H
.DATA 
sao1 db 10,13,    '***************************$'
sao2 db 10,13,    '**                       **$'

M1 db       10,13,'***    P.RESTAURANT     ***$' 
M2 db       10,13,'Nhap vao lua chon cua ban: $'

M3 db       10,13,'**   1.MON CHINH         **$' 
M4 db       10,13,'**   2.MON TRANG MIENG   **$'
M5 db       10,13,'**   3.DO UONG           **$'
                
  
;Mon chinh
sao5 db     10,13,'**********************************$' 
sao3 db     10,13,'*                                *$'
M8  db      10,13,'**********   MON CHINH   *********$'  
M9  db      10,13,'*    1.Com rang      60.000vnd   *$' 
M10 db      10,13,'     2.Pho           60.000vnd    $'
M11 db      10,13,'     3.Bit tet       60.000vnd    $'
M12 db      10,13,'     4.Tom hum       90.000vnd    $'
M13 db      10,13,'*    5.Banh mi       90.000vnd   *$' 
sao4 db     10,13,'***                            ***$'
a9  db      10,13,'|Com rang   60.000 $'
a10 db      10,13,'|Pho        60.000 $'
a11 db      10,13,'|Bit tet    60.000 $'
a12 db      10,13,'|Tom hum    90.000 $'
a13 db      10,13,'|Banh mi    90.000 $'   

;Mon trang mieng 
M24 db      10,13,'*******   MON TRANG MIENG   ******$'
M25 db      10,13,'*    1.Thach         10.000vnd   *$' 
M26 db      10,13,'     2.Che           10.000vnd    $' 
M27 db      10,13,'     3.Sua chua      20.000vnd$' 
M28 db      10,13,'     4.Dua hau       20.000vnd$'
M29 db      10,13,'*    5.Chuoi         30.000vnd   *$' 
a25 db      10,13,'|Thach      10.000 $'
a26 db      10,13,'|Che        10.000 $'
a27 db      10,13,'|Sua chua   20.000 $'
a28 db      10,13,'|Dua hau    20.000 $'
a29 db      10,13,'|Chuoi      30.000 $' 

;Do uong
m48 db      10,13,'***********   DO UONG   **********$'  
M49 db      10,13,'*    1.Softdrink      6.000vnd   *$'
M50 db      10,13,'     2.Laschi         7.000vnd    $'
M51 db      10,13,'     3.Borhani        8.000vnd    $'
M52 db      10,13,'     4.Labang         9.000vnd    $'
M53 db      10,13,'*    5.Coffee         9.000vnd   *$'
a49 db      10,13,'|Softdrink   6.000 $'
a50 db      10,13,'|Laschi      7.000 $'
a51 db      10,13,'|Borhani     8.000 $'
a52 db      10,13,'|Labang      9.000 $'
a53 db      10,13,'|Coffee      9.000 $' 
 

M55 db 10,13,10,13,'KHONG HOP LE! HAY THU LAI.$'


M57 db 10,13,'Chon mon: $'
M58 db 10,13,'Soluong: $'
M59 db 10,13,'Tong tien: $'

M61 db      10,13,' ([0] - xem truoc hoa don)$'

doc3 db '|$' 
doc2 db     10,13,'|                                |$'
doc1 db     10,13,'|--------------------------------|$'
nameres db  10,13,'|-----     P.RESTAURANT     -----|$'
diachi db   10,13,'| Km10, Nguyen Trai, Ha Dong, HN |$'
sdt db      10,13,'|        SDT: 0326 xxxxxx        |$'
hoadon db   10,13,'|       HOA DON THANH TOAN       |$'
ban db      10,13,'|Ban so xx       Ngay: 10/05/2023|$'
thungan db  10,13,'|Thu ngan: Admin                 |$'
daumuc db   10,13,'|Mon an       Gia    SL    T Tien|$'        
                                                     
hoadon1 dw 10 dup(0)    ;luu so luong moi mon trong menu mon chinh
hoadon2 dw 10 dup(0)    ;
hoadon3 dw 10 dup(0)
                    
gia1 dw 10 dup(0)
gia2 dw 10 dup(0)
gia3 dw 10 dup(0)                    


sej db 10,13,'$'
space db ' $'
space2 db '  $'
space3 db '   $'
cnt db ?
donvi db '.000$' 
donvitien db 10,13,'|                             VND|$'

thanhtoan db 10,13,'|Tong tien:              $' 
sum dw 0
camon db     10,13,' Cam on quy khach va hen gap lai! $'  

pickxoamon db 10,13,' ([z]-Xoa mon; [b]-Quay lai menu) $'
xoa db       10,13,' Ban muon xoa mon thu may: $'

inhoadon dw 10 dup(0)

.CODE
MAIN PROC 
    mov AX, @data
    mov DS, AX
    
    ;xoa man hinh
    clr macro 
        mov AH, 06h
        mov AL, 00h
        mov BH, 07h
        mov CH, 00h
        mov CL, 00h
        mov DX, 184fh
        int 10h

        mov AH, 02h
        mov BH, 00h
        mov DX, 0000h
        int 10h 
     endm
     
    ;dinh nghia print de in ra mot xau                                                                                                        
    print macro str   
        lea DX, str
        mov AH, 9
        int 21h
    endm   
    
   ;dinh nghia phep nhan  
    nhan macro x            
        mov CH, 0     
        add SI, CX    
        add SI, CX    
        add DI, CX   
        add DI, CX    
        
        ;yeu cau nhap vao so luong
        print sej
        print M58        
        mov AH,1
        int 21h      
        sub AL,48    
        
        ;luu so luong vao mang inhoadon
        mov AH, 0
        add [SI], AX
        sub SI, CX   
        sub SI, CX
     
        ;thuc hien phep nhan
        mov BX, x    
        mul BX       
        
        ;luu gia tien vao mang gia  
        add [DI], AX 
        sub DI, CX
        sub DI, CX 
 
        jmp TOP 
    endm   
       
    TOP:
    clr 
    print sao1
    print M1
    print sao1
    print sao2
    print M3
    print sao2  
    print M4 
    print sao2
    print M5
    print sao2
    print sao1
    print sao1
    print M61
    print sej
    pickmon:
    print M2
         
    mov AH,1
    int 21H
    mov BH,AL
    sub BH,48
    
    cmp bh, 0
    je exit
    
    cmp BH, 1
    je Monchinh
    
    cmp BH,2
    je Montrangmieng   
     
    CMP BH,3
    JE Douong 
    
    print M55
    jmp pickmon
    
          
    Monchinh: 
    lea SI, hoadon1 
    lea DI, gia1
    
    print sej
    print M8
    print sao3
    print M9
    print sao3
    print M10
    print sej
    print M11
    print sej
    print M12
    print sao3 
    print M13
    print sao3
    print sao5
    print sej
    pickmonchinh:
    print M57
 
    
    mov AH,1
    int 21H
    mov CL,AL
    sub CL,48 
    
    cmp CL,1   
    je SIXTY
    
    cmp CL,2
    je SIXTY
    
    cmp CL,3
    je SIXTY 
    
    cmp CL,4
    je NINETY
    
    cmp CL,5
    je NINETY
    
    print M55
    jmp pickmonchinh  
    
    SIXTY: 
    nhan 60
       
    NINETY:
    nhan 90
         
    Montrangmieng: 
    lea SI, hoadon2 
    lea DI, gia2
    
    print sej
    print M24
    print sao3
    print M25 
    print sao3
    print M26
    print sej
    print M27
    print sej
    print M28
    print sao3
    print M29
    print sao3
    print sao5
    print sej
    pickmontrangmieng:
    print M57
    
    mov AH,1
    int 21H
    mov CL,AL
    sub CL,48 
    
    cmp CL,1
    je TEN
    
    cmp CL,2
    je TEN
    
    cmp CL,3
    je TWENTY  
    
    cmp CL,4
    je TWENTY
    
    cmp CL,5
    je THIRTY
    
    print M55
    jmp pickmontrangmieng  
        
    TEN: 
    nhan 10 
          
    TWENTY:
    nhan 20 
          
    THIRTY:
    nhan 30 
    
    Douong: 
    lea SI, hoadon3 
    lea DI, gia3
    
    print sej 
    print M48 
    print sao3
    print M49
    print sao3
    print M50
    print sej
    print M51
    print sej
    print M52
    print sao3
    print M53
    print sao3
    print sao5
    print sej
    pickdouong:
    print M57      
    
    mov AH,1
    int 21H
    mov CL,AL
    sub CL,48 
    
    cmp CL,1
    je SOFTDRINK
    
    cmp CL,2
    je LASCHI
    
    cmp CL,3
    je BORHANI
    
    cmp CL,4
    je LABANG
    
    cmp CL,5
    je COFFEE 
       
    print M55
    jmp pickdouong
    
    SOFTDRINK:
    nhan 6
    
    LASCHI:
    nhan 7
   
    
    BORHANI:
    nhan 8
    
    LABANG:
    nhan 9
        
    COFFEE:
    nhan 9
    

    EXIT:
    clr
    mov sum, 0 
    print doc1
    print nameres
    print diachi
    print sdt
    print doc2
    print hoadon
    print doc2
    print ban
    print thungan
    print doc2
    print daumuc
    print doc1
                  
    lea SI, hoadon1
    lea DI, gia1
    mov cnt, 0
    LAP1: 
    cmp [SI], 0
    je tt   
    cmp cnt, 0
    je tt
    cmp cnt, 1
    je item1
    cmp cnt, 2
    je item2
    cmp cnt, 3
    je item3
    cmp cnt, 4
    je item4
    cmp cnt, 5
    je item5 
    
    item1:
    print a9   
    jmp ctn
    item2: 
    print a10 
    jmp ctn
    item3:
    print a11
    jmp ctn
    item4:
    print a12
    jmp ctn
    item5: 
    print a13
    jmp ctn
     
    ctn:     
    mov AX, [SI]  
    call inso 
    print space
    print space
    
    mov AX, [DI] 
    add sum, AX
    call inso 
    print donvi
    print doc3 
    print doc1
     
    tt:
    add SI, 2
    add DI, 2
    inc cnt
    cmp cnt, 10         
    jl LAP1
         
    lea SI, hoadon2
    lea DI, gia2
    mov cnt, 0
    LAP2: 
    cmp [SI], 0
    je tt2
    cmp cnt, 0
    je tt2
    cmp cnt, 1
    je item12
    cmp cnt, 2
    je item22
    cmp cnt, 3
    je item32
    cmp cnt, 4
    je item42
    cmp cnt, 5
    je item52 
    
    item12:
    print a25 
    jmp ctn2
    item22:
    print a26
    jmp ctn2
    item32:
    print a27
    jmp ctn2
    item42:
    print a28
    jmp ctn2
    item52:
    print a29
    jmp ctn2
    
    ctn2:     
    mov AX, [SI]
    call inso
    print space
    print space
    
    mov AX, [DI] 
    add sum, AX
    call inso
    print donvi
    print doc3
    print doc1  
     
    tt2:
    add SI, 2
    add DI, 2
    inc cnt
    cmp cnt, 10         
    jl lap2 
    
    lea SI, hoadon3
    lea DI, gia3
    MOV cnt, 0
    LAP3: 
    cmp [SI], 0
    je tt3
    cmp cnt, 0
    je tt3
    cmp cnt, 1
    je item13
    cmp cnt, 2
    je item23
    cmp cnt, 3
    je item33
    cmp cnt, 4
    je item43
    cmp cnt, 5
    je item53 
    
    item13:
    print a49 
    jmp ctn3
    item23:
    print a50
    jmp ctn3
    item33:
    print a51
    jmp ctn3
    item43:
    print a52
    jmp ctn3
    item53:
    print a53
    jmp ctn3
     
    ctn3:     
    mov AX, [SI]
    call inso 
      
    print space 
    print space
     
    mov AX, [DI] 
    add sum, AX
    call inso             
    print donvi
    print doc3
    print doc1  
    
    tt3:
    add SI, 2
    add DI, 2
    inc cnt
    cmp cnt, 10         
    jl lap3
     
    print thanhtoan
    mov AX, sum
    call inso
    print donvi
    print doc3 
    print donvitien 
    print doc1
    print sej
    print camon
    
    print sej
    print pickxoamon
    mov AH,1
    int 21h 
    cmp AL, 'b' 
    je TOP
    cmp AL, 'z'
    jne ketthuc 
    call duyet ;ham duyet de dua dia chi cua nhung mon an da chon vao mang
    call xoamon
    jmp EXIT
    
    ketthuc: 
    mov AH, 4ch
    int 21h
    
main endp


inso proc 
    mov CX, 0
    mov BX, 10
    st: 
    mov DX, 0
    div BX
    push DX 
    inc CX  
    cmp AX, 0
    jne st 
    
    cmp CX, 3
    je thut1
    cmp CX, 2
    je thut2
    cmp CX, 1
    je thut3
    
    jmp inra 
    thut1:                      
    print space                 
    jmp inra                   
    thut2:
    print space2 
    jmp inra
    thut3:
    print space3
    jmp inra 
    
    
    inra:      
    mov AH, 2         
    in1:
    pop DX
    or DL, 30h
    int 21h
    loop in1 
    ret
inso endp    

duyet proc    
    lea DI, inhoadon   ;inhoadon luu cac mon duoc goi
    lea SI, hoadon1 
    mov CX, 10
    duyet1:
    call luu
    add SI, 2
    loop duyet1
    
    lea SI, hoadon2 
    mov CX, 10
    duyet2:
    call luu
    add SI, 2
    loop duyet2
    
    lea SI, hoadon3 
    mov CX, 10
    duyet3:
    call luu
    add SI, 2
    loop duyet3
    
    ret
duyet endp

luu proc   
    cmp [SI], 0
    je boqua 
    add DI, 2 
    mov [DI], SI 
    
    boqua:
    ret
luu endp   

    
xoamon proc
    print sej
    print xoa
    mov AH, 1
    int 21h
    
    sub AL, 30h
    add AL, AL 
    mov AH, 0
    lea SI, inhoadon  
    add SI, AX
    mov DI, [SI]
    mov [DI], 0
     
    ret
xoamon endp 
    
        

END 