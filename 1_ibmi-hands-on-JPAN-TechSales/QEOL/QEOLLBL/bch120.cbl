      *%METADATA                                                       *
      * %TEXT EOL/400バッチ・プログラム２　　　　　　　　                                *
      *%EMETADATA                                                      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID.      BCH120.
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT DB-FILE1 ASSIGN TO DATABASE-JUMIDL01
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS SEQUENTIAL
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.

           SELECT DB-FILE2 ASSIGN TO DATABASE-TOKMSP
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS DYNAMIC
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY.

           SELECT DB-LIST ASSIGN TO PRINTER.
      *
       DATA DIVISION.
       FILE SECTION.
       FD  DB-FILE1.
       01  DB-REC1.
           COPY DDS-ALL-FORMATS OF JUMIDL01.

       FD  DB-FILE2.
       01  DB-REC2.
           COPY DDS-ALL-FORMATS OF TOKMSP.

       FD  DB-LIST
           LINAGE  62
           FOOTING 60
           TOP      2
           BOTTOM   2.
       01  DB-REC3            PIC X(132).
      *
       WORKING-STORAGE SECTION.
       01  MIDASHI-1.
           03  FILLER         PIC X(19) VALUE SPACE.
           03  FILLER         PIC X(10) VALUE "＊＊＊".
           03  FILLER         PIC X(38)
               VALUE "得　意　先　別　受　注　一　覧　表".
           03  FILLER         PIC X(22) VALUE "＊＊＊".
           03  FILLER         PIC X(11) VALUE "作成日".
           03  O-HIZUKE       PIC 99/99/99.
           03  FILLER         PIC X(11) VALUE SPACE.
           03  FILLER         PIC X(5)  VALUE "頁".
           03  O-PAGE         PIC ZZZ9.
           03  FILLER         PIC X(4)  VALUE SPACE.

       01  MIDASHI-2.
           03  FILLER         PIC X     VALUE SPACE.
           03  FILLER         PIC X(9)  VALUE "得意先".
           03  FILLER         PIC X(21)
               VALUE "得　意　先　名".
           03  FILLER         PIC X(10) VALUE "受注番号".
           03  FILLER         PIC X(12) VALUE "受注日付".
           03  FILLER         PIC X(15) VALUE "信用限度額".
           03  FILLER         PIC X(17) VALUE "売掛金残高".
           03  FILLER         PIC X(13) VALUE "受注金額".
           03  FILLER         PIC X(13) VALUE "利用可能額".
           03  FILLER         PIC X(21) VALUE "コ　メ　ン　ト　欄".

       01  MIDASHI-3.
           03  FILLER         PIC X     VALUE SPACE.
           03  FILLER         PIC X(131) VALUE "番　号".

       01  MEISAI.
           03  FILLER         PIC X(2)  VALUE SPACE.
           03  O-JHTOKB       PIC X(5).
           03  FILLER         PIC X(3)  VALUE SPACE.
           03  O-TKNAKJ       PIC X(20).
           03  FILLER         PIC X(3)  VALUE SPACE.
           03  O-JHCHUB       PIC S9(5).
           03  FILLER         PIC X(4)  VALUE SPACE.
           03  O-JHDATE       PIC 99/99/99.
           03  FILLER         PIC X(2)  VALUE SPACE.
           03  O-TKGEND       PIC ----,---,--9.
           03  FILLER         PIC X(3)  VALUE SPACE.
           03  O-TKUZAN       PIC ----,---,--9.
           03  FILLER         PIC X(3)  VALUE SPACE.
           03  O-JHKING       PIC ----,---,--9.
           03  FILLER         PIC X(3)  VALUE SPACE.
           03  O-RIKANO       PIC ----,---,--9.
           03  FILLER         PIC X(2)  VALUE SPACE.
           03  O-MSG          PIC X(20).
           03  FILLER         PIC X     VALUE SPACE.

       77  EOFSW              PIC X.
       77  READ-FLG           PIC X.
       77  PAGE-CTR           PIC S9(4) COMP-3.
       77  WKINGAKU           PIC S9(9) COMP-3.
      *
       PROCEDURE DIVISION.
       MAE-JJUNBI.
           OPEN INPUT DB-FILE1
                I-O DB-FILE2
                OUTPUT DB-LIST.
           MOVE ZERO TO EOFSW.
           MOVE ZERO TO READ-FLG.
           MOVE 1 TO PAGE-CTR.
           ACCEPT O-HIZUKE FROM DATE.
           MOVE PAGE-CTR TO O-PAGE.
           MOVE SPACE TO DB-REC3.
           WRITE DB-REC3 AFTER PAGE.
           WRITE DB-REC3 FROM MIDASHI-1 AFTER 2.
           WRITE DB-REC3 FROM MIDASHI-2 AFTER 2.
           WRITE DB-REC3 FROM MIDASHI-3.
           READ DB-FILE1 AT END MOVE "1" TO EOFSW.
           PERFORM HANPUKU-SHORI THRU HANPUKU-SHORI-EXIT
                   UNTIL EOFSW IS EQUAL TO "1".

       ATO-SHIMATSU.
           CLOSE DB-FILE1
                 DB-FILE2
                 DB-LIST.
           GOBACK.

       HANPUKU-SHORI.
           IF LINAGE-COUNTER IS NOT LESS THAN 62 THEN
             ADD 1 TO PAGE-CTR
             MOVE PAGE-CTR TO O-PAGE
             MOVE SPACE TO DB-REC3
             WRITE DB-REC3 AFTER PAGE
             WRITE DB-REC3 FROM MIDASHI-1 AFTER 2
             WRITE DB-REC3 FROM MIDASHI-2 AFTER 2
             WRITE DB-REC3 FROM MIDASHI-3
           ELSE
             NEXT SENTENCE.
           MOVE JHTOKB TO TKBANG.
           READ DB-FILE2 INVALID KEY MOVE "1" TO READ-FLG.
           IF READ-FLG IS EQUAL TO ZERO THEN
             PERFORM MEISAI-SHORI THRU MEISAI-SHORI-EXIT
             ADD JHKING TO TKUZAN
             REWRITE DB-REC2 INVALID KEY MOVE "1" TO EOFSW
           ELSE
             PERFORM ERROR-SHORI THRU ERROR-SHORI-EXIT.
           MOVE ZERO TO READ-FLG.
           WRITE DB-REC3 FROM MEISAI AFTER 2.
           READ DB-FILE1 AT END MOVE "1" TO EOFSW.

       HANPUKU-SHORI-EXIT.
           EXIT.

       MEISAI-SHORI.
           MOVE JHTOKB TO O-JHTOKB.
           MOVE TKNAKJ TO O-TKNAKJ.
           MOVE JHCHUB TO O-JHCHUB.
           MOVE JHDATE TO O-JHDATE.
           MOVE TKGEND TO O-TKGEND.
           MOVE TKUZAN TO O-TKUZAN.
           MOVE JHKING TO O-JHKING.
           SUBTRACT TKUZAN JHKING FROM TKGEND GIVING WKINGAKU.
           MOVE WKINGAKU TO O-RIKANO.
           IF WKINGAKU IS LESS THAN ZERO THEN
             MOVE "信用限度オーバー" TO O-MSG
           ELSE
             MOVE SPACE TO O-MSG.

       MEISAI-SHORI-EXIT.
           EXIT.

       ERROR-SHORI.
           MOVE JHTOKB TO O-JHTOKB.
           MOVE ALL "？" TO O-TKNAKJ.
           MOVE JHCHUB TO O-JHCHUB.
           MOVE JHDATE TO O-JHDATE.
           MOVE ZERO TO O-TKGEND.
           MOVE ZERO TO O-TKUZAN.
           MOVE JHKING TO O-JHKING.
           MOVE ZERO TO O-RIKANO.
           MOVE "得意先マスターなし" TO O-MSG.

       ERROR-SHORI-EXIT.
           EXIT.
