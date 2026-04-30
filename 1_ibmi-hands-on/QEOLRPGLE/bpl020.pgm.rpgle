      *%METADATA                                                       *
      * %TEXT EOL/400バッチ実習問題２解答例                                       *
      *%EMETADATA                                                      *
     H**********************************************************************
     H*BPL020得意先別受注一覧表の印刷
     H**********************************************************************
     H  DATEDIT(*YMD)
     H**********************************************************************
     FJUMIDL01  IF   E           K DISK
     FTOKMSP    IF   E           K DISK
     FBPL020P   O    E             PRINTER OFLIND(*IN80)
     C**********************************************************************
     C** MAIN ROUTINE
     C**********************************************************************
     C*見出し印刷
     C                   WRITE     ¥HED
     C                   DOU       *IN99 = *ON
     C*受注見出しファイルの読み込み
     C                   READ      JUMIDL01                               99
     C                   IF        *IN99 = *OFF
     C*明細処理
     C                   EXSR      @MEISUB
     C                   ENDIF
     C                   ENDDO
     C*平均金額の計算
     C                   EVAL(H)   HEIKIN = GOKEI / KENSU
     C*合計の印刷
     C                   WRITE     ¥TTL
     C*終了処理
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C**********************************************************************
     C**明細処理                                                        **
     C**********************************************************************
     C     @MEISUB       BEGSR
     C*得意先マスターの読み込み
     C     JHTOKB        CHAIN     TOKMSP                             90
     C                   IF        *IN90 = *ON
     C                   EVAL      TKNAKJ = *ALL'*'
     C                   ENDIF
     C
     C*オーバーフロー処理
     C                   IF        *IN80 = *ON
     C                   WRITE     ¥HED
     C                   EVAL      *IN80 = *OFF
     C                   ENDIF
     C*件数と合計金額の計算
     C                   EVAL      KENSU = KENSU + 1
     C                   EVAL      GOKEI = GOKEI + JHKING
     C*明細の印刷
     C                   WRITE     ¥DTL
     C                   ENDSR
