      *%METADATA                                                       *
      * %TEXT EOL/400バッチ・プログラム１　　　　　　　　                                *
      *%EMETADATA                                                      *
      * ---------------------------
      *   PGMID:BCH110
      *  得意先照会マスタ一覧
      *   DATE:2024/04/19
      *   AUTHOR: DEMOMASTER
      * ---------------------------

       IDENTIFICATION DIVISION.
       PROGRAM-ID.      BCH110.
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT DB-FILE ASSIGN TO DATABASE-TOKMSL03
                  ORGANIZATION IS INDEXED
                  ACCESS MODE IS SEQUENTIAL
                  RECORD KEY IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS IS FILE-STS.
           SELECT DB-LIST ASSIGN TO PRINTER.
      *
       DATA DIVISION.
       FILE SECTION.
       FD  DB-FILE.
       01  DB-REC1.
           COPY DDS-ALL-FORMATS OF TOKMSL03.

       FD  DB-LIST
           LINAGE  63
           FOOTING 60
           TOP      2
           BOTTOM   1.
       01  DB-REC2            PIC X(132).
      *
       WORKING-STORAGE SECTION.
       01  MIDASHI-1.
           03  FILLER         PIC X(9)  VALUE SPACE.
           03  FILLER         PIC X(10) VALUE "＊＊＊".
           03  FILLER         PIC X(42)
               VALUE "得　意　先　マ　ス　タ　ー　一　覧　表".
           03  FILLER         PIC X(18) VALUE "＊＊＊".
           03  FILLER         PIC X(11) VALUE "作成日".
           03  O-HIZUKE       PIC 99/99/99.
           03  FILLER         PIC X(11) VALUE SPACE.
           03  FILLER         PIC X(5)  VALUE "頁".
           03  O-PAGE         PIC ZZZ9.
           03  FILLER         PIC X(14) VALUE SPACE.

       01  MIDASHI-2.
           03  FILLER         PIC X(6)  VALUE "地区".
           03  FILLER         PIC X(13) VALUE "得意先番号".
           03  FILLER         PIC X(21) VALUE "得　意　先　名".
           03  FILLER         PIC X(21) VALUE "住　所　１".
           03  FILLER         PIC X(23) VALUE "住　所　２".
           03  FILLER         PIC X(16) VALUE "信用限度額".
           03  FILLER         PIC X(16) VALUE "売掛金残高".
           03  FILLER         PIC X(16) VALUE "利用可能額".

       01  MEISAI.
           03  FILLER         PIC X(2)  VALUE SPACE.
           03  O-TKTIKU       PIC X(2).
           03  FILLER         PIC X(5)  VALUE SPACE.
           03  O-TKBANG       PIC X(5).
           03  FILLER         PIC X(5)  VALUE SPACE.
           03  O-TKNAKJ       PIC X(20).
           03  FILLER         PIC X     VALUE SPACE.
           03  O-TKADR1       PIC X(20).
           03  FILLER         PIC X     VALUE SPACE.
           03  O-TKADR2       PIC X(20).
           03  FILLER         PIC X(2)  VALUE SPACE.
           03  O-TKGEND       PIC ----,---,--9.
           03  FILLER         PIC X(4)  VALUE SPACE.
           03  O-TKUZAN       PIC ----,---,--9.
           03  FILLER         PIC X(4)  VALUE SPACE.
           03  O-RIGEND       PIC ----,---,--9.
           03  FILLER         PIC X(5)  VALUE SPACE.

       01  FILE-STS           PIC X(2).
       77  EOFSW              PIC X.
       77  PAGE-CTR           PIC S9(4) COMP-3.
      *
       PROCEDURE DIVISION.
       MAE-JJUNBI.
           OPEN INPUT DB-FILE
                OUTPUT DB-LIST.
           MOVE ZERO TO EOFSW.
           MOVE 1 TO PAGE-CTR.
           ACCEPT O-HIZUKE FROM DATE.
           MOVE PAGE-CTR TO O-PAGE.
           MOVE SPACE TO DB-REC2.
           WRITE DB-REC2 AFTER PAGE.
           WRITE DB-REC2 FROM MIDASHI-1 AFTER 2.
           WRITE DB-REC2 FROM MIDASHI-2 AFTER 2.
           READ DB-FILE AT END MOVE "1" TO EOFSW.
           PERFORM HANPUKU-SHORI THRU HANPUKU-SHORI-EXIT
                   UNTIL EOFSW IS EQUAL TO "1".

       ATO-SHIMATSU.
           CLOSE DB-FILE
                 DB-LIST.
           GOBACK.

       HANPUKU-SHORI.
           IF LINAGE-COUNTER IS NOT LESS THAN 63
             ADD 1 TO PAGE-CTR
             MOVE PAGE-CTR TO O-PAGE
             MOVE SPACE TO DB-REC2
             WRITE DB-REC2 AFTER PAGE
             WRITE DB-REC2 FROM MIDASHI-1 AFTER 2
             WRITE DB-REC2 FROM MIDASHI-2 AFTER 2
           ELSE
             NEXT SENTENCE.
           MOVE TKTIKU TO O-TKTIKU.
           MOVE TKBANG TO O-TKBANG.
           MOVE TKNAKJ TO O-TKNAKJ.
           MOVE TKADR1 TO O-TKADR1.
           MOVE TKADR2 TO O-TKADR2.
           MOVE TKGEND TO O-TKGEND.
           MOVE TKUZAN TO O-TKUZAN.
           SUBTRACT TKUZAN FROM TKGEND GIVING O-RIGEND.
           WRITE DB-REC2 FROM MEISAI AFTER 2.
           READ DB-FILE AT END MOVE "1" TO EOFSW.

       HANPUKU-SHORI-EXIT.
           EXIT.
