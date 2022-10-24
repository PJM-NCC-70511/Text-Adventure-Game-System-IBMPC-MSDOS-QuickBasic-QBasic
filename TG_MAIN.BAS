'****************************************************************************
'***                                                                      ***
'***                Text Adventure Game System Main Program               ***
'***             IBM PC Qbasic Version 1.00 by Peter J. Meyer             ***
'***                                                                      ***
'****************************************************************************
'Modified (1.00-10/93)
'
'       This is the main program for the text adventure game system.  It
' displays a main menu allowing the user to choose to play a game, edit a
' game, change the program parameters, or exit the system.
'

DO
  CLS
  PRINT "                       Text Adventure Game System"
  PRINT "                     Version 1.00 By Peter J. Meyer"
  PRINT
  PRINT
  PRINT "                              Main Menu"
  PRINT
  PRINT "                 1. Play Text Adventure game."
  PRINT
  PRINT "                 2. Text Adventure file editor."
  PRINT
  PRINT "                 3. System setup."
  PRINT
  PRINT "                 4. Leave system."
  PRINT
  PRINT "                 Press choice on keyboard."
  PRINT
  DO
    Ki$ = INKEY$
  LOOP UNTIL LEN(Ki$) = 1
  IF Ki$ = "1" THEN RUN "TG_PLAY.EXE"
  IF Ki$ = "2" THEN RUN "TG_EDIT.EXE"
  IF Ki$ = "3" THEN GOSUB SET.UP
LOOP UNTIL Ki$ = "4"
END

SET.UP:
  DO
    CLS
    PRINT "What is you current graphics adapter?"
    PRINT
    PRINT "1. Hercules"
    PRINT
    PRINT "2. CGA"
    PRINT
    PRINT "3. EGA"
    PRINT
    PRINT "4. VGA"
    PRINT
    DO
      Ki$ = INKEY$
    LOOP UNTIL LEN(Ki$) = 1
  LOOP UNTIL Ki$ = "1" OR Ki$ = "2" OR Ki$ = "3" OR Ki$ = "4" OR Ki$ = "0"
  IF Ki$ = "1" OR Ki$ = "2" OR Ki$ = "3" OR Ki$ = "4" THEN ADAPTER = VAL(Ki$)
  PRINT
  PRINT "What is the current file path?"
  INPUT PATH$
  OPEN "TG.TGS" FOR OUTPUT AS #1
    PRINT #1, ADAPTER
    PRINT #1, PATH$
  CLOSE #1
RETURN

