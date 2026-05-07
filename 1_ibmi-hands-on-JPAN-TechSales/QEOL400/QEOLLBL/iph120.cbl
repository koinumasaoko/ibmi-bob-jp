      *%METADATA                                                       *
      * %TEXT EOL/400対話型（１）実習問題２解答例                                    *
      *%EMETADATA                                                      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID.      IPH120.
      *
      * 受注入力プログラム
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WS-FILE
                  ASSIGN TO WORKSTATION-IPH120S-SI
                  ORGANIZATION IS TRANSACTION
                  ACCESS MODE IS DYNAMIC
                  RELATIVE KEY IS RRN.
           SELECT DB-FILE1
                  ASSIGN TO DATABASE-TOKMSP
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS RANDOM
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.
           SELECT DB-FILE2
                  ASSIGN TO DATABASE-HINMSP
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS RANDOM
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.
           SELECT DB-FILE3
                  ASSIGN TO DATABASE-JUMIDP
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS RANDOM
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.
           SELECT DB-FILE4
                  ASSIGN TO DATABASE-JUMEIP
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS RANDOM
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.
      *
       DATA DIVISION.
       FILE SECTION.
       FD  WS-FILE.
       01  WS-REC.
           COPY DDS-ALL-FORMATS OF IPH120S.
      *
       FD  DB-FILE1.
       01  DB-REC1.
           COPY DDS-ALL-FORMATS OF TOKMSP.
       FD  DB-FILE2.
       01  DB-REC2.
           COPY DDS-ALL-FORMATS OF HINMSP.
       FD  DB-FILE3.
       01  DB-REC3.
           COPY DDS-ALL-FORMATS OF JUMIDP.
       FD  DB-FILE4.
       01  DB-REC4.
           COPY DDS-ALL-FORMATS OF JUMEIP.
      *
       WORKING-STORAGE SECTION.
       77  RRN                     PIC 9 VALUE ZERO.
       77  IN-ON                   PIC 1 VALUE B"1".
       77  IN-OFF                  PIC 1 VALUE B"0".
       77  ERR-FLG                 PIC 1.
       77  JOB-END                 PIC 1.
       77  WAKING                  PIC S9(7) COMP-3.
       77  WAGYOS                  PIC S9(3) COMP-3.
       77  WACHUB                  PIC S9(5) COMP-3.
       77  WATOKB                  PIC X(5).
       01  WS-FILE-INDICS.
           COPY DDS-ALL-FORMATS-INDIC OF IPH120S.
      *
       PROCEDURE DIVISION.
       PROC-S.
           OPEN INPUT DB-FILE1 DB-FILE2
                I-O WS-FILE DB-FILE3
                    DB-FILE4.
           MOVE IN-OFF TO ERR-FLG.
           MOVE IN-OFF TO JOB-END.
           MOVE ZERO   TO S1CHUB OF PANEL01-O.
           MOVE ZERO   TO WAGYOS.
           MOVE ZERO   TO WACHUB.
           MOVE SPACE  TO WATOKB.
           PERFORM MAIN THRU MAIN-EXIT
                   UNTIL JOB-END IS EQUAL TO IN-ON.
           CLOSE WS-FILE
                 DB-FILE1 DB-FILE2
                 DB-FILE3 DB-FILE4.
           GOBACK.
      *
       MAIN.
           WRITE WS-REC FORMAT IS "PANEL01"
                        INDICATORS ARE PANEL01-O-INDIC.
           READ WS-FILE RECORD
                        INDICATORS ARE PANEL01-I-INDIC.
           IF IN03 OF PANEL01-I-INDIC IS EQUAL TO IN-ON
             THEN
               MOVE IN-ON TO JOB-END
               GO TO MAIN-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE S1CHUB OF PANEL01-I TO WACHUB.
           MOVE WACHUB TO JHCHUB.
           MOVE IN-OFF TO IN31.
           READ DB-FILE3 RECORD
                INVALID KEY MOVE IN-ON TO ERR-FLG.
           IF ERR-FLG IS EQUAL TO IN-OFF
             THEN
               MOVE IN-ON TO IN31
               GO TO MAIN-EXIT
             ELSE
               MOVE IN-OFF TO ERR-FLG.
           MOVE S1TOKB OF PANEL01-I TO WATOKB.
           MOVE WATOKB TO TKBANG.
           MOVE IN-OFF TO IN32.
           READ DB-FILE1 RECORD
                INVALID KEY MOVE IN-ON TO IN32.
           IF IN32 IS EQUAL TO IN-OFF
             THEN
               MOVE ZERO TO S2SURY OF PANEL02-O
                            S2TEIK OF PANEL02-O
                            S2KING OF PANEL02-O
               MOVE WACHUB TO S1CHUB OF PANEL01-O
               MOVE WATOKB TO S1TOKB OF PANEL01-O
               WRITE WS-REC FORMAT IS "PANEL01"
                            INDICATORS ARE PANEL01-O-INDIC
               PERFORM DISP THRU DISP-EXIT
                            UNTIL IN01 IS EQUAL TO IN-ON
                            OR    IN02 IS EQUAL TO IN-ON
                            OR    JOB-END IS EQUAL TO IN-ON
             ELSE
               NEXT SENTENCE.
           IF IN02 IS EQUAL TO IN-ON
             THEN
               PERFORM RESIST THRU RESIST-EXIT
               MOVE IN-OFF TO IN02
             ELSE
               NEXT SENTENCE.
           IF IN01 IS EQUAL TO IN-ON
             THEN
               MOVE IN-OFF TO IN01
             ELSE
               NEXT SENTENCE.
           MOVE WACHUB TO S1CHUB OF PANEL01-O.
           MOVE WATOKB TO S1TOKB OF PANEL01-O.
      *
       MAIN-EXIT.
           EXIT.
      *
       DISP.
           MOVE TKNAKJ TO S2TNKJ OF PANEL02-O.
           MOVE TKADR1 TO S2ADR1 OF PANEL02-O.
           MOVE TKADR2 TO S2ADR2 OF PANEL02-O.
           WRITE WS-REC FORMAT IS "PANEL02"
                        INDICATORS ARE PANEL02-O-INDIC.
           READ WS-FILE RECORD
                        INDICATORS ARE PANEL02-I-INDIC.
           IF IN03 OF PANEL02-I-INDIC IS EQUAL TO IN-ON
             THEN
               MOVE IN-ON TO JOB-END
               GO TO DISP-EXIT
             ELSE
               NEXT SENTENCE.
           IF IN01 OF PANEL02-I-INDIC IS EQUAL TO IN-ON
             THEN
               GO TO DISP-EXIT
             ELSE
               NEXT SENTENCE.
           IF IN02 OF PANEL02-I-INDIC IS EQUAL TO IN-ON
             THEN
               GO TO DISP-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE S2HINB OF PANEL02-I TO HNBANG.
           MOVE IN-OFF TO IN33.
           READ DB-FILE2 RECORD
                INVALID KEY MOVE IN-ON TO IN33.
           IF IN33 IS EQUAL TO IN-OFF
             THEN
               MOVE HNNAKJ TO S2HNKJ OF PANEL02-O
               MOVE HNTEIK TO S2TEIK OF PANEL02-O
               MOVE ZERO   TO WAKING
               MULTIPLY HNTEIK BY S2SURY OF PANEL02-I
                        GIVING WAKING
               MOVE WAKING TO S2KING OF PANEL02-O
             ELSE
               NEXT SENTENCE.
           MOVE S2HINB OF PANEL02-I TO S2HINB OF PANEL02-O.
           MOVE S2SURY OF PANEL02-I TO S2SURY OF PANEL02-O.
      *
       DISP-EXIT.
           EXIT.
      *
       RESIST.
           MOVE WATOKB TO JDTOKB.
           MOVE WACHUB TO JDCHUB.
           ADD 1 TO WAGYOS GIVING JDGYOB.
           MOVE S2HINB OF PANEL02-I TO JDHINB.
           MOVE S2SURY OF PANEL02-I TO JDSURY.
           MOVE HNTEIK TO JDUTAN.
           MOVE WAKING TO JDKING.
           WRITE DB-REC4
                 INVALID KEY GO TO RESIST-EXIT.
           MOVE WATOKB TO JHTOKB.
           MOVE WACHUB TO JHCHUB.
           MOVE WAKING TO JHKING.
           ADD 1 TO WAGYOS GIVING JHGYOS.
           MOVE ZERO TO JHDATE.
           WRITE DB-REC3
                 INVALID KEY GO TO RESIST-EXIT.
      *
       RESIST-EXIT.
           EXIT.
