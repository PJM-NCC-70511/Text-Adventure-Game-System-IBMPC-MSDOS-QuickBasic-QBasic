DECLARE SUB LOADPICTURE (F$)
DECLARE SUB SETSCREEN ()

DEFINT A-Z
COMMON SHARED ADAPTER, PCOL, HIGHT, MAXHIGHT, VX, VY

GOSUB Initialize
DO
  GOSUB Get.game
  GOSUB Main.line
  GOSUB Game.over
LOOP UNTIL CHOICE = 81
RUN "TG_MAIN.EXE"

Initialize:
  'CHDIR "TEXTGAME"
  RANDOMIZE TIMER
  OPEN "TG.TGS" FOR INPUT AS #1
    INPUT #1, ADAPTER
    INPUT #1, PATH$
  CLOSE #1
 
  PW.DIM = 32
  DIM PW$(PW.DIM)
  OB.DIM = 128
  DIM Ot(OB.DIM), OP(OB.DIM), OV(OB.DIM), OV2(OB.DIM), OV3(OB.DIM)
  DIM OL(OB.DIM), ON$(OB.DIM), Od$(OB.DIM)
  HS.DIM = 64
  DIM Ht(HS.DIM), Hl(HS.DIM), HS(HS.DIM), HH(HS.DIM), Hm(HS.DIM), Hv(HS.DIM)
  DIM Hn$(HS.DIM), HO(HS.DIM)
  RM.DIM = 192
  DIM RT(RM.DIM), Rn(RM.DIM), Rnl(RM.DIM), Rnk(RM.DIM), Rw(RM.DIM), Rwl(RM.DIM)
  DIM Rwk(RM.DIM), Re(RM.DIM), Rel(RM.DIM), Rek(RM.DIM), Rs(RM.DIM), Rsl(RM.DIM)
  DIM Rsk(RM.DIM), Ru(RM.DIM), Rul(RM.DIM), Rd(RM.DIM), Rdl(RM.DIM), Ro(RM.DIM)
  DIM Rol(RM.DIM), Rov(RM.DIM), REN$(RM.DIM), Rd$(RM.DIM)
   S0 = 0
   WinPlace = 0
   WinItem01 = 0
   WinItem02 = 0
   WinItem03 = 0
   S5 = 0
   S6 = 0
   WinItem04 = 0
   S8 = 0
   S9 = 0
   S10 = 0
   S11 = 0
   S12 = 0
   S13 = 0
   S14 = 0
   S15 = 0
   S16 = 0
   S17 = 0
   S18 = 0
   S19 = 0
   S20 = 0
   S21 = 0
   S22 = 0
   S23 = 0
   S24 = 0
   S25 = 0
   S26 = 0
   S27 = 0
   S28 = 0
   S29 = 0
   S30 = 0
   S31 = 0
   S32 = 0
   S33 = 0
   S34 = 0
   S35 = 0
   S36 = 0
   S37 = 0
   S38 = 0
   S39 = 0
   S40 = 0
   CU$ = " "
   a$ = SPACE$(640)
   CHOICE = 0
   EXIT.NAME$ = "EXIT"
   EXIT.ADJECTIVE$ = "GOING"
RETURN

Main.line:
 DO
   DO
     PR = R
     CLS
     IF RT(R) = 8 THEN
       GOSUB Answer.riddle
     ELSE
       GOSUB New.place
       IF SP! < 0 OR FW <= 0 THEN DEAD = 1
       Ft = 1
       IF DEAD = 0 THEN
         DO WHILE R = PR AND SP! >= 0 AND FW >= 0 AND TN <= S12 AND DEAD = 0 AND NOT WIN
           TN = TN + 1
           FW = FW - 1
           IF Ft = 0 THEN
             PRINT "--------------------------------------------------------------------------------";
           ELSE
             PRINT
             Ft = 0
           END IF
           H = 0
           IF Fm THEN
             GOSUB Check.for.hostilities
           ELSE
             GOSUB Move.hostilities
           END IF
           GOSUB Enter.command
           IF LEN(a$) >= 2 THEN
             GOSUB Perform.action
           ELSE
             GOSUB Go.direction
           END IF
           IF Imm > 0 THEN
             Imm = Imm - 1
           ELSE
             IF Inf > 0 THEN
               SP! = SP! - Inf
             END IF
             IF Psn > 0 THEN
               SP! = SP! - Psn
             END IF
             IF H > 0 THEN
               GOSUB Hostility.attacks
             END IF
           END IF
         LOOP
       END IF
       N = 0
       IF R = WinPlace OR WinPlace = 0 THEN N = N + 1
       IF OL(WinItem01) = 0 OR WinItem01 = 0 THEN N = N + 1
       IF OL(WinItem02) = 0 OR WinItem02 = 0 THEN N = N + 1
       IF OL(WinItem03) = 0 OR WinItem03 = 0 THEN N = N + 1
       IF OL(WinItem04) = 0 OR WinItem04 = 0 THEN N = N + 1
       IF OL(S30) = 0 OR S30 = 0 THEN N = N + 1
       IF OL(S31) = 0 OR S31 = 0 THEN N = N + 1
       IF OL(S32) = 0 OR S32 = 0 THEN N = N + 1
       IF OL(S33) = 0 OR S33 = 0 THEN N = N + 1
       IF OL(S34) = 0 OR S34 = 0 THEN N = N + 1
       IF OL(S35) = 0 OR S35 = 0 THEN N = N + 1
       IF HH(S5) = 0 OR S5 = 0 THEN N = N + 1
       IF HH(S36) = 0 OR S36 = 0 THEN N = N + 1
       IF HH(S37) = 0 OR S37 = 0 THEN N = N + 1
       IF HH(S38) = 0 OR S38 = 0 THEN N = N + 1
       IF HH(S39) = 0 OR S39 = 0 THEN N = N + 1
       IF C >= S6 OR S6 = 0 THEN N = N + 1
       IF N = 17 THEN WIN = 1
     END IF
   LOOP UNTIL DEAD = 1 OR WIN = 1 OR TN > S12
   IF TN > S12 THEN LIVES = -1
   IF SP! < 0 OR FW < 0 OR DEAD THEN
     DEAD = 0
     LIVES = LIVES - 1
     IF LIVES > 0 THEN
       PRINT "You have "; LIVES; " lives left."
       PRINT "Press any key to continue."
       X$ = INKEY$
       DO
       LOOP UNTIL INKEY$ <> ""
     END IF
     IF SP! < 10 THEN SP! = S8
     IF FW < 10 THEN FW = S13
     IF S16 = 2 OR S16 = 3 OR RT(R) = 2 OR RT(R) = 5 OR RT(R) = 9 THEN
       PR = S14
       R = S14
     END IF
     IF S16 = 1 THEN
       PR = 0
       H = 0
     END IF
   END IF
 LOOP UNTIL LIVES <= 0 OR WIN = 1
RETURN

Check.for.hostilities:
    FOR N = 1 TO HOS
      IF Hl(N) = R THEN
        GOSUB Hostility.present
      END IF
    NEXT N
    Fm = 0
RETURN

Hostility.present:
    M = Ht(N) AND 127
    IF HH(N) >= 0 THEN
      IF M = 1 OR M = 2 OR M = 12 OR M = 13 THEN
        PRINT "The "; Hn$(N); " is attacking you."
        H = N
      END IF
      IF (M > 2 AND RT(N) < 12) OR M > 13 THEN
        PRINT "The "; Hn$(N); " is in here."
        H = N
      END IF
      IF HH(N) > 0 AND M < 12 THEN
        PRINT "It has "; HH(N); " hit points."
      END IF
    ELSE
      PRINT "There is a dead "; Hn$(N); " in here."
    END IF
    RETURN

Place.Info:
    a$ = Rd$(R)
    R$ = REN$(R)
    CLS
    IF LEFT$(a$, 1) = "(" THEN
      a$ = MID$(a$, 2, INSTR(1, a$, ")") - 3)
      GOSUB Read.text.file
    END IF
    I = INSTR(1, a$, "|")
    IF I > 0 THEN
      F$ = MID$(a$, I + 1)
      a$ = LEFT$(a$, I - 1)
      LOADPICTURE F$
    END IF
    I = INSTR(1, a$, "{")
    IF I > 0 AND (S0 = 1 OR S0 = 2) THEN
      IF INSTR(1, a$, "}") > 0 THEN
         J = INSTR(1, a$, "}") - I - 1
      END IF
      EXIT.NAME$ = MID$(a$, I + 1, J)
      a$ = LEFT$(a$, I - 1)
      IF INSTR(1, EXIT.NAME$, ",") > 0 THEN
        J = INSTR(1, EXIT.NAME$, ",")
        EXIT.ADJECTIVE$ = MID$(EXIT.NAME$, J + 1)
        EXIT.NAME$ = LEFT$(EXIT.NAME$, J - 1)
      END IF
    END IF
    IF S0 = 0 OR RT(R) = 8 OR RT(R) = 2 THEN
      ADJ = 1
      GOSUB Display
    END IF
RETURN

Read.text.file:
    ON ERROR GOTO 314
    P$ = a$
    OPEN P$ FOR INPUT AS #1
    INPUT #1, a
    a$ = INPUT$(a, 1)
314 CLOSE #1
RETURN

New.place:
    IF RT(R) <> 4 OR L > 0 THEN
      IF RT(R) = 14 AND a$ <> "L" THEN GOSUB Lock.exits
      GOSUB Place.Info
      IF S0 = 1 OR S0 = 2 THEN a$ = a$ + " "
      ON ERROR GOTO 0
      IF RT(R) <> 2 THEN
        t1 = 0
        B$ = ""
        IF Rn(R) > 0 AND Rn(R) <> 4 THEN
          B$ = B$ + "North"
          t1 = 1
          IF Rn(R) = 3 OR Rn(R) = 5 THEN B$ = B$ + "(locked)"
          IF Rn(R) = 2 THEN B$ = B$ + "(unlocked)"
        END IF
        IF (Re(R) > 0 AND Re(R) <> 4) AND t1 > 0 THEN
          B$ = B$ + ", "
          T2 = LEN(B$)
        END IF
        IF Re(R) > 0 AND Re(R) <> 4 THEN
          B$ = B$ + "East"
          t1 = t1 + 1
          IF Re(R) = 3 OR Re(R) = 5 THEN B$ = B$ + "(locked)"
          IF Re(R) = 2 THEN B$ = B$ + "(unlocked)"
        END IF
        IF (Rw(R) > 0 AND Rw(R) <> 4) AND t1 THEN
          B$ = B$ + ", "
          T2 = LEN(B$)
        END IF
        IF Rw(R) > 0 AND Rw(R) <> 4 THEN
          B$ = B$ + "West"
          t1 = t1 + 1
          IF Rw(R) = 3 OR Rw(R) = 5 THEN B$ = B$ + "(locked)"
          IF Rw(R) = 2 THEN B$ = B$ + "(unlocked)"
        END IF
        IF (Rs(R) > 0 AND Rs(R) <> 4) AND t1 THEN
          B$ = B$ + ", "
          T2 = LEN(B$)
        END IF
        IF Rs(R) > 0 AND Rs(R) <> 4 THEN
          B$ = B$ + "South"
          t1 = t1 + 1
          IF Rs(R) = 3 OR Rs(R) = 5 THEN B$ = B$ + "(locked)"
          IF Rs(R) = 2 THEN B$ = B$ + "(unlocked)"
        END IF
        IF (Ru(R) > 0 AND Ru(R) <> 4) AND t1 THEN
          B$ = B$ + ", "
          T2 = LEN(B$)
        END IF
        IF Ru(R) > 0 AND Ru(R) <> 4 THEN
          B$ = B$ + "Up"
          t1 = t1 + 1
        END IF
        IF (Rd(R) > 0 AND Rd(R) <> 3 AND Rd(R) <> 4) AND t1 THEN
          B$ = B$ + ", "
          T2 = LEN(B$)
        END IF
        IF Rd(R) > 0 AND Rd(R) <> 4 AND Rd(R) <> 3 THEN
          B$ = B$ + "Down"
          t1 = t1 + 1
        END IF
        IF Ro(R) > 0 AND Ro(R) < 6 THEN
          R$ = REN$(R)
          B$ = B$ + ", "
          T2 = LEN(B$)
          IF S0 = 1 OR S0 = 2 THEN
            B$ = B$ + "There is a"
            t1 = t1 + 1
            IF INSTR(1, "AEIOU", UCASE$(RIGHT$(R$, 1))) > 1 THEN B$ = B$ + "n"
          END IF
          T2 = LEN(B$)
          B$ = B$ + " " + R$
          IF Ro(R) = 5 THEN B$ = B$ + "(locked)"
        ELSE
          IF Ro(R) = 4 THEN B$ = B$ + "(blocked)"
        END IF
        B$ = B$ + ". "
        IF t1 > 1 THEN
          IF S0 = 0 THEN
            a$ = "EXITS:"
          ELSE
            a$ = a$ + "There are " + LCASE$(EXIT.NAME$) + "s " + LCASE$(EXIT.ADJECTIVE$) + " "
            B$ = LCASE$(B$)
          END IF
          IF t1 > 2 THEN P$ = LEFT$(B$, T2 - 1) + " and" + MID$(B$, T2)
          IF t1 = 2 THEN P$ = LEFT$(B$, T2 - 2) + " and" + MID$(B$, T2)
          a$ = a$ + P$
        ELSEIF t1 = 1 THEN
          IF S0 = 0 THEN
             a$ = "EXIT:"
          ELSE
             a$ = a$ + "There is a " + LCASE$(EXIT.NAME$) + " " + LCASE$(EXIT.ADJECTIVE$) + " "
             B$ = LCASE$(B$)
          END IF
          a$ = a$ + B$
        END IF
        IF S0 = 0 OR S0 = 1 THEN
          ADJ = 1
          GOSUB Display
        END IF
        IF RT(R) <> 7 THEN
          B$ = ""
          t1 = 0
          T2 = 0
          FOR N = 1 TO OBJ
            IF OL(N) = R AND t1 THEN
              B$ = B$ + ", "
              T2 = LEN(B$)
            END IF
            IF OL(N) = R THEN
              t1 = t1 + 1
              B$ = B$ + ON$(N)
            END IF
          NEXT N
          IF Ro(R) = 7 THEN
            IF t1 THEN B$ = B$ + ", "
            T2 = LEN(B$)
            B$ = B$ + R$
            t1 = t1 + 1
          END IF
          IF t1 > 0 THEN
            'B$ = B$ + ". "
            P$ = B$
            IF t1 = 2 THEN P$ = LEFT$(B$, T2 - 2) + " and" + MID$(B$, T2)
            IF t1 > 2 THEN P$ = LEFT$(B$, T2 - 1) + " and" + MID$(B$, T2)
            IF S0 = 0 OR S0 = 1 THEN
              a$ = "OBJECT"
              IF t1 > 1 THEN a$ = a$ + "S"
              a$ = a$ + ":" + P$
            ELSEIF S0 = 2 THEN
              IF UCASE$(RIGHT$(B$, 1)) = "S" AND t1 = 1 THEN t1 = 99
              IF t1 < 3 THEN
                a$ = a$ + "There is "
                IF INSTR(1, "AEIOU", UCASE$(LEFT$(B$, 1))) THEN
                  a$ = a$ + "an "
                ELSE
                  a$ = a$ + "a "
                END IF
                a$ = a$ + LCASE$(P$) + " in here. "
              ELSE
                a$ = a$ + "There are " + LCASE$(P$) + " in here. "
              END IF
            END IF
          END IF
          IF B$ <> "" OR S0 = 2 THEN
            ADJ = 1
            GOSUB Display
         END IF
        ELSE
          PRINT "OBJECT"; TAB(30); UCASE$(CU$)
          FOR N = 1 TO OBJ
            IF OL(N) = R THEN
              PRINT UCASE$(ON$(N)); TAB(30); OP(N)
            END IF
          NEXT N
        END IF
      ELSEIF RT(R) = 2 THEN
        DEAD = 1
      END IF
    ELSE
      CLS
      PRINT "Too dark, can not see."
    END IF
    IF RT(R) = 3 THEN
      SP! = SP! - S17
      PRINT "You lost "; S17; C$
      IF SP! < 0 THEN
        SP! = 0
        DEAD = 1
        PRINT "Died because did not enough"; C$
      END IF
    IF RT(R) = 5 THEN
      GOSUB Find.survival.equipment
    END IF
    IF RT(R) = 9 THEN
      C = C - S24
      IF C < 0 THEN
        C = 0
      END IF
    END IF
    IF RT(R) = 15 OR (RT(R) = 10 AND S16 = 3) THEN S14 = R
RETURN

Go.direction:
    B$ = "Can not go that way, it is locked. "
    P$ = "Can not go that way, need password. "
    IF a$ = "N" THEN
      N = Rn(R)
      M = Rnl(R)
      GOSUB Ok.to.move
    END IF
    IF a$ = "E" THEN
      N = Re(R)
      M = Rel(R)
      GOSUB Ok.to.move
    END IF
    IF a$ = "W" THEN
      N = Rw(R)
      M = Rwl(R)
      GOSUB Ok.to.move
    END IF
    IF a$ = "S" THEN
      N = Rs(R)
      M = Rsl(R)
      GOSUB Ok.to.move
    END IF
    IF a$ = "D" THEN
      IF Rd(R) = 1 OR Rd(R) = 4 THEN
        R = Rdl(R)
      END IF
      IF Rd(R) = 2 THEN
        M = Rdl(R)
        GOSUB Ok.to.climb
      END IF
    END IF
    IF a$ = "U" THEN
      IF Ru(R) = 1 OR Ru(R) = 4 THEN
        R = Rul(R)
      END IF
      IF Ru(R) = 2 THEN
        M = Rul(R)
        GOSUB Ok.to.climb
      END IF
    END IF
    IF a$ = "I" THEN
      GOSUB Examine.inventory
    END IF
    IF Ht(H) = 7 OR Ht(H) = 14 OR (RT(R) = 6 AND H > 0) THEN
      IF PR > 0 THEN R = PR
      PRINT "The "; Hn$(H); " prevents you from exiting."
    END IF
    IF a$ = "L" THEN
      PR = 0
    END IF
RETURN

Ok.to.move:
    IF N = 3 THEN
      PRINT B$
    END IF
    IF N = 5 THEN
      PRINT P$
    END IF
    IF N = 1 OR N = 2 OR N = 4 THEN
      R = M
    END IF
    RETURN

Ok.to.climb:
    FOR N = 1 TO OBJ
      IF Ot(N) = 11 AND OL(N) = 0 THEN R = M
    NEXT N
    IF PR = R THEN
      PRINT "Need something to climb with."
    END IF
RETURN

Enter.command:
    GOSUB Show.status
    DO
      PRINT
      PRINT "Enter command."
      INPUT ">", a$
    LOOP UNTIL a$ <> ""
    IF a$ = "*" THEN
      a$ = PC$
      LOCATE CSRLIN - 1, 2
      PRINT PC$
    ELSE
      a$ = UCASE$(a$)
    END IF
    GOSUB Break.down
RETURN

Break.down:
    PC$ = a$
    IF RIGHT$(a$, 1) = "." OR RIGHT$(a$, 1) = "!" THEN
      a$ = MID$(a$, 1, LEN(a$) - 1)
    END IF
    LOC.THE = INSTR(1, a$, "THE ")
    IF LOC.THE > 0 THEN
      NOUN$ = MID$(a$, LOC.THE + 4)
      a$ = LEFT$(a$, LOC.THE - 1) + NOUN$
    END IF
    LOC.TO = INSTR(1, a$, "TO ")
    IF LOC.TO > 0 THEN
      NOUN$ = MID$(a$, LOC.TO + 3)
      a$ = LEFT$(a$, LOC.TO - 1) + NOUN$
    END IF
    GOSUB SEPERATE.VERB.NOUN
    IF Verb$ = "JUMP" OR Verb$ = "LEAP" OR Verb$ = "CLIMB" OR Verb$ = "JOG" THEN
      a$ = MID$(NOUN$, 2)
      GOSUB SEPERATE.VERB.NOUN
    END IF
    IF Verb$ = "GO" OR Verb$ = "RUN" OR Verb$ = "WALK" OR Verb$ = "TURN" THEN
      a$ = MID$(NOUN$, 2)
      GOSUB SEPERATE.VERB.NOUN
    END IF
    PC$ = a$
    END IF
    IF Verb$ = "SOUTH" THEN a$ = "S"
    IF Verb$ = "NORTH" THEN a$ = "N"
    IF Verb$ = "EAST" THEN a$ = "E"
    IF Verb$ = "WEST" THEN a$ = "W"
    IF Verb$ = "UP" THEN a$ = "U"
    IF Verb$ = "DOWN" THEN a$ = "D"
    IF Verb$ = "LOOK" OR a$ = "GAZE" OR LEFT$(a$, 3) = "SEE" OR a$ = "GLANCE" OR LEFT$(a$, 4) = "VIEW" THEN a$ = "L"
    IF Verb$ = "INVENTORY" OR a$ = "INV" THEN a$ = "I"
    IF Verb$ = "KICK" THEN a$ = "K2"
    IF Verb$ = "PUNCH" OR Verb$ = "HIT" OR Verb$ = "SLAP" THEN a$ = "K3"
    IF Verb$ = "EXAMINE" OR Verb$ = "READ" OR Verb$ = "LOOK" OR Verb$ = "CHECK" THEN
      IF LEFT$(NOUN$, 3) = " AT" THEN
        NOUN$ = MID$(NOUN$, 4)
      END IF
      IF NOUN$ <> "" THEN
        a$ = "X" + NOUN$
      ELSE
        a$ = "L"
      END IF
    END IF
    IF Verb$ = "DIG" OR Verb$ = "SHOVEL" OR Verb$ = "UNCOVER" THEN a$ = "DIG"
    IF Verb$ = "SHOUT" OR Verb$ = "SAY" OR Verb$ = "CAST" THEN a$ = "S" + NOUN$
    IF Verb$ = "MAKE" OR Verb$ = "ASSEMBLE" OR Verb$ = "BUILD" THEN a$ = "M" + NOUN$
    IF Verb$ = "GET" OR Verb$ = "BUY" OR Verb$ = "TAKE" OR Verb$ = "STEEL" OR Verb$ = "GRAB" OR Verb$ = "OBTAIN" OR Verb$ = "POSSESS" THEN
      a$ = "G" + NOUN$
    END IF
    IF Verb$ = "SELL" OR Verb$ = "DROP" OR Verb$ = "LEAVE" THEN a$ = "D" + NOUN$
    IF Verb$ = "ENTER" OR Verb$ = "CROSS" OR Verb$ = "IN" THEN a$ = "R" + NOUN$
    IF Verb$ = "USE" OR Verb$ = "ACTIVATE" OR Verb$ = "DETONATE" THEN a$ = "U" + NOUN$
    IF Verb$ = "EAT" OR Verb$ = "SWALLOW" OR Verb$ = "DRINK" OR Verb$ = "BITE" OR Verb$ = "CONSUME" THEN a$ = "E" + NOUN$
    IF Verb$ = "ZAP" OR Verb$ = "TELEPORT" OR B$ = "TRANSPORT" OR B$ = "BEAM" THEN a$ = "T" + NOUN$
    IF Verb$ = "SHOOT" OR Verb$ = "SWING" OR Verb$ = "POKE" OR Verb$ = "JAB" OR Verb$ = "STAB" THEN
      a$ = "K" + NOUN$
    END IF
    IF Verb$ = "THROW" OR Verb$ = "HURL" OR Verb$ = "FLING" OR Verb$ = "PITCH" THEN
      a$ = "K1" + MID$(NOUN$, 2)
    END IF
    IF Verb$ = "ON" OR Verb$ = "LIGHT" THEN a$ = "ON"
    IF Verb$ = "OFF" OR Verb$ = "UNLIGHT" THEN a$ = "OFF"
    IF Verb$ = "OPEN" OR Verb$ = "UNLOCK" THEN a$ = "O" + NOUN$
    IF Verb$ = "LOCK" OR Verb$ = "CLOSE" THEN a$ = "C" + NOUN$
    IF Verb$ = "PUSH" OR Verb$ = "PULL" OR Verb$ = "YANK" OR Verb$ = "MOVE" THEN a$ = "P" + NOUN$
    IF Verb$ = "FRY" OR Verb$ = "BURN" THEN a$ = "B" + NOUN$
    IF Verb$ = "BREAK" OR Verb$ = "BUST" OR Verb$ = "HIT" OR Verb$ = "SLAM" THEN a$ = "H" + NOUN$
650
RETURN

Show.status:
   a$ = "    You "
   IF S12 > 0 THEN
     a$ = a$ + "are on turn " + STR$(TN) + " of " + STR$(S12) + ". "
   END IF
   B$ = ""
   T2 = 1
   LC = 1
   IF S15 > 0 THEN
     B$ = B$ + STR$(LIVES)
     IF LIVES = 1 THEN
       B$ = B$ + " life"
     ELSE
       B$ = B$ + " lives"
     END IF
     B$ = B$ + " left, "
     LC = T2
     T2 = LEN(B$)
   END IF
   IF S8 > 0 THEN
     B$ = B$ + STR$(SP!) + LCASE$(C$) + ", "
     LC = T2
     T2 = LEN(B$)
   END IF
   IF S22 > 0 THEN
     B$ = B$ + STR$(C) + " " + LCASE$(CU$)
     IF C <> 1 AND UCASE$(RIGHT$(CU$, 1)) <> "S" THEN B$ = B$ + "s"
     B$ = B$ + ", "
     LC = T2
     T2 = LEN(B$)
   END IF
   IF S21 = 1 THEN
     B$ = B$ + STR$(ARMR) + " armor point"
     IF NOT ARMR = 1 THEN B$ = B$ + "s"
     LC = T2
     B$ = B$ + ", "
     T2 = LEN(B$)
   END IF
   IF B$ <> "" THEN
     MID$(B$, T2 - 1) = ". "
     IF LC > 1 THEN
       P$ = LEFT$(B$, LC) + "and" + MID$(B$, LC)
       B$ = P$
     END IF
     a$ = a$ + "You have " + B$
   END IF
   IF S13 > 0 AND FW < 13 THEN
     a$ = a$ + "You need food or water, have " + STR$(FW) + " turns left. "
   END IF
   IF LEN(a$) > 9 THEN
     ADJ = 1
     GOSUB Display
   END IF
RETURN

SEPERATE.VERB.NOUN:
  SPACE = INSTR(1, a$, " ")
  IF SPACE THEN
    Verb$ = MID$(a$, 1, SPACE - 1)
    NOUN$ = MID$(a$, SPACE)
  ELSE
    Verb$ = a$
    NOUN$ = ""
  END IF
RETURN

Perform.action:
    IF RT(R) = 12 THEN GOSUB Correct.action
    P$ = MID$(a$, 1, 2)
    IF P$ = "G " THEN GOSUB Get.objects
    IF P$ = "D " THEN GOSUB Drop.objects
    IF P$ = "X " THEN GOSUB Examine.object
    IF P$ = "E " THEN GOSUB Consume.object
    IF a$ = "ON" THEN GOSUB Light.object
    IF P$ = "P " THEN GOSUB Push.object
    IF P$ = "O " THEN GOSUB Open.it
    IF P$ = "C " THEN GOSUB Close.exit
    IF a$ = "DIG" THEN GOSUB Dig.up.exit
    IF P$ = "S " THEN GOSUB Check.password
    IF P$ = "B " THEN GOSUB Burn.object
    IF P$ = "R " THEN GOSUB Enter.other.exit
    IF P$ = "H " THEN GOSUB Break.object
    IF P$ = "U " THEN GOSUB Blow.open.exit
    IF P$ = "K " OR P$ = "K1" OR P$ = "K2" OR P$ = "K3" THEN GOSUB Fight.hostility
    IF P$ = "T " THEN GOSUB Transport
    IF P$ = "M " THEN GOSUB Search.For.Components
    IF a$ = "OFF" AND L = 1 THEN L = 0: PR = 0
RETURN

Display:
    J = 1
    I = 80
    IF I > LEN(a$) THEN I = LEN(a$)
    WHILE I <= LEN(a$) AND J <= LEN(a$)
    IF I < LEN(a$) THEN
      IF MID$(a$, I + 1, 1) = " " THEN I = I - 1
        B$ = MID$(a$, I, 1)
        WHILE B$ <> " " AND B$ <> "." AND B$ <> "-" AND B$ <> "," AND B$ <> "!" AND B$ <> "?"
          B$ = MID$(a$, I, 1)
          I = I - 1
        WEND
      END IF
      IF MID$(a$, J, 1) = " " THEN J = J + 1
      IF MID$(a$, I, 1) = " " THEN I = I - 1
      IF I - J > 1 THEN P$ = MID$(a$, J, I - J + 1)
      IF ADJ = 2 THEN
        T = INT(39.5 - LEN(P$) / 2)
      END IF
      IF ADJ = 1 OR T < 0 THEN T = 0
      IF T THEN PRINT TAB(T);
      PRINT P$;
      IF LEN(P$) < 80 THEN PRINT
      J = I + 1
      I = I + 80
      IF I > LEN(a$) AND J < LEN(a$) THEN
        I = LEN(a$)
        ADJ = 1
      END IF
    WEND
    ADJ = 1
    ON ERROR GOTO 0
RETURN

Get.objects:
    P$ = MID$(a$, 3, LEN(a$))
    a$ = ""
    IF Oc < S10 AND Ht(H) <> 8 THEN
      FOR N = 1 TO OBJ
        IF OL(N) = R AND (INSTR(1, UCASE$(ON$(N)), P$) OR INSTR(1, P$, UCASE$(ON$(N))) > 0 OR P$ = UCASE$(ON$(N))) THEN
          IF RT(R) <> 7 OR (RT(R) = 7 AND C > OP(N)) THEN
          a$ = "Ok,"
            IF RT(R) = 7 THEN
              a$ = a$ + " brought it for " + STR$(OP(N)) + " " + CU$
              C = C - OP(N)
              OL(N) = 0
            ELSE
              a$ = a$ + " got it."
            END IF
            IF NOT (Ot(N) = 18 OR Ot(N) = 20 OR Ot(N) = 23 OR Ot(N) = 24 OR Ot(N) = 26 OR Ot(N) = 28) THEN
              OL(N) = 0
              IF S21 = 0 THEN Oc = Oc + 1
              IF Ot(N) = 6 THEN GOSUB Measure.armor
            ELSE
              IF Ot(N) = 18 THEN
                a$ = a$ + "Now have more turns."
                OL(N) = -1
                S12 = S12 + OV(N)
              END IF
              IF Ot(N) = 20 THEN
                a$ = a$ + "Gained " + STR$(OV(N)) + " lives."
                OL(N) = -1
                LIVES = LIVES + OV(N)
              END IF
              IF Ot(N) = 22 THEN
                a$ = a$ + "Can carry " + STR$(OV(N)) + " more objects."
                S10 = S10 + OV(N)
                OL(N) = -1
              END IF
              IF Ot(N) = 23 OR Ot(N) = 24 OR Ot(N) = 26 THEN
                a$ = "Can't get it, too big and heavy."
                OL(N) = R
              END IF
              IF Ot(N) = 28 THEN
                GOSUB Collect.with.container
              END IF
            END IF
          ELSE
            a$ = "Do not have enougth " + CU$ + ". "
          END IF
        END IF
      NEXT N
      ADJ = 1
    END IF
    IF Ht(H) = 8 THEN
      a$ = "The " + Hn$(H) + " stops you from getting anything."
    END IF
    IF Oc >= S10 THEN
      a$ = a$ + "Can't carry anymore objects."
    END IF
    ADJ = 1
    GOSUB Display
RETURN

Drop.objects:
    P$ = MID$(a$, 3, LEN(a$))
    FOR N = 1 TO OBJ
      IF OL(N) = 0 AND INSTR(1, ON$(N), P$) THEN
        OL(N) = R
        IF RT(R) <> 7 THEN
          PRINT "Ok, dropping "; ON$(N); ". "
          Oc = Oc - 1
        ELSE
          IF S27 = 0 THEN P = OP(N)
          IF S27 = 1 THEN P = INT((OP(N) * .9) / 5) * 5
          PRINT "Ok, sold "; ON$(N); " for "; OP(N); " "; CU$
          Oc = Oc - 1
          C = C + P
        END IF
        IF Ot(N) = 14 OR Ot(N) = 27 THEN
          L = 0
        END IF
      END IF
    NEXT N
RETURN

Examine.inventory:
    a$ = "Inventory:"
    t1 = 0
    FOR N = 1 TO OBJ
      IF OL(N) = 0 AND t1 THEN
        a$ = a$ + ", "
      END IF
      IF OL(N) = 0 THEN
        a$ = a$ + LCASE$(ON$(N))
        t1 = 1
      END IF
    NEXT N
    a$ = a$ + ". "
    GOSUB Display
RETURN

Examine.object:
    P$ = MID$(a$, 3, LEN(a$))
    t1 = 0
    FOR N = 1 TO OBJ
      IF OL(N) = 0 AND (INSTR(1, ON$(N), P$) OR INSTR(1, P$, ON$(N))) THEN
        t1 = 1
        a$ = Od$(N)
        IF LEFT$(a$, 1) = "(" THEN
          a$ = MID$(a$, 2, INSTR(1, a$, ")") - 3)
          GOSUB Read.text.file
        END IF
        IF Ot(N) = 34 THEN GOSUB Read.text.file
        IF Ot(N) = 41 THEN GOSUB Show.screen.file
        ADJ = 2
        GOSUB Display
      END IF
    NEXT N
    IF t1 = 0 THEN
      PRINT "Object not in inventory."
    END IF
RETURN

Show.screen.file:
  P$ = a$
  OPEN P$ FOR INPUT AS #1
  a$ = INPUT$(1920, 1)
  CLOSE #1
  CLS
  LOCATE 1, 1
  PRINT a$;
  DO
  LOOP UNTIL INKEY$ <> ""
  a$ = ""
RETURN

Consume.object:
    P$ = MID$(a$, 3)
    FOR N = 1 TO OBJ
      IF OL(N) = 0 AND INSTR(1, ON$(N), P$) THEN
        IF Ot(N) = 5 THEN
          a$ = "That's better, now have " + STR$(OV(N)) + " more turns before getting more food or water."
          FW = FW + OV(N)
        END IF
        IF Ot(N) = 17 THEN
          IF OV(N) = 2 THEN
            a$ = "Lost " + STR$(OV2(N)) + " " + C$ + " because it was poisoned."
            SP! = SP! - OV2(N)
            OL(N) = -1
          END IF
          IF OV(N) = 1 THEN
            a$ = "The " + ON$(N) + " was a lethal poison, you are dead."
            SP! = -1
            OL(N) = -1
            DEAD = 1
          END IF
          IF OV(N) = 3 THEN
            a$ = "Member was poisoned, must find an antidote or will die."
            OL(N) = -1
            Psn = OV2(N)
          END IF
        END IF
        IF Ot(N) = 16 THEN
          SP! = SP! + OV(N)
          a$ = "That's better, now have " + STR$(SP!) + " " + C$ + ". "
          OL(N) = -1
        END IF
        IF Ot(N) = 28 THEN
          Imm = Imm + (OV(N))
          a$ = "Have immune power for " + STR$(Imm) + " turns."
          OL(N) = -1
        END IF
        IF Ot(N) = 31 AND Inf > 0 THEN
          OL(N) = -1
          a$ = "It cured the infection."
          Inf = 0
        END IF
        IF Ot(N) = 32 AND Psn > 0 THEN
          OL(N) = -1
          a$ = "It stopped the poison."
          Psn = 0
        END IF
        IF (Ot(N) = 16 OR Ot(N) = 17 OR Ot(N) = 28 OR Ot(N) = 31 OR Ot(N) = 32) AND OL(N) = -1 THEN
          ADJ = 1
          GOSUB Display
          I = INSTR(3, UCASE$(ON$(N)), " OF ")
          IF I > 0 THEN
            a$ = MID$(ON$(N), I)
            ON$(N) = "EMPTY " + a$
            OL(N) = 0
            Ot(N) = 28
          END IF
        END IF
        IF OL(N) = -1 THEN
          Oc = Oc - 1
        END IF
      END IF
    NEXT N
RETURN

Light.object:
     FOR N = 1 TO OBJ
       IF OL(N) = 0 THEN
         IF Ot(N) = 13 THEN
           Lt = Lt + OV(N)
           PR = 0
           L = 1
         END IF
         IF Ot(N) = 14 THEN
           Lt = Lt + OV(N)
           OL(N) = -1
           Oc = Oc - 1
         END IF
       END IF
     NEXT N
     PR = 0
RETURN

Collect.with.container:
     M = 1
     WHILE M < OBJ AND (Ot(M) <> 29 OR OL(M) > 0)
       M = M + 1
     WEND
     IF Ot(M) = 29 AND OL(M) = 0 THEN
       a$ = "Ok, collecting it."
       OV2(N) = OV2(N) - 1
       IF OV2(N) <= 0 THEN
         OL(N) = -1
       END IF
       IF OV(N) = 1 THEN
         Ot(M) = 5
       END IF
       IF OV(N) = 2 THEN
         Ot(M) = 16
       END IF
       IF OV(N) = 3 THEN
         Ot(M) = 17
       END IF
       IF OV(N) = 4 THEN
         Ot(M) = 28
       END IF
       IF MID$(ON$(M), 1, 6) = "EMPTY " THEN
         LET ON$(M) = MID$(ON$(M), 7)
       END IF
       B$ = ON$(N) + " OF " + ON$(M)
       LET ON$(M) = B$
     ELSE
       a$ = "Need something to contain it."
     END IF
RETURN

Find.survival.equipment:
     N = 1
     WHILE N < OBJ + 1 AND Ot(N) <> 15
       N = N + 1
     WEND
     IF N >= OBJ + 1 THEN
       DEAD = 1
     END IF
RETURN

Push.object:
     P$ = MID$(a$, 3, LEN(a$))
     WHILE N < OBJ + 1 AND NOT (OL(N) = R AND Ot(N) = 23 AND INSTR(1, P$, ON$(N))) > 0
       N = N + 1
     WEND
     IF OL(N) = R AND Ot(N) = 23 AND INSTR(1, ON$(N), P$) AND N < OBJ THEN
       IF OV(N) THEN
         GOSUB Reveal
       END IF
     ELSE
       PRINT "Can't push it."
     END IF
RETURN

Open.it:
     IF Rn(R) = 3 AND OL(Rnk(R)) = 0 THEN
       Rn(R) = 2
       PR = 0
     END IF
     IF Re(R) = 3 AND OL(Rek(R)) = 0 THEN
       Re(R) = 2
       PR = 0
     END IF
     IF Rw(R) = 3 AND OL(Rwk(R)) = 0 THEN
       Rw(R) = 2
       PR = 0
     END IF
     IF Rs(R) = 3 AND OL(Rsk(R)) = 0 THEN
       Rs(R) = 2
       PR = 0
     END IF
     IF Rn(R) = 3 AND OL(Rnk(R)) AND PR = R THEN
       PRINT "Can't open it , need "; ON$(Rnk(R))
     END IF
     IF Re(R) = 3 AND OL(Rek(R)) AND PR = R THEN
       PRINT "Can't open it , need "; ON$(Rek(R))
     END IF
     IF Rw(R) = 3 AND OL(Rwk(R)) AND PR = R THEN
       PRINT "Can't open it , need "; ON$(Rwk(R))
     END IF
     IF Rs(R) = 3 AND OL(Rsk(R)) AND PR = R THEN
       PRINT "Can't open it , need "; ON$(Rsk(R))
     END IF
     IF PR = R THEN
       P$ = MID$(a$, 3, LEN(a$))
       FOR N = 1 TO OBJ
         IF OL(N) = 0 AND INSTR(1, ON$(N), P$) THEN
           IF Ot(N) = 19 THEN
             IF OV2(N) = 0 OR OL(OV2(N)) = 0 THEN
               PRINT "Ok, found "; ON$(OV(N)); ". "
               OL(OV(N)) = 0
             END IF
             IF OV2(N) > 0 AND OL(OV2(N)) > 0 THEN
               PRINT "Cannot open it, need "; ON$(OV2(N)); ". "
             END IF
           END IF
           IF Ot(N) = 22 THEN
             B = 0
             IF OV(N) > 99 THEN
               B = INT(OV(N) / 100)
               OV(N) = OV(N) - B * 100
             END IF
             IF B = 0 OR OL(B) = 0 THEN
               GOSUB Reveal
             END IF
           END IF
           IF Ot(N) <> 19 AND Ot(N) <> 22 THEN
             PRINT "It will not open."
           END IF
         END IF
       NEXT N
     END IF
RETURN

Close.exit:
     IF Rn(R) = 2 AND OL(Rnk(R)) = 0 THEN
       Rn(R) = 3
       PR = 0
     END IF
     IF Re(R) = 2 AND OL(Rek(R)) = 0 THEN
       Re(R) = 3
       PR = 0
     END IF
     IF Rw(R) = 2 AND OL(Rwk(R)) = 0 THEN
       Rw(R) = 3
       PR = 0
     END IF
     IF Rs(R) = 2 AND OL(Rsk(R)) = 0 THEN
       Rs(R) = 3
       PR = 0
     END IF
RETURN

Dig.up.exit:
     FOR N = 1 TO OBJ
       IF Ot(N) = 10 AND OL(N) = 0 THEN
         IF Rd(R) = 3 THEN
           Rd(R) = 1
           PR = 0
         END IF
         IF Ro(R) = 2 THEN
           Ro(R) = 1
           PR = 0
         END IF
       END IF
     NEXT N
RETURN

Check.password:
     P$ = MID$(a$, 3, LEN(a$))
     PW = 0
     PRINT CHR$(34); P$; CHR$(34)
     FOR N = 0 TO Pwd
       a$ = UCASE$(PW$(N))
       IF INSTR(1, UCASE$(P$), a$) > 0 AND a$ <> "" THEN
         PW = N + 1
       END IF
     NEXT N
     IF Rn(R) = 5 AND PW = Rnk(R) THEN
       Rn(R) = 1
       PR = 0
     END IF
     IF Rw(R) = 5 AND PW = Rwk(R) THEN
       Rw(R) = 1
       PR = 0
     END IF
     IF Re(R) = 5 AND PW = Rek(R) THEN
       Re(R) = 1
       PR = 0
     END IF
     IF Rs(R) = 5 AND PW = Rsk(R) THEN
       Rs(R) = 1
       PR = 0
     END IF
     IF Ht(H) = 13 AND PW = HH(H) THEN
       PRINT "You defeated the "; Hn$(H); ". "
       HH(H) = -1
     END IF
     IF Ht(H) = 14 AND PW = HH(H) THEN
       PRINT "You got rid of the "; Hn$(H); ". "
       N = H
       WHILE Hl(N) = R
       GOSUB Random.place
       WEND
     END IF
     IF Ro(R) = 5 AND OV3(R) = PW THEN
       Ro(R) = 1
       PR = 0
     END IF
     IF Ro(R) = 6 AND OV3(R) = PW THEN
       Ro(R) = 1
       PR = 0
     END IF
     IF RT(R) = 11 AND Ro(R) = PW THEN
       R = Rol(R)
     END IF
     FOR N = 1 TO OBJ
       IF Ot(N) > 34 AND Ot(N) < 47 AND OV2(N) = PW AND OL(N) = 0 THEN
         IF Ot(N) = 35 THEN
           OL(N) = -1
           SP! = SP! + OV(N)
         END IF
         IF Ot(N) = 36 THEN
           R = OV(N)
         END IF
         IF Ot(N) = 38 THEN
           Lt = Lt + OV(N)
           OV(N) = 0
           GOSUB Light.object
           L = 1
         END IF
         IF Ot(N) = 39 THEN
           GOSUB Kill.Hostilities
         END IF
         IF Ot(N) = 40 THEN GOSUB Entrap.hostilities
         IF Ot(N) = 42 THEN
           GOSUB Search.For.Components
           OL(N) = -1
         END IF
       END IF
       IF Ot(N) = 37 THEN
         B = 0
         IF OV(N) > 99 THEN
           B = INT(OV(N) / 100)
           OV(N) = OV(N) - B * 100
         END IF
         IF PW = B THEN
           GOSUB Reveal
         END IF
       END IF
     NEXT N
RETURN

Correct.action:
     IF INSTR(1, R$, PC$) OR INSTR(1, PC$, R$) THEN
       R = Ro(R)
     ELSE
       R = Rol(R)
     END IF
RETURN

Burn.object:
     IF L > 0 AND Lt > 0 THEN
       P$ = MID$(a$, 3, LEN(a$))
       FOR N = 1 TO OBJ
         IF Ot(N) = 24 AND OL(N) = R AND INSTR(1, ON$(N), P$) THEN
           IF OV(N) > 0 THEN
             GOSUB Reveal
           END IF
           OL(N) = -1
           IF SP! < 0 THEN
             DEAD = 1
           END IF
         END IF
       NEXT N
     ELSE
       PRINT "Need something to burn it with."
     END IF
RETURN

Reveal:
     IF OV(N) = 1 THEN
       OL(OV2(N)) = R
       PR = 0
     END IF
     IF OV(N) = 2 THEN
       Rd(N) = 1
       Rdl(N) = OV2(N)
     END IF
     IF OV(N) = 3 THEN
       Ro(R) = 1
       Rol(R) = OV2(N)
       REN$(R) = Od$(N)
     END IF
     IF OV(N) = 4 THEN
       Rn(N) = 1
       Rnl(N) = OV2(N)
     END IF
     IF OV(N) = 5 THEN
       Re(N) = 1
       Rel(N) = OV2(N)
     END IF
     IF OV(N) = 6 THEN
       Rw(N) = 1
       Rwl(N) = OV2(N)
     END IF
     IF OV(N) = 7 THEN
       Rs(N) = 1
       Rsl(N) = OV2(N)
     END IF
     IF OV(N) = 8 THEN
       Ru(N) = 1
       Rul(N) = OV2(N)
     END IF
     IF OV(N) = 10 THEN
       B = INT(OV(N) / 100)
       a = OV(N) - B * 100
       FOR M = a TO B
         OL(M) = 0
         PRINT "Ok, Found "; ON$(N)
       NEXT M
     END IF
     IF OV(N) = 11 THEN GOSUB Examine.object
     IF OV(N) = 9 AND (Ot(N) = 22 OR Ot(N) = 23 OR Ot(N) = 24 OR Ot(N) = 26 OR Ot(N) = 36) THEN
       Hl(OV2(N)) = R
       PR = 0
     END IF
     IF OV(N) = 9 AND Ot(N) = 24 THEN
       a$ = "The " + ON$(N) + " exploded. Damaged by " + STR$(OV2(N)) + C$
       SP! = SP! - OV2(N)
       GOSUB Display
     END IF
     PR = 0
     OV(N) = 0
RETURN

Enter.other.exit:
     IF INSTR(1, R$, MID$(a$, 3)) THEN
       IF Ro(R) = 1 OR Ro(R) = 7 THEN
         R = Rol(R)
       END IF
       IF Ro(R) = 4 THEN
         PRINT "Can't go that way, it is blocked."
       END IF
       IF Ro(R) = 8 THEN
         PRINT "Can't go that way yet."
       END IF
       IF Ro(R) = 3 THEN
         M = Rol(R)
         GOSUB Ok.to.climb
       END IF
     END IF
RETURN

Kill.Hostilities:
     FOR M = 1 TO HOS
       IF Hl(M) = R THEN HH(N) = -1
       IF Hl(M) = Rnl(R) THEN HH(M) = -1
       IF Hl(M) = Rel(R) THEN HH(M) = -1
       IF Hl(M) = Rwl(R) THEN HH(M) = -1
       IF Hl(M) = Rsl(R) THEN HH(M) = -1
       IF Hl(M) = Rul(R) THEN HH(M) = -1
       IF Hl(M) = Rdl(R) THEN HH(M) = -1
       IF Hl(M) = Rol(R) THEN HH(M) = -1
     NEXT M
RETURN

Entrap.hostilities:
     FOR M = 1 TO HOS
       IF Hl(M) = R THEN Hm(M) = 1
       IF Hl(M) = Rnl(R) THEN Hm(M) = 1
       IF Hl(M) = Rel(R) THEN Hm(M) = 1
       IF Hl(M) = Rwl(R) THEN Hm(M) = 1
       IF Hl(M) = Rsl(R) THEN Hm(M) = 1
       IF Hl(M) = Rul(R) THEN Hm(M) = 1
       IF Hl(M) = Rdl(R) THEN Hm(M) = 1
       IF Hl(M) = Rol(R) THEN Hm(M) = 1
     NEXT M
RETURN

Lock.exits:
     IF Rn(R) = 2 THEN Rn(R) = 3
     IF Re(R) = 2 THEN Re(R) = 3
     IF Rw(R) = 2 THEN Rw(R) = 3
     IF Rs(R) = 2 THEN Rs(R) = 3
RETURN

Search.For.Components:
     P$ = MID$(a$, 3)
     B$ = ""
     a = 1
     B = -1
     t1 = 1
     FOR N = 1 TO OBJ
       IF Ot(N) = 33 THEN GOSUB Make.object
     NEXT N
RETURN

Make.object:
     B = N
     B$ = ""
     DO
       P = OV(B)
       IF OL(B) > 0 THEN t1 = 0
       B$ = B$ + CHR$(B)
       IF P > 0 THEN
         a = a + 1
         B = P
       END IF
     LOOP UNTIL P = 0
     P = OV2(B)
     IF INSTR(1, P$, ON$(M)) OR INSTR(1, ON$(M), P$) THEN
       IF t1 = 1 THEN
         PRINT "Ok, made "; LCASE$(ON$(P)); ". "
         PR = 0
         IF P < 1000 THEN
           OL(P) = R
         ELSE
           Ro(R) = (Ro(R) = 8)
         END IF
         FOR M = 1 TO a
           OL(ASC(MID$(B$, M, 1))) = -1
           Oc = Oc - 1
         NEXT M
       ELSE
        PRINT "Don't have everything to make "; LCASE$(ON$(P)); ". "
       END IF
     END IF
RETURN

Blow.open.exit:
     P$ = MID$(a$, 3)
     FOR N = 1 TO OBJ
       IF OL(N) = 0 AND (Ot(N) = 7 OR Ot(N) = 8) AND INSTR(1, ON$(N), P$) > 0 THEN
         GOSUB Open.other.exit
       END IF
     NEXT N
RETURN

Open.other.exit:
     IF (OL(OV(N)) = 0 OR OV(N) = 0) AND Ro(R) = 4 THEN
       Ro(R) = 1
       PR = 0
     END IF
RETURN

Break.object:
     M = 1
     WHILE M < OBJ AND Ot(M) <> 27
       M = M + 1
     WEND
     IF Ot(M) = 27 THEN
       FOR N = 1 TO OBJ
         IF OL(N) = R AND Ot(N) = 26 THEN
           IF OV(N) > 1 THEN
             GOSUB Reveal
           END IF
         ELSE
           IF Ot(N) = 25 AND OL(N) = 0 THEN
             OL(OV(N)) = 0
             OL(N) = -1
           END IF
         END IF
       NEXT N
     ELSE
       PRINT "Need something to break it."
     END IF
RETURN

Fight.hostility:
     IF H > 0 AND (Ht(H) < 13 OR Ht(H) = 15) THEN
       IF LEN(a$) > 2 THEN
         P$ = MID$(a$, 3)
         Hd = 0
         FOR N = 1 TO OBJ
           t1 = OV2(N)
           IF OL(N) = 0 AND Ot(N) = 3 THEN
             IF t1 > OBJ OR t1 = 0 THEN
               t1 = N
             END IF
             IF INSTR(1, ON$(N), P$) > 0 OR INSTR(1, ON$(t1), P$) > 0 THEN
               IF OV2(N) = 0 THEN
                 Hd = OV(N)
               END IF
               IF OV2(N) > 0 AND OV2(N) < 500 THEN
                 IF OV(OV2(N)) > 0 AND OL(OV2(N)) = 0 THEN
                   OV(OV2(N)) = OV(OV2(N)) - 1
                   Hd = OV(N)
                 END IF
                 IF OV(OV2(N)) <= 0 AND OL(OV2(N)) = 0 THEN
                   Hd = 0
                   PRINT "You are out of "; ON$(OV2(N)); ". "
                 END IF
               END IF
               IF OV2(N) = 500 THEN
                 IF MID$(a$, 1, 2) = "K1" THEN
                 OL(N) = R
                 Hd = OV(N)
                 ELSE
                 PRINT "It must be thrown."
                 END IF
               END IF
               IF OV2(N) = 510 THEN
                 Hd = OV(N)
                 OL(N) = -1
               END IF
               IF Ht(H) = 12 AND Ot(N) = HH(H) THEN
                 HH(H) = 0
                 Hd = 1
               ELSE
                 IF Ht(H) = 0 THEN
                   Hd = 0
                 END IF
               END IF
             END IF
           ELSE
             IF P$ = ON$(N) THEN
               IF (Ot(N) < 3 OR Ot(N) > 4) AND OL(N) = 0 THEN
                 PRINT "It is not a weapon."
               END IF
               IF OL(N) > 0 THEN
                 PRINT "It is not in your inventory."
               END IF
             END IF
           END IF
         NEXT N
       END IF
       IF LEFT$(a$, 2) = "K2" THEN
         Hd = S26
       END IF
       IF LEFT$(a$, 2) = "K3" THEN
         Hd = S25
       END IF
       IF Hd > 0 THEN
         HH(H) = HH(H) - Hd
         IF HH(H) >= 0 THEN
           a$ = "You just damaged the " + Hn$(H) + " by " + STR$(Hd) + " hitpoints."
           ADJ = 1
           GOSUB Display
         ELSE
           PRINT "You killed the "; Hn$(H); ". "
           IF Ht(H) = 6 AND HS(H) > 0 THEN
             PRINT "Found "; ON$(HS(H)); ". "
             OL(HS(H)) = R
             HS(H) = 0
           END IF
           GOSUB Search.dead.inventory
           Ht(H) = Ht(H) OR 128
           Hm(H) = Hm(H) OR 128
           H = 0
           IF S19 THEN
             PRINT "You have been awarded "; S19; " "; CU$; ". "
             C = C + S19
           END IF
         END IF
       END IF
     ELSE
       IF H = 0 THEN
         PRINT "There is nothing here."
       END IF
       IF Ht(H) > 12 AND Ht(H) < 15 THEN
         PRINT "You caused no damage."
       END IF
     END IF
RETURN

Search.dead.inventory:
     FOR N = 1 TO OBJ
       IF OL(N) > 1999 THEN
         IF OL(N) - 2000 = H THEN
           OL(N) = 0
           PRINT "Now found the "; ON$(N); ". "
         END IF
       END IF
     NEXT N
RETURN

Hostility.attacks:
     a$ = "NO ATTACK "
     IF Ht(H) = 1 OR Ht(H) = 12 OR Ht(H) = 13 THEN
       IF S21 = 0 THEN P! = ((100 - ARMR) / 100) * HS(H)
       IF S21 > 0 THEN P! = (1 - ARMR / (50 + ARMR)) * HS(H)
       P! = INT(((.5 + P!) * 100) / 100)
       SP! = SP! - INT(P!)
       IF SP! > 0 THEN
         a$ = "The " + Hn$(H) + " attacked, and lost " + STR$(P!) + C$ + ". "
       END IF
     END IF
     IF Ht(H) = 2 OR SP! < 0 THEN
       DEAD = 1
       a$ = "The " + Hn$(H) + " killed you."
       IF PR > 0 THEN R = PR
     END IF
     IF Ht(H) = 3 OR Ht(H) = 4 OR Ht(H) = 5 THEN
       FOR N = 1 TO OBJ
         IF OL(N) = 0 THEN
           IF Ht(H) = 3 THEN
             OL(N) = R
           END IF
           IF Ht(H) = 4 AND Ot(N) = 1 THEN
             OL(N) = R
             a$ = "The " + Hn$(H) + " attacked and you lost all treasures."
           END IF
           IF Ht(H) = 5 AND Ot(N) = 2 THEN
             OL(N) = R
             a$ = "The " + Hn$(H) + " attacked and you lost all keys."
           END IF
           IF Ht(H) = 15 AND Ot(N) = 3 OR Ot(N) = 4 THEN
             OL(N) = R
             a$ = "The " + Hn$(H) + " attacked and you lost all weapons."
           END IF
         END IF
       NEXT N
     END IF
     IF Ht(H) = 9 THEN
       R = HS(H)
     END IF
     IF Ht(H) = 10 AND C > HS(H) THEN
       C = C - HS(H)
       a$ = "The " + Hn$(H) + " just took " + STR$(HS(H)) + " " + CU$ + ". "
     END IF
     IF Ht(H) = 16 THEN
       a$ = "The " + Hn$(H) + " just bit you. The wounds are infected."
       Inf = HS(H)
     END IF
     IF Ht(H) = 17 THEN
       a$ = "The " + Hn$(H) + " just bit you and injected poison."
       Psn = HS(H)
     END IF
     IF a$ <> "NO ATTACK " THEN
       ADJ = 1
       GOSUB Display
     END IF
RETURN

Move.hostilities:
     IF S11 = 1 THEN
       FOR N = 1 TO HOS
         IF HH(N) >= 0 THEN
           GOSUB Random.place
         END IF
         IF Ht(N) = 6 THEN
           GOSUB Move.objects.around
         END IF
         IF Ht(N) = 11 THEN
           GOSUB Heal.hostility
         END IF
         IF Hl(N) = R THEN
           GOSUB Hostility.present
         END IF
       NEXT N
     END IF
     IF S11 = 2 THEN
       FOR N = 1 TO HOS
         IF HH(N) >= 0 THEN
           GOSUB Random.place
         END IF
         IF Ht(N) = 6 THEN
           GOSUB Move.objects.around
         END IF
         IF Ht(N) = 11 THEN
           GOSUB Heal.hostility
         END IF
         IF Hl(N) = R THEN
           GOSUB Hostility.present
         END IF
       NEXT N
     END IF
     IF S11 = 3 THEN
       FOR N = 1 TO HOS
         SELECT CASE Hm(N)
           CASE IS = 2
             GOSUB Random.place
           CASE IS = 3
             B = INT(RND * 7)
             GOSUB Move.place
           CASE IS = 4
             GOSUB Inc.place.number
           CASE IS = 5
             B = INT(RND * 4)
             GOSUB Move.place
           CASE IS = 6
             GOSUB Random.place
           CASE IS = 7
             GOSUB Dec.place.number
           CASE IS = 8
             GOSUB Persue.player
           END SELECT
         IF Ht(N) = 6 THEN
           GOSUB Move.objects.around
         ELSEIF Ht(N) = 11 THEN
           GOSUB Heal.hostility
         END IF
         IF Hl(N) = R THEN GOSUB Hostility.present
       NEXT N
     END IF
RETURN

Move.place:
     a = Hl(N)
     IF B = 0 AND Rn(a) = 1 OR Rn(a) = 2 OR Rn(a) = 4 THEN Hl(N) = Rnl(a)
     IF B = 1 AND Re(a) = 1 OR Re(a) = 2 OR Re(a) = 4 THEN Hl(N) = Rel(a)
     IF B = 2 AND Rw(a) = 1 OR Rw(a) = 2 OR Rw(a) = 4 THEN Hl(N) = Rwl(a)
     IF B = 3 AND Rs(a) = 1 OR Rs(a) = 2 OR Rs(a) = 4 THEN Hl(N) = Rsl(a)
     IF B = 4 AND Ru(a) = 1 OR Ru(a) = 2 OR Ru(a) = 4 THEN Hl(N) = Rul(a)
     IF B = 5 AND Rd(a) = 1 OR Rd(a) = 2 OR Rd(a) = 4 THEN Hl(N) = Rdl(a)
     IF B = 6 AND Ro(a) = 1 OR Ro(a) = 3 THEN Hl(N) = Rol(a)
     M = RT(Hl(N))
     IF M > 1 AND M < 4 OR M > 6 AND M < 11 OR M > 14 THEN Hl(N) = a
RETURN

Random.place:
     a = INT(RND * Plc) + 1
     M = RT(a)
     IF (M > 1 AND M < 4 OR M > 6 AND M < 11 OR M > 14) AND Hm(N) = 2 THEN
       Hl(N) = a
     END IF
     IF M <> 2 AND M <> 8 AND Hm(N) = 6 THEN
       Hl(N) = a
     END IF
RETURN

Inc.place.number:
     DO
       Hl(N) = Hl(N) + 1
       IF Hl(N) > Plc THEN Hl(N) = 1
       M = RT(Hl(N))
     LOOP UNTIL M = 1 OR M = 4 OR M = 5 OR M = 6 OR M > 10
RETURN

Dec.place.number:
     DO
       Hl(N) = Hl(N) - 1
       IF Hl(N) < 1 THEN Hl(N) = Plc
       M = RT(Hl(N))
     LOOP UNTIL M = 1 OR M = 4 OR M = 5 OR M = 6 OR M > 10
RETURN

Persue.player:
     a = Hl(N)
     SELECT CASE R
       CASE IS = Rnl(a)
         Hl(N) = Rnl(N)
       CASE IS = Rel(a)
         Hl(N) = Rel(N)
       CASE IS = Rwl(a)
         Hl(N) = Rwl(N)
       CASE IS = Rsl(a)
         Hl(N) = Rsl(N)
       CASE IS = Rul(a)
         Hl(N) = Rul(N)
       CASE IS = Rdl(a)
         Hl(N) = Rdl(N)
       CASE IS = Rol(a)
         Hl(N) = Rol(N)
       CASE ELSE
         B = INT(RND * 7)
         GOSUB Move.place
     END SELECT
     IF M > 1 AND M < 4 OR M > 6 AND M < 11 OR M > 14 THEN Hl(N) = a
RETURN

Move.objects.around:
     M = 1 + INT(RND * 2)
     IF HS(N) > 0 AND M = 1 THEN
       OL(HS(N)) = Hl(N)
       HS(N) = 0
     ELSE
       IF HS(N) = 0 THEN
         WHILE M < OBJ AND NOT OL(M) = Hl(N)
           M = M + 1 + INT(RND(3))
         WEND
         IF OL(M) = Hl(N) AND Ot(M) <> 23 AND Ot(M) <> 24 AND Ot(M) <> 26 THEN
           OL(M) = 1000
           HS(N) = M
         END IF
       END IF
     END IF
RETURN

Heal.hostility:
     a = Hl(N)
     M = 1 + INT(RND * 2)
     WHILE M < HOS
       IF Hl(M) = a AND HH(M) < 0 AND (Ht(H) < 12 OR Ht(M) > 14) THEN
         IF S23 > 0 THEN HH(M) = S23
         IF S23 < 0 THEN HH(M) = HO(M)
         Ht(M) = Ht(M) AND 127
         Hm(M) = Hm(M) AND 127
       END IF
       M = M + INT(RND * 3)
     WEND
RETURN

Answer.riddle:
     GOSUB Place.Info
     PRINT "Enter Answer."
     INPUT a$
     IF INSTR(1, R$, a$) THEN
       IF Rn(R) = 1 THEN
         R = Rnl(R)
       ELSE
         IF Rn(R) = 2 THEN
           SP! = SP! + Rnl(R)
         END IF
         IF Rn(R) = 3 THEN
           C = C + Rnl(R)
         END IF
         IF Rn(R) = 4 THEN
           TN = TN + Rnl(R)
         END IF
         IF Rn(R) = 5 THEN
           FW = FW + Rnl(R)
         END IF
         IF Rn(R) = 6 THEN
           LIVES = LIVES + Rnl(R)
         END IF
         R = Rol(R)
       END IF
     ELSE
       IF Rw(R) = 1 THEN
         R = Rwl(R)
       ELSE
         IF Rw(R) = 2 THEN
           SP! = SP! - Rwl(R)
           IF SP! < 0 THEN
             SP! = 0
           END IF
         END IF
         IF Rw(R) = 3 THEN
           C = C - Rwl(R)
           IF C < 0 THEN
             C = 0
           END IF
         END IF
         IF Rw(R) = 4 THEN
           TN = TN - Rwl(R)
         END IF
         IF Rw(R) = 5 THEN
           FW = FW - Rwl(R)
           IF FW < 3 THEN
             FW = 3
           END IF
         END IF
         IF Rw(R) = 6 THEN
           DEAD = 1
         END IF
         R = Rol(R)
       END IF
     END IF
RETURN

Measure.armor:
  IF S21 < 3 THEN
    ARMR = 0
    FOR M = 1 TO OBJ
      IF Ot(M) = 6 AND OL(M) = 0 THEN
        IF ARMR < OV(M) AND (S21 = 0 OR S21 = 2) THEN ARMR = OV(M)
        IF S21 = 1 THEN ARMR = ARMR + OV(M)
        IF ARMR > 99 THEN ARMR = 99
      END IF
    NEXT M
  ELSEIF S21 = 3 THEN
    ARMR = 0
    FOR M = 46 TO 53
      P = 0
      FOR O = 1 TO OBJ
        IF Ot(O) = M AND P < OV(M) THEN P = OV(M)
      NEXT O
      ARMR = ARMR + P
      IF ARMR > 99 THEN ARMR = 99
    NEXT M
  END IF
RETURN

Transport:
     P$ = MID$(a$, 3, LEN(a$))
     MID$(a$, 16) = " "
     FOR N = 1 TO Plc
       IF INSTR(0, P$, Rd$) > 0 AND RT(N) = 13 THEN
         R = N
       END IF
     NEXT N
RETURN

Get.game:
     CLS
     PRINT "                       TEXT ADVENTURE GAME PLAYER          IBM PC Version 1.00"
     PRINT "                            BY PETER J. MEYER"
     GOSUB Load.file
     ON ERROR GOTO 0
     a$ = OP$
     Oc = 0
     CLS
     IF LEFT$(T$, 1) <> "|" THEN
       PRINT TAB(40 - LEN(T$) / 2); T$
     ELSE
       a$ = MID$(T$, 2)
       LOADPICTURE a$
     END IF
     IF I$ <> "" THEN
       PRINT TAB(39); "By"
       PRINT TAB(40 - LEN(I$) / 2); I$
     END IF
     PRINT
     a$ = OP$
     ADJ = 2
     GOSUB Display
     PRINT
     PRINT "Press any key to begin program.";
     WHILE INKEY$ = ""
     WEND
     SCREEN 0, 0, 0
     IF S18 = 0 OR S8 > 0 THEN
       C$ = " shield points"
     END IF
     IF S18 = 1 THEN
       C$ = " health points"
     END IF
     IF S18 = 2 THEN
       C$ = " hit points"
     END IF
     IF S18 = 3 THEN
       C$ = " life points"
     END IF
     FOR N = 1 TO OBJ
       IF OL(N) = 0 THEN
         Oc = Oc + 1
       END IF
     NEXT N
     IF S15 > 0 THEN
       LIVES = S15
     ELSE
       LIVES = 1
     END IF
     IF S23 < 0 THEN
       REDIM HO(HOS)
       FOR N = 1 TO HOS
         HO(N) = HH(N)
       NEXT N
     END IF
     C = S22
     SP! = S8
     Imm = 0
     Psn = 0
     Inf = 0
     FW = S13
     R = 1
     DEAD = 0
     WIN = 0
     IF S28 = 0 THEN
        RANDOMIZE TIMER
     ELSE
        RANDOMIZE S28
     END IF
RETURN

Game.over:
     IF WIN = 1 THEN
       MID$(a$, 640) = " "
       a$ = CP$
       Oc = 0
       PRINT " ";
       ADJ = 2
       GOSUB Display
       PRINT
       PRINT "GAME SOLVED."
     ELSE
       PRINT "GAME OVER."
     END IF
     PRINT "(P)lay other, (M)ain menu, or (Q)uit."
     CHOICE = 0
     WHILE CHOICE <> 77 AND CHOICE <> 80 AND CHOICE <> 81
       a$ = INKEY$
       IF LEN(a$) = 1 THEN CHOICE = ASC(a$)
     WEND
RETURN

Load.file:
  GOSUB Get.directory
  GOSUB Get.file.name
  OPEN F$ FOR INPUT AS #1
  INPUT #1, a
  OP$ = INPUT$(a, 1)
  INPUT #1, a
  CP$ = INPUT$(a, 1)
  LINE INPUT #1, T$
  LINE INPUT #1, I$
  LINE INPUT #1, Nf$
  LINE INPUT #1, CU$
  LINE INPUT #1, a$
  INPUT #1, S0
  INPUT #1, WinPlace
  INPUT #1, WinItem01
  INPUT #1, WinItem02
  INPUT #1, WinItem03
  INPUT #1, S5
  INPUT #1, S6
  INPUT #1, WinItem04
  INPUT #1, S8
  INPUT #1, S9
  INPUT #1, S10
  INPUT #1, S11
  INPUT #1, S12
  INPUT #1, S13
  INPUT #1, S14
  INPUT #1, S15
  INPUT #1, S16
  INPUT #1, S17
  INPUT #1, S18
  INPUT #1, S19
  INPUT #1, S20
  INPUT #1, S21
  INPUT #1, S22
  INPUT #1, S23
  INPUT #1, S24
  INPUT #1, S25
  INPUT #1, S26
  INPUT #1, S27
  INPUT #1, S28
  INPUT #1, S29
  INPUT #1, S30
  INPUT #1, S31
  INPUT #1, S32
  INPUT #1, S33
  INPUT #1, S34
  INPUT #1, S35
  INPUT #1, S36
  INPUT #1, S37
  INPUT #1, S38
  INPUT #1, S39
  INPUT #1, S40
  INPUT #1, S41
  INPUT #1, S42
  INPUT #1, S43
  INPUT #1, S44
  INPUT #1, S45
  INPUT #1, S46
  INPUT #1, S47
  INPUT #1, Pwd
  FOR N = 0 TO Pwd
   INPUT #1, PW$(N)
  NEXT N
  INPUT #1, OBJ
  FOR N = 1 TO OBJ
   INPUT #1, Ot(N)
   INPUT #1, OP(N)
   INPUT #1, OL(N)
   INPUT #1, OV(N)
   INPUT #1, OV2(N)
   INPUT #1, OV3(N)
   INPUT #1, ON$(N)
   LINE INPUT #1, Od$(N)
  NEXT N
  INPUT #1, HOS
  FOR N = 1 TO HOS
   INPUT #1, Hl(N)
   INPUT #1, Ht(N)
   INPUT #1, HS(N)
   INPUT #1, HH(N)
   INPUT #1, Hv(N)
   INPUT #1, Hm(N)
   LINE INPUT #1, Hn$(N)
  NEXT N
   INPUT #1, Plc
   FOR N = 1 TO Plc
   INPUT #1, RT(N)
   INPUT #1, Rn(N)
   INPUT #1, Rnl(N)
   INPUT #1, Rnk(N)
   INPUT #1, Rw(N)
   INPUT #1, Rwl(N)
   INPUT #1, Rwk(N)
   INPUT #1, Re(N)
   INPUT #1, Rel(N)
   INPUT #1, Rek(N)
   INPUT #1, Rs(N)
   INPUT #1, Rsl(N)
   INPUT #1, Rsk(N)
   INPUT #1, Ru(N)
   INPUT #1, Rul(N)
   INPUT #1, Rd(N)
   INPUT #1, Rdl(N)
   INPUT #1, Ro(N)
   INPUT #1, Rol(N)
   LINE INPUT #1, REN$(N)
   INPUT #1, Rov(N)
   LINE INPUT #1, Rd$(N)
  NEXT N
  CLOSE #1
  Modified = 0
RETURN

Get.directory:
  ON ERROR GOTO CHECK.ERROR
  CHDIR PATH$
  FILES "*.TGF"
  ON ERROR GOTO 0
RETURN

CHECK.ERROR:
  ON ERROR GOTO CHECK.ERROR
RESUME NEXT

Get.file.name:
  INPUT "Name of File:", a$
  a$ = UCASE$(a$)
  IF INSTR(1, a$, ".TGF") = 0 THEN a$ = a$ + ".TGF"
  F$ = a$
RETURN

SUB LOADPICTURE (F$)
  IF INSTR(1, F$, ".") = 0 THEN F$ = F$ + ".GRF"
  OPEN F$ FOR INPUT AS #1
  INPUT #1, a
  INPUT #1, PCOL
  INPUT #1, HIGHT
  INPUT #1, a
  SETSCREEN
  FOR N = 1 TO HIGHT
    LINE INPUT #1, a$
    O = VX + 1
    FOR M = 1 TO LEN(a$)
      P = ASC(MID$(a$, M, 1))
      TR = INT(P / 16)
      LINE (O, N)-(O + TR - 1, N), P AND 15
      O = O + TR
    NEXT M
  NEXT N
  CLOSE #1
  LOCATE VY, 1
END SUB

SUB SETSCREEN
  VX = 0
  VY = 0
  CHRWIDTH = 8
  IF ADAPTER = 1 THEN
    SCREEN 3
    NCOL = 1
    VX = 40
    MAXHIGHT = 348
    CHRHIGHT = 14
    CHRWIDTH = 9
  END IF
  IF ADAPTER > 1 AND PCOL = 0 THEN
    SCREEN 2
    NCOL = 1
    MAXHIGHT = 200
    CHRHIGHT = 8
  END IF
  IF ADAPTER = 3 AND PCOL = 1 THEN
    SCREEN 9
    NCOL = 15
    MAXHIGHT = 350
    CHRHIGHT = 14
  END IF
  IF ADPATER = 4 AND PCOL = 1 THEN
    SCREEN 12
    NCOL = 15
    MAXHIGHT = 480
    CHRHIGHT = 16
  END IF
  VY = INT(HIGHT / CHRHIGHT) + 1
END SUB

