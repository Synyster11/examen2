#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    INICIO                   ; go to beginning of program

MAIN_PROG CODE 

numTecla equ h'30' ;Guarda el numero de tecla pulsada 
carac1 equ 0x33
carac2 equ 0x40
carac3 equ 0x41
carac4 equ 0x43
carac5 equ 0x51
carac6 equ 0x52
carac7 equ 0x53
carac8 equ 0x54
tecla equ 0x37
correcto equ 0x38 
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33

  
 
 
caracter equ h'33' ;Contador de caracteres
     
;------------------------INICIO-------------------- 
INICIO:
   
     clrf PORTB            
     clrf PORTC           
     clrf PORTD            
     bsf STATUS,RP0        
     movlw 0xF0  
     movlw b'11110000' 			
     movwf TRISB ;teclado 
     movlw 0x00					
     movwf TRISC
     clrf TRISC            
     clrf TRISD          
     bcf STATUS,RP0        
     
     ;------------------------CONTRASEÃA GUARDADA 12345678--------------------
     movlw '1'		   
     movwf carac1
     movlw '2'		
     movwf carac2
     movlw '3'		 
     movwf carac3
     movlw '4'		   
     movwf carac4
     movlw '5'		   
     movwf carac5
     movlw '6'		   
     movwf carac6
     movlw '7'		   
     movwf carac7
     movlw '8'		   
     movwf carac8
  
;------------------------INICIO DEL PROGRAMA--------------------			   
START: 
     clrf caracter
     call INICIA_LCD       
     goto BIENVENIDO
     call Mensaje1	  
     goto NEW_SCAN       

;------------------------INICIALIZA EL LCD-------------------- 
INICIA_LCD:
     bcf PORTD,0           
     movlw 0x01            
     movwf PORTC
     call COMANDO ; Se da de alta el comando
     movlw 0X38 ; Selecciona la primera linea
     movwf PORTC
     call COMANDO        
     movlw 0x0E ; Se configura el cursor
     movwf PORTC
     call COMANDO        
     BSF PORTD,0; 
     BCF PORTD,1; 
     BSF PORTD,2; 
     return

;------------------------RUTINA PARA ENVIAR UN DATO--------------------
ENVIA:
     MOVWF PORTC
     BCF PORTD,2
     call COMANDO
     BSF PORTD,2
     call COMANDO
     bsf PORTD,0          
     call COMANDO        
     return

;------------------------SUBRUTINA PARAR UN DATO--------------------
COMANDO:
     bsf PORTD, 1         
     call DELAY           
     call DELAY        
     bcf PORTD, 1        
     call DELAY           
     return
	     
;------------------------CONFIGURACION DE LA SEGUNDA LINEA LCD--------------------
LINEA2:
     bcf PORTD,0          
     movlw 0x30 ; Selecciona linea 2 pantalla en el LCD
     movwf PORTC
     call COMANDO          
     goto NEW_SCAN

;------------------------TIEMPO DE RETARDO--------------------	
DELAY:        	
     MOVLW D'13'	 
     MOVWF 0X38
     MOVLW D'251'
     MOVWF 0X39
loop1:
     DECFSZ 0X39
     GOTO loop1
     DECFSZ 0X38
     GOTO loop1
   return
;------------------------MENSAJE PASSWORD:--------------------
Mensaje1:
     bcf     PORTD,0
     movlw   b'00000001'
     movwf   PORTC
     bsf     PORTD,1
     NOP
     bcf     PORTD,1
     call     DELAY
     
     movlw 'I'
     movwf PORTC
     call ENVIA
     movlw 'N'
     movwf PORTC
     call ENVIA
     movlw 'G'
     movwf PORTC
     call ENVIA
     movlw 'R'
     movwf PORTC
     call ENVIA
     movlw 'E'
     movwf PORTC
     call ENVIA
     movlw 'S'
     movwf PORTC
     call ENVIA
     movlw 'E'
     movwf PORTC
     call ENVIA
     movlw ':'
     movwf PORTC
     call ENVIA
     movlw 'P'
     movwf PORTC
     call ENVIA
     movlw 'I'
     movwf PORTC
     call ENVIA
     movlw 'N'
     movwf PORTC
     call ENVIA
     movlw ':'
     movwf PORTC
     call ENVIA
     goto NEW_SCAN
     
;------------------------MENSAJE SI LA CONTRASELA ES CORRECTA--------------------
Mensaje2:
     call RESETLCD  
     call RESETLCD 
     call RESETLCD  
     movlw 'C'
     movwf PORTC
     call ENVIA
     movlw 'O'
     movwf PORTC
     call ENVIA
     movlw 'R'
     movwf PORTC
     call ENVIA
     movlw 'R'
     movwf PORTC
     call ENVIA
     movlw 'E'
     movwf PORTC
     call ENVIA
     movlw 'C'
     movwf PORTC
     call ENVIA
     movlw 'T'
     movwf PORTC
     call ENVIA
     movlw 'O'
     movwf PORTC
     call ENVIA
     return   
     
;------------------------MENSAJE SI LA CONTRASELA ES INCORRECTA--------------------
Mensaje3:
     call RESETLCD  
     call RESETLCD 
     call RESETLCD 
     movlw 'I'
     movwf PORTC
     call ENVIA
     movlw 'N'
     movwf PORTC
     call ENVIA
     movlw 'C'
     movwf PORTC
     call ENVIA
     movlw 'O'
     movwf PORTD
     call ENVIA
     movlw 'R'
     movwf PORTD
     call ENVIA
     movlw 'R'
     movwf PORTC
     call ENVIA
     movlw 'E'
     movwf PORTC
     call ENVIA
     movlw 'C'
     movwf PORTC
     call ENVIA
     movlw 'T'
     movwf PORTC
     call ENVIA
     movlw 'O'
     movwf PORTC
     call ENVIA
     return 
     
;------------------------MENSAJE DE BIENVENIDA--------------------
BIENVENIDO:
     movlw 'B'
     movwf PORTC
     call ENVIA
     movlw 'I'
     movwf PORTC
     call ENVIA
     movlw 'E'
     movwf PORTC
     call ENVIA
     movlw 'N'
     movwf PORTC
     call ENVIA
     movlw 'V'
     movwf PORTC
     call ENVIA
     movlw 'E'
     movwf PORTC
     call ENVIA
     movlw 'N'
     movwf PORTC
     call ENVIA
     movlw 'I'
     movwf PORTC
     call ENVIA
     movlw 'D'
     movwf PORTC
     call ENVIA
     movlw 'O'
     movwf PORTC
     call ENVIA
     
     
     bsf    PORTD,2
     call   DELAY
     call   DELAY
     call   DELAY
     call   DELAY
     call   DELAY
     call   DELAY
     bcf    PORTD,2
     goto Mensaje1
    
;------------------------ESCANEO DEL TECLADO--------------------
NEW_SCAN:
     clrf numTecla         ; Borra numTecla
     incf numTecla,1       ; Inicializa numTecla
     movlw b'11110000'     ; Pone a 0 la primera Fila
     movwf PORTB
     movwf PORTA
     Nop          
     call COMPARA
     
;------------------------VERIFICA ESTADO DE LAS COLUMNAS--------------------
CHK_COL:
     btfss PORTB,4 ; Columna 1=0?
     goto TECLA_ON ; Sale si se ha pulsado una tecla
     btfsc PORTA, 6	
     incf numTecla,1 ; Incrementa numero de tecla
    
     btfss PORTB,5 ; Columna 2=0?
     goto TECLA_ON  
     btfsc PORTA, 6
     incf numTecla,1       
    
     btfss PORTB,6 ; Columna 3=0?
     goto TECLA_ON   
     btfsc PORTA, 6
     incf numTecla,1        
     
     ;------------------------CHECA SI TERMINO RECORRIDO TECLADO--------------------
     movlw d'13' ;total de teclas + 1
     xorwf numTecla,w ;xor
     btfsc STATUS,Z        
     goto NEW_SCAN ;compara si el valor de z es diferente o no
                       
			   
;------------------------RECORRIDO A LA IZQUIERDA--------------------
NEXT_COL:
     bsf STATUS,C ;poner un 1 la fila                
     rlf PORTB,1    
     goto CHK_COL ; Escanea la siguente columna
     
;------------------------RESETEA LA PANTALLA--------------------
RESETLCD:
    movlw 0x01
    call COMANDO
    clrf 0x35
    clrf 0x36
    clrf 0x37
  return

;------------------------RESETEA LA PANTALLA--------------------
  
;------------------------TECLA CAPTURADA--------------------    
TECLA_ON:
    ;------------------------ESPERA AL PRESIONAR UNA TECLA--------------------
    call RESETLCD
    call RESETLCD  
    call RESETLCD  
Espera1   
     btfss   PORTB,4   
     goto    Espera1      
Espera2   
     btfss   PORTB,5      
     goto    Espera2      
Espera3   
     btfss   PORTB,6    
     goto    Espera3      
Espera4   
     btfss   PORTB,7      
     goto    Espera4      
Espera5   
     btfss   PORTB,7      
     goto    Espera5 
Espera6   
     btfss   PORTB,7      
     goto    Espera6 
Espera7   
     btfss   PORTB,7      
     goto    Espera7 
Espera8   
     btfss   PORTB,7      
     goto    Espera8 
     
     ;------------------------ESPERA AL PRESIONAR UNA TECLA--------------------   

unsegundo:
    ;bcf PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 0

	nop;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +1
	nop
	nop
	nop
	nop
	nop 

    call uno ;llamar a la rutina de tiempo
    ;  nop ;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +1

     ;bsf PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 1
    ;nop ;NOPs de relleno (ajuste de tiempo)

    uno:
    movlw d'19' ;establecer valor de la variable k 
	; +1 = 6
    movwf m
    mloop:
    decfsz m,f
    goto mloop

     movlw d'108' ;establecer valor de la variable i
    movwf i
    iloop:
    nop ;NOPs de relleno (ajuste de tiempo)
    nop
    nop
    nop
    nop ;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +216
    movlw d'60' ;establecer valor de la variable j ;60
    movwf j
    jloop:
    nop ;NOPs de relleno (ajuste de tiempo)  ;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +12960

    movlw d'24' ;establecer valor de la variable k 
    movwf k
    kloop:
    decfsz k,f
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop





;------------------------TECLA CAPTURADA--------------------      
     
     ;------------------------VERIFICA LA LINEA 1 COMPLETA--------------------
     movlw d'12'          
     xorwf caracter,w ;xor
     btfsc STATUS,Z        
     goto LINEA2 ;si la linea esta llena
     
     ;------------------------VERIFICA LA LINEA 1 COMPLETA--------------------
     
     ;------------------------VERIFICA LA LINEA 2 COMPLETA--------------------
  
     xorwf caracter,w ;xor
     btfsc STATUS,Z        
     movlw d'24'           
     goto START        
     goto NEW_SCAN    
     
     ;------------------------VERIFICA LA LINEA 2 COMPLETA--------------------
    COMPARA:
    bcf STATUS,Z
    subwf 0X32,W
    btfss STATUS,Z
    goto $+2
    call Mensaje3
   
    bcf STATUS,Z
    subwf 0X44,W
    btfss STATUS,Z
    goto $+2
    call Mensaje3

    bcf STATUS,Z
    subwf 0X45,W
    btfss STATUS,Z
    goto $+2
    call Mensaje3

     bcf STATUS,Z
    subwf 0X46,W
    btfss STATUS,Z
    goto $+2
    call Mensaje3

     bcf STATUS,Z
    subwf 0X47,W
    btfss STATUS,Z
    goto $+2
    call Mensaje3

     bcf STATUS,Z
    subwf 0X48,W
    btfss STATUS,Z
    goto $+2
    call Mensaje3

     bcf STATUS,Z
    subwf 0X49,W
    btfss STATUS,Z
    goto $+2
    call Mensaje3

    bcf STATUS,Z
    subwf 0X50,W
    btfss STATUS,Z
    call Mensaje2
    call Mensaje3
          
 end
