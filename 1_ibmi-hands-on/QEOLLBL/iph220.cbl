      *%METADATA                                                       *
      * %TEXT EOL/400対話型（２）実習問題２解答例                                    *
      *%EMETADATA                                                      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID.      IPH220.
      *
      * 売上伝票入力プログラム
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WS-FILE
                  ASSIGN TO WORKSTATION-IPH220S-SI
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
           COPY DDS-ALL-FORMATS OF IPH220S.
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
       77  RRN                         PIC 9.
       77  RECNO                       PIC 9.
       77  WC1DATE                     PIC 9(6).
       77  WC1CHUB                     PIC X(5).
       77  WC1TOKB                     PIC X(5).
       77  WC1TNKJ                     PIC X(20).
       77  WC1ADR1                     PIC X(20).
       77  WC1ADR2                     PIC X(20).
       77  WS1HINB                     PIC X(5).
       77  WS1TANK                     PIC S9(5)   COMP-3.
       77  WS1SURY                     PIC S9(7)   COMP-3.
       77  WKINGAK                     PIC S9(7)   COMP-3.
       77  GKINGAK                     PIC S9(7)   COMP-3.
       77  IN-ON                       PIC 1 VALUE B"1".
       77  IN-OFF                      PIC 1 VALUE B"0".
       77  JOB-END                     PIC 1.
       77  ERR-FLG                     PIC 1.
       01  WS-FILE-INDICS.
           COPY DDS-ALL-FORMATS-INDIC OF IPH220S.
      *
       PROCEDURE DIVISION.
       PROC-S.
           OPEN INPUT DB-FILE1 DB-FILE2
                I-O WS-FILE DB-FILE3 DB-FILE4.
           MOVE ZERO TO C1DATE OF PANEL91-O.
           MOVE ZERO TO C1CHUB OF PANEL91-O.
           MOVE IN-OFF TO IN41.
           MOVE IN-OFF TO IN42.
           MOVE IN-OFF TO IN43.
           PERFORM MAIN THRU MAIN-EXIT
                        UNTIL JOB-END IS EQUAL TO IN-ON.
           CLOSE WS-FILE
                 DB-FILE1 DB-FILE2 DB-FILE3.
           GOBACK.
      *
       MAIN.
           MOVE IN-ON TO IN20.
           PERFORM PANEL THRU PANEL-EXIT
                         UNTIL IN30 IS EQUAL TO IN-OFF
                         AND   IN31 IS EQUAL TO IN-OFF
                         AND   IN20 IS EQUAL TO IN-OFF
                         OR    JOB-END IS EQUAL TO IN-ON.
           IF JOB-END IS EQUAL TO IN-ON
             THEN
               GO TO MAIN-EXIT
             ELSE
               NEXT SENTENCE.
           WRITE WS-REC FORMAT IS "PANEL91"
                        INDICATORS ARE PANEL91-O-INDIC.
           PERFORM SUBINIT THRU SUBINIT-EXIT.
           PERFORM SUBDISP THRU SUBDISP-EXIT
                   UNTIL IN05 IS EQUAL TO IN-ON
                   OR    IN08 IS EQUAL TO IN-ON
                   OR    JOB-END IS EQUAL TO IN-ON.
           IF JOB-END IS EQUAL TO IN-ON
             THEN
               GO TO MAIN-EXIT
             ELSE
               NEXT SENTENCE.
           IF IN08 IS EQUAL TO IN-ON
             THEN
               MOVE ZERO TO RRN
               PERFORM MIDRESIST THRU MIDRESIST-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE IN-ON TO IN42.
           WRITE WS-REC FORMAT IS "PANEL91"
                        INDICATORS ARE PANEL91-O-INDIC.
           MOVE IN-OFF TO IN42.
           MOVE IN-ON TO IN41.
           MOVE WC1DATE TO C1DATE OF PANEL91-O.
           MOVE WC1CHUB TO C1CHUB OF PANEL91-O.
           MOVE WC1TOKB TO C1TOKB OF PANEL91-O.
           MOVE SPACE TO C1TNKJ OF PANEL91-O.
           MOVE SPACE TO C1ADR1 OF PANEL91-O.
           MOVE SPACE TO C1ADR2 OF PANEL91-O.
      *
       MAIN-EXIT.
           EXIT.
      *
       PANEL.
           MOVE IN-OFF TO IN20.
           WRITE WS-REC FORMAT IS "PANEL91"
                        INDICATORS ARE PANEL91-O-INDIC.
           READ WS-FILE RECORD
                        INDICATORS ARE PANEL91-I-INDIC.
           MOVE C1DATE OF PANEL91-I TO WC1DATE.
           MOVE C1CHUB OF PANEL91-I TO WC1CHUB.
           MOVE C1TOKB OF PANEL91-I TO WC1TOKB.
           MOVE IN-OFF TO IN30.
           MOVE IN-OFF TO IN31.
           IF IN03 OF PANEL91-I-INDIC IS EQUAL TO IN-ON
             THEN
               MOVE IN-ON TO JOB-END
               GO TO PANEL-EXIT
             ELSE
               NEXT SENTENCE.
           IF IN05 OF PANEL91-I-INDIC IS EQUAL TO IN-ON
             THEN
               MOVE IN-ON TO JOB-END
               GO TO PANEL-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE WC1CHUB TO JHCHUB.
           MOVE IN-ON TO IN30.
           READ DB-FILE3 RECORD
                         INVALID KEY MOVE IN-OFF TO IN30.
           MOVE WC1TOKB TO TKBANG.
           READ DB-FILE1 RECORD
                         INVALID KEY MOVE IN-ON TO IN31.
           IF IN31 IS EQUAL TO IN-OFF
             THEN
               MOVE TKNAKJ TO WC1TNKJ
               MOVE TKADR1 TO WC1ADR1
               MOVE TKADR2 TO WC1ADR2
             ELSE
               NEXT SENTENCE.
           MOVE WC1DATE TO C1DATE OF PANEL91-O.
           MOVE WC1CHUB TO C1CHUB OF PANEL91-O.
           MOVE WC1TOKB TO C1TOKB OF PANEL91-O.
           MOVE WC1TNKJ TO C1TNKJ OF PANEL91-O.
           MOVE WC1ADR1 TO C1ADR1 OF PANEL91-O.
           MOVE WC1ADR2 TO C1ADR2 OF PANEL91-O.
      *
       PANEL-EXIT.
           EXIT.
      *
       SUBINIT.
           MOVE IN-ON TO IN42.
           WRITE WS-REC FORMAT IS "PANEL91"
                        INDICATORS ARE PANEL91-O-INDIC.
           MOVE IN-OFF TO IN42.
           MOVE ZERO TO RRN.
      *
           MOVE IN-ON TO IN43.
           WRITE WS-REC FORMAT IS "PANEL91"
                        INDICATORS ARE PANEL91-O-INDIC.
           MOVE IN-OFF TO IN43.
      *
       SUBINIT-EXIT.
           EXIT.
      *
       SUBDISP.
           MOVE WC1DATE TO C1DATE OF PANEL91-O.
           MOVE WC1CHUB TO C1CHUB OF PANEL91-O.
           MOVE WC1TOKB TO C1TOKB OF PANEL91-O.
           MOVE WC1TNKJ TO C1TNKJ OF PANEL91-O.
           MOVE WC1ADR1 TO C1ADR1 OF PANEL91-O.
           MOVE WC1ADR2 TO C1ADR2 OF PANEL91-O.
           MOVE IN-ON TO IN41.
           WRITE WS-REC FORMAT IS "PANEL91"
                        INDICATORS ARE PANEL91-O-INDIC.
           READ WS-FILE RECORD
                        INDICATORS ARE PANEL91-I-INDIC.
           MOVE IN-OFF TO IN41.
           IF IN03 OF PANEL91-I-INDIC IS EQUAL TO IN-ON
             THEN
               MOVE IN-ON TO JOB-END
               GO TO SUBDISP-EXIT
             ELSE
               NEXT SENTENCE.
           IF IN05 IS EQUAL TO IN-ON
             THEN
               GO TO SUBDISP-EXIT
             ELSE
               NEXT SENTENCE.
           IF IN08 IS EQUAL TO IN-ON
             THEN
               GO TO SUBDISP-EXIT
             ELSE
               NEXT SENTENCE.
           MOVE ZERO TO GKINGAK.
           MOVE ZERO TO RECNO.
           PERFORM CHECK THRU CHECK-EXIT
                           VARYING RRN FROM 1 BY 1
                           UNTIL RRN IS GREATER THAN 5.
      *
       SUBDISP-EXIT.
           EXIT.
      *
       CHECK.
           READ SUBFILE WS-FILE RECORD FORMAT IS "PANEL81"
                        INDICATORS ARE PANEL81-I-INDIC.
           MOVE S1HINB OF PANEL81-I TO WS1HINB.
           MOVE S1SURY OF PANEL81-I TO WS1SURY.
           MOVE S1TANK OF PANEL81-I TO WS1TANK.
           IF WS1HINB IS NOT EQUAL TO SPACE
             THEN
               ADD 1 TO RECNO
               PERFORM SUBSET THRU SUBSET-EXIT
               MULTIPLY S1TANK OF PANEL81-O BY WS1SURY GIVING WKINGAK
               ADD WKINGAK  TO GKINGAK
               MOVE RRN     TO S1RRNS OF PANEL81-O
               MOVE WS1HINB TO S1HINB OF PANEL81-O
               REWRITE SUBFILE WS-REC FORMAT IS "PANEL81"
                               INVALID KEY GO TO CHECK-EXIT
             ELSE
               NEXT SENTENCE.
      *
       CHECK-EXIT.
           EXIT.
      *
       SUBSET.
           MOVE IN-OFF TO ERR-FLG.
           MOVE WS1HINB TO HNBANG.
           READ DB-FILE2 RECORD
                         INVALID KEY MOVE IN-ON TO ERR-FLG.
           IF ERR-FLG IS EQUAL TO IN-OFF
             THEN
               MOVE HNNAKJ TO S1HNKJ OF PANEL81-O
               IF WS1TANK IS EQUAL TO ZERO
                 THEN
                   MOVE HNTEIK TO S1TANK OF PANEL81-O
                 ELSE
                   MOVE WS1TANK TO S1TANK OF PANEL81-O
               MOVE WS1SURY TO S1SURY OF PANEL81-O
             ELSE
               MOVE ZERO TO S1SURY OF PANEL81-O
               MOVE ZERO TO S1TANK OF PANEL81-O
               MOVE "品番エラー" TO S1HNKJ OF PANEL81-O.
      *
       SUBSET-EXIT.
           EXIT.
      *
       MIDRESIST.
           MOVE WC1TOKB TO JHTOKB.
           MOVE WC1CHUB TO JHCHUB.
           MOVE WC1DATE TO JHDATE.
           MOVE GKINGAK TO JHKING.
           MOVE RECNO TO JHGYOS.
           WRITE DB-REC3 INVALID KEY GO TO MIDRESIST-EXIT.
           PERFORM MEIRESIST THRU MEIRESIST-EXIT
                             VARYING RRN FROM 1 BY 1
                             UNTIL RRN IS GREATER THAN 5.
      *
       MIDRESIST-EXIT.
           EXIT.
      *
       MEIRESIST.
           MOVE SPACE TO WS1HINB.
           READ SUBFILE WS-FILE RECORD FORMAT IS "PANEL81"
                                INDICATORS ARE PANEL81-I-INDIC.
           MOVE S1HINB OF PANEL81-I TO WS1HINB.
           IF WS1HINB IS NOT EQUAL TO SPACE
             THEN
               MOVE WC1TOKB TO JDTOKB
               MOVE WC1CHUB TO JDCHUB
               MOVE RRN TO JDGYOB
               MOVE WS1HINB TO JDHINB
               MOVE S1SURY OF PANEL81-I TO JDSURY
               MOVE S1TANK OF PANEL81-I TO JDUTAN
               MULTIPLY JDUTAN BY JDSURY GIVING JDKING
               WRITE DB-REC4 INVALID KEY GO TO MEIRESIST-EXIT
             ELSE
               NEXT SENTENCE.
      *
       MEIRESIST-EXIT.
           EXIT.
