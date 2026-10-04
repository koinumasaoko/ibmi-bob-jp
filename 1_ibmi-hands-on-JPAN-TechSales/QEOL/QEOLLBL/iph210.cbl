      *%METADATA                                                       *
      * %TEXT EOL/400対話型（２）実習問題１解答例                                    *
      *%EMETADATA                                                      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID.      IPH210.
      *
      * 得意先照会プログラム
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WS-FILE
                  ASSIGN TO WORKSTATION-IPH210S-SI
                  ORGANIZATION IS TRANSACTION
                  ACCESS MODE IS DYNAMIC
                  RELATIVE KEY IS RRN.
           SELECT DB-FILE
                  ASSIGN TO DATABASE-TOKMSL02
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS SEQUENTIAL
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.
      *
       DATA DIVISION.
       FILE SECTION.
       FD  WS-FILE.
       01  WS-REC.
           COPY DDS-ALL-FORMATS OF IPH210S.
      *
       FD  DB-FILE.
       01  DB-REC.
           COPY DDS-ALL-FORMATS OF TOKMSL02.
      *
       WORKING-STORAGE SECTION.
       77  IN-ON                       PIC 1 VALUE B"1".
       77  IN-OFF                      PIC 1 VALUE B"0".
       77  JOB-END                     PIC 1.
       77  EOFSW                       PIC X.
       77  W-TANS                      PIC X(5).
       01  RRN                         PIC 9(2).
             88  SFL-FULL              VALUE 20.
       01  WS-FILE-INDICS.
           COPY DDS-ALL-FORMATS-INDIC OF IPH210S.
      *
       PROCEDURE DIVISION.
       PROC-S.
           OPEN I-O WS-FILE
                INPUT DB-FILE.
           MOVE IN-OFF TO JOB-END.
           MOVE IN-OFF TO IN41.
           MOVE IN-OFF TO IN42.
           MOVE SPACE  TO C1TANS OF PANEL90-O.
           PERFORM MAIN THRU MAIN-EXIT UNTIL JOB-END IS EQUAL TO IN-ON.
           CLOSE WS-FILE
                 DB-FILE.
           GOBACK.
      *
       MAIN.
           WRITE WS-REC FORMAT IS "PANEL90"
                        INDICATORS ARE PANEL90-O-INDIC.
           READ WS-FILE RECORD
                        INDICATORS ARE PANEL90-I-INDIC.
           IF IN03 OF PANEL90-I-INDIC IS EQUAL TO IN-ON
             THEN
               MOVE IN-ON TO JOB-END
               GO TO MAIN-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE C1TANS OF PANEL90-I TO W-TANS.
           MOVE IN-OFF TO IN30.
           PERFORM SUBSET THRU SUBSET-EXIT.
           IF IN30 IS EQUAL TO IN-ON
             THEN
               GO TO MAIN-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE W-TANS TO C1TANS OF PANEL90-O.
           WRITE WS-REC FORMAT IS "PANEL90"
                        INDICATORS ARE PANEL90-O-INDIC.
           MOVE IN-ON TO IN08.
           PERFORM ROUTINE THRU ROUTINE-EXIT
                   UNTIL IN08 IS EQUAL TO IN-OFF
                   OR    IN03 OF PANEL90-I-INDIC IS EQUAL TO IN-ON.
           IF IN03 OF PANEL90-I-INDIC IS EQUAL TO IN-ON
             THEN
               MOVE IN-ON TO JOB-END
               GO TO MAIN-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE IN-ON TO IN42.
           WRITE WS-REC FORMAT IS "PANEL90"
                        INDICATORS ARE PANEL90-O-INDIC.
           MOVE IN-OFF TO IN42.
           MOVE IN-ON TO IN41.
           MOVE W-TANS TO C1TANS OF PANEL90-O.
      *
       MAIN-EXIT.
           EXIT.
      *
       ROUTINE.
           MOVE IN-OFF TO IN08.
           MOVE IN-ON TO IN42.
           WRITE WS-REC FORMAT IS "PANEL90"
                        INDICATORS ARE PANEL90-O-INDIC.
           MOVE IN-OFF TO IN42.
           MOVE ZERO TO RRN.
           MOVE "0" TO EOFSW.
      *
           PERFORM SUBREAD THRU SUBREAD-EXIT
                           UNTIL EOFSW IS EQUAL TO "1"
                           OR    SFL-FULL.
           PERFORM SUBDISP THRU SUBDISP-EXIT.
      *
           IF IN08 IS EQUAL TO IN-ON
             THEN
               IF EOFSW IS EQUAL TO "1"
                 THEN
                   MOVE IN-OFF TO IN08
                   MOVE IN-ON TO IN42
                   WRITE WS-REC FORMAT IS "PANEL90"
                                INDICATORS ARE PANEL90-O-INDIC
                   MOVE IN-OFF TO IN42
                   MOVE ZERO TO RRN
                   MOVE "0" TO EOFSW
                   ADD 1 TO RRN
                   MOVE "無し" TO S1NAKN OF PANEL80-O
                   MOVE IN-ON TO IN31
                   WRITE SUBFILE WS-REC FORMAT IS "PANEL80"
                                 INDICATORS ARE PANEL80-O-INDIC
                   MOVE IN-OFF TO IN31
                   PERFORM SUBDISP THRU SUBDISP-EXIT
                   MOVE IN-OFF TO IN08
                 ELSE
                   NEXT SENTENCE
             ELSE
               NEXT SENTENCE.
      *
       ROUTINE-EXIT.
           EXIT.
      *
       SUBSET.
           MOVE SPACE TO TKNAKN.
           MOVE W-TANS TO TKNAKN.
           START DB-FILE KEY IS NOT LESS THAN TKNAKN
                         INVALID KEY MOVE IN-ON TO IN30
                         MOVE W-TANS TO C1TANS OF PANEL90-O.
      *
       SUBSET-EXIT.
           EXIT.
      *
       SUBREAD.
           READ DB-FILE RECORD
                        AT END MOVE "1" TO EOFSW.
           IF EOFSW IS EQUAL TO "0"
             THEN
               ADD 1 TO RRN
               MOVE TKBANG TO S1BANG OF PANEL80-O
               MOVE TKNAKN TO S1NAKN OF PANEL80-O
               MOVE TKADR1 TO S1ADR1 OF PANEL80-O
               MOVE TKADR2 TO S1ADR2 OF PANEL80-O
               MOVE TKGEND TO S1GEND OF PANEL80-O
               MOVE TKUZAN TO S1UZAN OF PANEL80-O
               MOVE IN-OFF TO IN31
               WRITE SUBFILE WS-REC FORMAT IS "PANEL80"
                                    INDICATORS ARE PANEL80-O-INDIC
             ELSE
               NEXT SENTENCE.
      *
       SUBREAD-EXIT.
           EXIT.
      *
       SUBDISP.
           MOVE W-TANS TO C1TANS OF PANEL90-O.
           MOVE IN-ON TO IN41.
           WRITE WS-REC FORMAT IS "PANEL90"
                        INDICATORS ARE PANEL90-O-INDIC.
           READ WS-FILE RECORD
                        INDICATORS ARE PANEL90-I-INDIC.
           MOVE IN-OFF TO IN41.
      *
       SUBDISP-EXIT.
           EXIT.
