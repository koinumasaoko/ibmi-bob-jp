      *%METADATA                                                       *
      * %TEXT 得意先照会（ＣＯＢＯＬ）                                             *
      *%EMETADATA                                                      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID.      IPH110.
      *
      *
      * 得意先照会プログラム
      *
      *
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WS-FILE
                  ASSIGN TO WORKSTATION-IPH110S-SI
                  ORGANIZATION IS TRANSACTION
                  ACCESS MODE IS DYNAMIC
                  RELATIVE KEY IS RRN.
           SELECT DB-FILE
                  ASSIGN TO DATABASE-TOKMSL01
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS RANDOM
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.
      *
       DATA DIVISION.
       FILE SECTION.
       FD  WS-FILE.
       01  WS-REC.
           COPY DDS-ALL-FORMATS OF IPH110S.
      *
       FD  DB-FILE.
       01  DB-REC.
           COPY DDS-ALL-FORMATS OF TOKMSL01.
      *
       WORKING-STORAGE SECTION.
       77  RRN                     PIC 9 VALUE ZERO.
       77  IN-ON                   PIC 1 VALUE B"1".
       77  IN-OFF                  PIC 1 VALUE B"0".
       77  JOB-END                 PIC 1 .
       77  WSAGAKU                 PIC S9(9) COMP-3.
       01  WS-FILE-INDICS.
           COPY DDS-ALL-FORMATS-INDIC OF IPH110S.
      *
       PROCEDURE DIVISION.
       PROC-S.
           OPEN I-O WS-FILE
                INPUT DB-FILE.
           MOVE ZERO TO JOB-END.
           PERFORM MAIN THRU MAIN-EXIT UNTIL JOB-END IS EQUAL TO IN-ON.
           CLOSE WS-FILE
                 DB-FILE.
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
           MOVE S1TOKB OF PANEL01-I TO TKBANG.
           MOVE IN-OFF TO IN30.
           READ DB-FILE RECORD
                        INVALID KEY MOVE IN-ON TO IN30.
           IF IN30 IS EQUAL TO IN-OFF
             THEN
               MOVE TKBANG TO S1TOKB OF PANEL01-O
               WRITE WS-REC FORMAT "PANEL01"
                            INDICATORS ARE PANEL01-O-INDIC
               MOVE TKNAKJ TO S2NAKJ OF PANEL02-O
               MOVE TKADR1 TO S2ADR1 OF PANEL02-O
               MOVE TKADR2 TO S2ADR2 OF PANEL02-O
               MOVE TKTIKU TO S2TIKU OF PANEL02-O
               MOVE TKPOST TO S2POST OF PANEL02-O
               MOVE TKGEND TO S2GEND OF PANEL02-O
               MOVE TKUZAN TO S2UZAN OF PANEL02-O
               SUBTRACT TKUZAN FROM TKGEND GIVING WSAGAKU
               MOVE WSAGAKU TO S2GAKU OF PANEL02-O
               WRITE WS-REC FORMAT "PANEL02"
               READ WS-FILE RECORD
                            INDICATORS ARE PANEL02-I-INDIC
               IF IN03 OF PANEL02-I-INDIC IS EQUAL TO IN-ON
                 THEN
                   MOVE IN-ON TO JOB-END
                   GO TO MAIN-EXIT
                 ELSE
                   NEXT SENTENCE
             ELSE
               NEXT SENTENCE.
           MOVE TKBANG TO S1TOKB OF PANEL01-O.
      *
       MAIN-EXIT.
           EXIT.
