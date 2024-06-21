*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
AFFCAR:
    MOVE    #6, D0
    TRAP    #15
    RTS 
SAISCAR:
    MOVE    #5, D0
    TRAP    #15
    RTS     
FINPRG:
    MOVE    #9, D0
    TRAP    #15
AFFCHAINE:
    MOVE.B  (A1)+, D1
    JSR     AFFCAR
    CMP.B   #0, D1
    BNE     AFFCHAINE
    RTS
GET_MOUSE
    MOVE    #61, D0
    TRAP    #15
    RTS
SET_PEN_COLOR:
    MOVE    #80, D0
    TRAP    #15
    RTS
SET_FILL_COLOR:
    MOVE    #81, D0
    TRAP    #15
    RTS
DRAW_LINE:
    MOVE    #84, D0
    TRAP    #15
    RTS
DRAW_FILL_RECT:
    MOVE    #87, D0
    TRAP    #15
    RTS
WIDTH_PEN:
    MOVE    #93, D0
    TRAP    #15
    RTS
DRAW_STRING:
    MOVE    #95, D0
    TRAP    #15
    RTS
DRAW_RECT:
    MOVE    #90, D0
    TRAP    #15
    RTS
DRAW_ELLIPSE:
    MOVE    #91, D0
    TRAP    #15
    RTS
POT_DE_PEINTURE:
    MOVE    #89, D0
    TRAP    #15
    RTS

 









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
