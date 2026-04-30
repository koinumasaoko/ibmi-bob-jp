      *%METADATA                                                       *
      * %TEXT EOL/400バッチ実習問題３解答例                                       *
      *%EMETADATA                                                      *
     H**********************************************************************
     H*BPL030   地区別受注一覧表                                        **
     H**********************************************************************
     H DATEDIT(*YMD)

     F**********************************************************************
     F*      FILE DESCRIPTION                                             **
     F*-------------------------------------------------------------------**
     F*  JUMIDL02 受注見出しファイル                                    **
     F*  TOKMSP   得意先マスターファイル                                **
     F*  BPL030P  地区別受注一覧表                                      **
     F**********************************************************************
     FJUMIDL02  IP   E           K DISK
     FTOKMSP    IF   E           K DISK
     FBPL030P   O    E             PRINTER OFLIND(*IN80)

     D**********************************************************************
     D*      DATA STRUCTURE                                               **
     D**********************************************************************
     D   Z             S              1  0
      *配列交互形式の定義
     D   TIKCOD        S              2    DIM(5) PERRCD(1) CTDATA
     D   TIKNAM        S              8    DIM(5) ALT(TIKCOD)

     I**********************************************************************
     I*      REC INFOMATION                                               **
     I**********************************************************************
     IJUMIDR        01
     I                                          JHTIKU        L2
     I                                          JHTOKB        L1

     ***********************************************************************
     ***  MAIN ROUTINE                                                    **
     ***********************************************************************
     C   L2              EXSR      L2FST
     C   L1              EXSR      L1FST
     C   01              EXSR      MIDSUB
     CL1                 EXSR      L1SUB
     CL2                 EXSR      L2SUB

     C     L2FST         BEGSR
      *地区名の取得
     C                   Z-ADD     1             Z
     C     JHTIKU        LOOKUP    TIKCOD(Z)                              51
     C                   IF        *IN51 = *ON
     C                   EVAL      Z1TIKNAM = TIKNAM(Z)
     C                   ELSE
     C                   EVAL      Z1TIKNAM = *ALL'*'
     C                   ENDIF
     C                   WRITE     ¥HED01
      *地区計フィールドの初期化
     C                   EVAL      Z3REC  = *ZERO
     C                   EVAL      Z3KING = *ZERO

     C                   ENDSR

     C     L1FST         BEGSR
      *得意先合計フィールドの初期化
     C                   EVAL      Z2REC  = *ZERO
     C                   EVAL      Z2KING = *ZERO
     C                   ENDSR

     C     MIDSUB        BEGSR
      *地区計への足し込み
     C                   EVAL      Z2REC  = Z2REC  + 1
     C                   EVAL      Z2KING = Z2KING + JHKING
     C                   ENDSR

     C     L1SUB         BEGSR
      *得意先名の取得
     C     JHTOKB        CHAIN     TOKMSP                             90
     C                   IF        *IN90 = *ON
     C                   EVAL      TKNAKJ = *ALL'*'
     C                   ENDIF
      *得意先毎の平均値の算出と地区計への足し込み
     C                   EVAL(H)   Z2AVR  = Z2KING / Z2REC
     C                   EVAL      Z3REC  = Z3REC  + Z2REC
     C                   EVAL      Z3KING = Z3KING + Z2KING
      *-オーバーフロー時の改ページ
     C                   IF        *IN80 = *ON
     C                   WRITE     ¥HED01
     C                   EVAL      *IN80 = *OFF
     C                   ENDIF
      *-得意先計の書き出し
     C                   WRITE     ¥TTL01
     C                   ENDSR

     C     L2SUB         BEGSR
      *地区計毎の平均値の算出
     C                   EVAL(H)   Z3AVR = Z3KING / Z3REC
      *-地区計の書き出し
     C                   WRITE     ¥TTL02
     C                   ENDSR
** TIKCOD/TIKNAM 地区コード／地区名
01北海道
02東北
03北陸
04関東
05関西
