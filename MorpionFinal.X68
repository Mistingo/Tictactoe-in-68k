*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG     $1000

FONDSTART: 
    MOVE.L  #$C0DFEF, D1
    JSR     SET_FILL_COLOR 
    MOVE.W  #0, D1 
    MOVE.W  #0, D2 
    JSR     pot_de_peinture 
 
    MOVE.B  #0,D6 
    MOVE.L  #$000000, D1 
    JSR     SET_PEN_COLOR 
    MOVE.B  #3,D1 
    JSR     WIDTH_PEN 
    MOVE.W  #150,D1 
    MOVE.W  #100,D2 
    MOVE.W  #450,D3 
    MOVE.W  #100,D4 
    JSR     DRAW_LINE 
    BRA     BOUCLELIGNE 
 
BOUCLELIGNE:
    ADD.W   #100,D2 
    ADD.W   #100,D4 
    JSR     DRAW_LINE 
    ADD.B   #1, D6 
    CMP     #3, D6 
    BEQ     FINLIGNE 
    BRA     BOUCLELIGNE 
 
FINLIGNE:
    MOVE.B  #0,D6 
    MOVE.W  #150,D1 
    MOVE.W  #100,D2 
    MOVE.W  #150,D3 
    MOVE.W  #400,D4 
    JSR     DRAW_LINE 
    BRA     BOUCLECOLONNE 
 
BOUCLECOLONNE:
    ADD.W   #100, D1
    ADD.W   #100, D3
    JSR     DRAW_LINE
    ADD.B   #1, D6
    CMP.W   #3, D6
    BNE     BOUCLECOLONNE

*-----------------------------------------------------------
 
VERIFTOUR:
	MOVE.L	#TOUR, A0
	CMP.B	#1, (A0)
	BEQ	    TOURJOUEUR1
	JMP	    TOURJOUEUR2


VERIFNUL:
	MOVE.L	#COMPTEURNUL, A0
	CMP.B 	#8, (A0)
	BEQ	    PARTIENUL
	ADD.B   #1, (A0)	
    BRA     VERIFTOUR

*-----------------------------------------------------------

VERIFLIGNE1:
    MOVE.L  #CASE1, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE2, A1
    CMP.B   (A1), D0
    BNE     VERIFLIGNE2
    MOVE.L  #CASE3, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE
VERIFLIGNE2:
    MOVE.L  #CASE4, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE5, A1
    CMP.B   (A1), D0
    BNE     VERIFLIGNE3
    MOVE.L  #CASE6, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE
VERIFLIGNE3:
    MOVE.L  #CASE7, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE8, A1
    CMP.B   (A1), D0
    BNE     VERIFCOLONNE1    
    MOVE.L  #CASE9, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE


VERIFCOLONNE1:
    MOVE.L  #CASE1, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE4, A1
    CMP.B   (A1), D0
    BNE     VERIFCOLONNE2    
    MOVE.L  #CASE7, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE
VERIFCOLONNE2:
    MOVE.L  #CASE2, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE5, A1
    CMP.B   (A1), D0
    BNE     VERIFCOLONNE3    
    MOVE.L  #CASE8, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE
VERIFCOLONNE3:
    MOVE.L  #CASE3, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE6, A1
    CMP.B   (A1), D0
    BNE     VERIFDIAGO1    
    MOVE.L  #CASE9, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE


VERIFDIAGO1:
    MOVE.L  #CASE1, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE5, A1
    CMP.B   (A1), D0
    BNE     VERIFDIAGO2    
    MOVE.L  #CASE9, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE    
VERIFDIAGO2:
    MOVE.L  #CASE3, A0
    MOVE.B  (A0), D0
    MOVE.L  #CASE5, A1
    CMP.B   (A1), D0
    BNE     VERIFNUL    
    MOVE.L  #CASE7, A0
    MOVE.B  (A0), D0
    CMP.B   (A1), D0
    BEQ     VICTOIRE
    BRA     VERIFNUL


VICTOIRE:
	MOVE.L	#TOUR, A0
	CMP.B   #1, (A0)
	BEQ     PARTIE2
	JMP     PARTIE1

*-----------------------------------------------------------

TOURJOUEUR1:
    MOVE.B	#2, (A0)
    JMP     CLICK

    
TOURJOUEUR2:
    MOVE.B	#1, (A0)
    JMP     CLICK

*-----------------------------------------------------------

CLICK:
    MOVE.L  #COL, A0
    MOVE.B  #0, (A0)
    MOVE.L  #LIG, A0
    MOVE.B  #0, (A0)
    CLR.L D1
    JSR GET_MOUSE
    AND.B #1, D0
    BNE DECLICK
    BRA CLICK
 
 
DECLICK:
    CLR.L D1
    JSR GET_MOUSE
    CMP.B #0, D0
    BNE DECLICK
 
 
LIEUCLICK:
    MOVE.W D1, A1
    SWAP D1
    MOVE.W D1, A2

*-----------------------------------------------------------
   
RECHERCHEY:
    CMP.W   #100, A2
    BLT     CLICK
    MOVE.L  #150, A4
    CMP.W   #200, A2
    BLE     LIG200
    MOVE.L  #250, A4
    CMP.W   #300, A2
    BLE     LIG300
    MOVE.L  #350, A4
    CMP.W   #400, A2
    BLE     LIG400
    CMP.W   #400, A2
    BGE     CLICK


RECHERCHEX:
    CMP.W   #150, A1
    BLT     CLICK
    MOVE.L  #200, A3
    CMP.W   #250, A1
    BLE     COL200
    MOVE.L  #300, A3
    CMP.W   #350, A1
    BLE     COL300
    MOVE.L  #400, A3
    CMP.W   #450, A1
    BLE     COL400
    CMP.W   #450, A1
    BGE     CLICK

*-----------------------------------------------------------

LIG200:
    MOVE.L  #LIG, A0    
    ADD.B   #1, (A0)
    BRA     RECHERCHEX
    
LIG300:
    MOVE.L  #LIG, A0    
    ADD.B   #2, (A0)
    BRA     RECHERCHEX

LIG400:
    MOVE.L  #LIG, A0    
    ADD.B   #3, (A0)
    BRA     RECHERCHEX

*-----------------------------------------------------------

COL200:
    MOVE.L  #COL, A0    
    ADD.B   #1, (A0)
    BRA     COORDONNEESX
    
COL300:
    MOVE.L  #COL, A0    
    ADD.B   #2, (A0)
    BRA     COORDONNEESX

COL400:
    MOVE.L  #COL, A0    
    ADD.B   #3, (A0)
    BRA     COORDONNEESX

*-----------------------------------------------------------

COORDONNEESX:
    MOVE.L  #COL, A0
    CMP.B   #1, (A0)
    BEQ     COORDONNEESY1   
    CMP.B   #2, (A0)
    BEQ     COORDONNEESY2  
    CMP.B   #3, (A0)
    BEQ     COORDONNEESY3   


COORDONNEESY1:
    MOVE.L  #LIG, A0
    CMP.B   #1, (A0)
    BEQ     CORDCASE1   
    CMP.B   #2, (A0)
    BEQ     CORDCASE4  
    CMP.B   #3, (A0)
    BEQ     CORDCASE7 

COORDONNEESY2:
    MOVE.L  #LIG, A0
    CMP.B   #1, (A0)
    BEQ     CORDCASE2   
    CMP.B   #2, (A0)
    BEQ     CORDCASE5  
    CMP.B   #3, (A0)
    BEQ     CORDCASE8 

COORDONNEESY3:
    MOVE.L  #LIG, A0
    CMP.B   #1, (A0)
    BEQ     CORDCASE3   
    CMP.B   #2, (A0)
    BEQ     CORDCASE6  
    CMP.B   #3, (A0)
    BEQ     CORDCASE9

*-----------------------------------------------------------

CORDCASE1:
    MOVE.L  #CASE1, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE2:
    MOVE.L  #CASE2, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE3:
    MOVE.L  #CASE3, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE4:
    MOVE.L  #CASE4, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE5:
    MOVE.L  #CASE5, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE6:
    MOVE.L  #CASE6, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE7:
    MOVE.L  #CASE7, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE8:
    MOVE.L  #CASE8, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
CORDCASE9:
    MOVE.L  #CASE9, A1
    MOVE.B  (A1), D0
    MOVE.L  #0, A0
    JMP     VERIFCASE
    
*-----------------------------------------------------------

VERIFCASE:
    ADD.L   #1, A0
    CMP.L   A0, D0
    BNE     VERIFCASE
    SUB.L   #49, A0
    ADD.L   #CASE1, A0
    CMP.B   (A0), D0
    BEQ     PLACESIGNE
    BRA     CLICK 


PLACESIGNE:
    MOVE.L  #TOUR, A0
    CMP.B   #2, (A0)
    BEQ     SIGNEX
    JMP     SIGNEO


SIGNEX:
    MOVE.B  #88, (A1)
    JMP     CROIX 
    

SIGNEO:
    MOVE.B  #79, (A1)
    JMP     ROND

*-----------------------------------------------------------

ROND:
    MOVE.W A3, D1
    SUB.W #25, D1 ;X1 -25
    MOVE.W A4, D2
    SUB.W #25, D2 ;Y1 -25
    MOVE.W A3, D3
    ADD.W #25, D3 ;X2 +25
    MOVE.W A4, D4
    ADD.W #25, D4 ;Y2 +25
    JSR DRAW_ELLIPSE
    BRA VERIFLIGNE1
CROIX:
    MOVE.W A3, D1
    SUB.W #25, D1 ;X1 -25
    MOVE.W A4, D2
    SUB.W #25, D2 ;Y1 -25
    MOVE.W A3, D3
    ADD.W #25, D3 ;X2 +25
    MOVE.W A4, D4
    ADD.W #25, D4 ;Y2 +25
    JSR DRAW_LINE
    MOVE.W A3, D1
    ADD.W #25, D1 ;X1 +25
    MOVE.W A4, D2
    SUB.W #25, D2 ;Y1 -25
    MOVE.W A3, D3
    SUB.W #25, D3 ;X2 -25
    MOVE.W A4, D4
    ADD.W #25, D4 ;Y2 +25
    JSR DRAW_LINE
    BRA VERIFLIGNE1

*-----------------------------------------------------------

REMISE0:
    MOVE.B  #12, D1
    JSR     AFFCAR
    MOVE.L  #CASEREMISE, A2
    ADD.B   #1, (A2)
    MOVE.B  (A2), (A0)+
    CMP.B   #57, (A2)
    BNE     REMISE0
    MOVE.B  #48, (A2)
    MOVE.L  #COMPTEURNUL, A2
    MOVE.B  #0, (A2)
    BRA     FONDSTART
    

PARTIENUL:
    MOVE.L   #$000000, D1
    JSR      SET_FILL_COLOR
    MOVE.W   #0, D1
    MOVE.W   #0, D2
    MOVE.W   #1000, D3
    MOVE.W   #1000, D4
    JSR      DRAW_FILL_RECT
    
    MOVE.L  #RETOURNUL, A1
    JSR     AFFCHAINE
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    MOVE.L  #RETOURSCORE, A1
    JSR     AFFCHAINE
    MOVE.L  #SCORE1, A1
    MOVE.B  (A1), D1
    JSR     AFFCAR
    MOVE.B  #45, D1
    JSR     AFFCAR
    MOVE.L  #SCORE2, A1
    MOVE.B  (A1), D1
    JSR     AFFCAR
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    MOVE.L  #REJOUER, A1
    JSR     AFFCHAINE
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    JSR     SAISCAR
    CMP.B   #89, D1
    BNE     FIN
    MOVE.L  #CASE1, A0
    BRA     REMISE0
	

PARTIE1:
    MOVE.L   #$000000, D1
    JSR      SET_FILL_COLOR
    MOVE.W   #0, D1
    MOVE.W   #0, D2
    MOVE.W   #1000, D3
    MOVE.W   #1000, D4
    JSR      DRAW_FILL_RECT
    
    MOVE.L  #SCORE1, A0
    ADD.B   #1, (A0)
    MOVE.L  #RETOUR1, A1
    JSR     AFFCHAINE
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    MOVE.L  #RETOURSCORE, A1
    JSR     AFFCHAINE
    MOVE.L  #SCORE1, A1
    MOVE.B  (A1), D1
    JSR     AFFCAR
    MOVE.B  #45, D1
    JSR     AFFCAR
    MOVE.L  #SCORE2, A1
    MOVE.B  (A1), D1
    JSR     AFFCAR
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    MOVE.L  #REJOUER, A1
    JSR     AFFCHAINE
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    JSR     SAISCAR
    CMP.B   #89, D1
    BNE     FIN
    MOVE.L  #CASE1, A0
    BRA     REMISE0


PARTIE2:
    MOVE.L   #$000000, D1
    JSR      SET_FILL_COLOR
    MOVE.W   #0, D1
    MOVE.W   #0, D2
    MOVE.W   #1000, D3
    MOVE.W   #1000, D4
    JSR      DRAW_FILL_RECT
    
    MOVE.L  #SCORE2, A0
    ADD.B   #1, (A0)
    MOVE.L  #RETOUR2, A1
    JSR     AFFCHAINE
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    MOVE.L  #RETOURSCORE, A1
    JSR     AFFCHAINE
    MOVE.L  #SCORE1, A1
    MOVE.B  (A1), D1
    JSR     AFFCAR
    MOVE.B  #45, D1
    JSR     AFFCAR
    MOVE.L  #SCORE2, A1
    MOVE.B  (A1), D1
    JSR     AFFCAR
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    MOVE.L  #REJOUER, A1
    JSR     AFFCHAINE
*-------------------
    MOVE.B  #10, D1
    JSR     AFFCAR
    MOVE.B  #13, D1
    JSR     AFFCAR    
*-------------------
    JSR     SAISCAR
    CMP.B   #89, D1
    BNE     FIN
    MOVE.L  #CASE1, A0
    BRA     REMISE0
  
  
FIN:
    JMP     FINPRG
    INCLUDE 'BIBLIO2.X68'

*-----------------------------------------------------------

    ORG     $800
RETOURNUL: DC.B  'Fin de la partie ! Match nul...',0
RETOUR1:   DC.B  'Fin de la partie ! Le joueur 1 a gagné',0
RETOUR2:   DC.B  'Fin de la partie ! Le joueur 2 a gagné',0
REJOUER:   DC.B  'Voulez-vous rejouer ? Y/N',0
RETOURSCORE: DC.B 'Le score est actuellement de : ',0

*-----------------------------------------------------------

    ORG     $900
CASE1: DC.B '1'
CASE2: DC.B '2'
CASE3: DC.B '3'
CASE4: DC.B '4'
CASE5: DC.B '5'
CASE6: DC.B '6'
CASE7: DC.B '7'
CASE8: DC.B '8'
CASE9: DC.B '9'

    ORG     $910
CASEREMISE: DC.B '0'

*-----------------------------------------------------------

    ORG     $920
COMPTEURNUL: DC.B  0   
TOUR:        DC.B  1   

*-----------------------------------------------------------

    ORG     $930
COL: DC.B  0
LIG: DC.B  0

*-----------------------------------------------------------

    ORG     $940
SCORE1: DC.B  '0'
SCORE2: DC.B  '0'

    END     $1000

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
