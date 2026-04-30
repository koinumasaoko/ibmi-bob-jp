      *%METADATA                                                       *
      * %TEXT EOL/400バッチ実習問題１解答例                                       *
      *%EMETADATA                                                      *
     H**********************************************************************
     H*BPL010品目マスター一覧表の印刷
     H**********************************************************************
     H  DATEDIT(*YMD)
     H**********************************************************************
     FHINMSP    IF   E           K DISK
     FBPL010P   O    E             PRINTER OFLIND(*IN80)
     C**********************************************************************
     C** MAIN ROUTINE
     C**********************************************************************
     C*見出し印刷
     C                   WRITE     ¥HED
     C                   DOU       *IN99 = *ON
     C*品目マスターの読み込み
     C                   READ      HINMSP                                 99
     C                   IF        *IN99 = *OFF
     C*オーバーフロー処理
     C                   IF        *IN80 = *ON
     C                   WRITE     ¥HED
     C                   EVAL      *IN80 = *OFF
     C                   ENDIF
     C*明細の印刷
     C                   WRITE     ¥DTL
     C                   ENDIF
     C                   ENDDO
     C*終了処理
     C                   EVAL      *INLR = *ON
     C                   RETURN
