      *%METADATA                                                       *
      * %TEXT EOL/400対話型実習問題２回答例                                       *
      *%EMETADATA                                                      *
     H*****************************************************************
     H* IPL020 * 品目照会( SFL )                                    *
     H*****************************************************************
     H DATEDIT(*YMD)
     H*****************************************************************
     FIPL020D   CF   E             WORKSTN    SFILE(SFL01:#RRN01)
     FHINMSL01  IF   E           K DISK

     D*****************************************************************
     D** ﾜｰｸﾌｨｰﾙﾄﾞの定義
     D  #NAKN          S                   LIKE(HNNAKN)
     D  #CTL           S              4
     D** サブファイル相対ﾚｺｰﾄﾞ番号だよ
     D  #RRN01         S              4  0

     C*****************************************************************
     C** MAIN ROUTINE
     C*****************************************************************

     C     #CTL          CASEQ     'HED '        @HED
     C     #CTL          CASEQ     'DTL '        @DTL
     C     #CTL          CASEQ     'END '        @END
     C                   ENDCS

     C*****************************************************************
     C**指示画面の処理                                              *
     C*****************************************************************
     C     @HED          BEGSR

     C*ＰＡＮＥＬ０１の表示
     C                   WRITE     PANEL99
     C                   EXFMT     PANEL01
     C**                ________
     C                   SELECT
     C** F3=終了      ‾‾‾‾‾‾‾‾
     C                   WHEN      *IN03 = *ON
     C                   EVAL      #CTL = 'END'
     C**実行キー
     C                   OTHER
     C**入力値チェック
     C                   EXSR      @CHKH
     C                   IF        *IN90 = *OFF
     C                   EXSR      @SET                                         * DATA SET
     C                   EVAL      #CTL = 'DTL'
     C                   ENDIF

     C                   ENDSL

     C                   ENDSR
     C*****************************************************************
     C**応答画面の処理                                              *
     C*****************************************************************
     C     @DTL          BEGSR
     C*ＣＴＬ０１の表示
     C                   WRITE     PANEL99
     C                   WRITE     PANEL01
     C                   EVAL      *IN32 = *ON                                  * SFLEND
     C                   EXFMT     CTL01
     C                   EVAL      *IN32 = *OFF                                 * SFLEND
     C**                ________
     C                   SELECT
     C** F3=終了      ‾‾‾‾‾‾‾‾
     C                   WHEN      *IN03 = *ON
     C                   EVAL      #CTL = 'END'
     C**実行キー
     C                   OTHER
     C                   EVAL      #CTL = 'HED'

     C                   ENDSL

     C                   ENDSR
     C*****************************************************************
     C**入力データ存在チェック                                      *
     C*****************************************************************
     C     @CHKH         BEGSR
     C**
     C                   EVAL      NO = *ZERO
     C                   EVAL      #NAKN = X1NAKN                               * SFLEND
     C** 読み取り開始位置ｾｯﾄ
     C     #NAKN         SETLL     HINMSL01                           90
     C**
     C                   ENDSR
     C*****************************************************************
     C**データセット( SFL )
     C*****************************************************************
     C     @SET          BEGSR

     C                   EVAL      #RRN01 = *ZERO                               * SFLDSP,SFLCTL
     C** ｻﾌﾞﾌｧｲﾙｸﾘｱ
     C                   EVAL      *IN33 = *ON
     C                   WRITE     CTL01
     C                   EVAL      *IN33 = *OFF
     C**品目マスター読み取り／ｻﾌﾞﾌｧｲﾙへの書き出し
     C                   EVAL      *IN91 = *OFF                                 * SFLDSP,SFLCTL
     C                   EVAL      *IN92 = *OFF                                 * SFLDSP,SFLCTL
     C                   DOU       *IN91 OR
     C                             *IN92
     C                   READ      HINMSL01                               91
     C                   IF        NOT *IN91
     C                   EVAL      #RRN01 = #RRN01 + 1                          * SFLDSP,SFLCTL
     C                   EVAL      NO     = NO + 1                              * SFLDSP,SFLCTL
     C                   WRITE     SFL01                                  92
     C                   ENDIF                                                  * SFLDSP,SFLCTL
     C                   ENDDO

     C                   ENDSR
     C*****************************************************************
     C** 終了処理
     C*****************************************************************
     C     @END          BEGSR
     C**
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C**
     C                   ENDSR
     C*****************************************************************
     C** 初期設定
     C*****************************************************************
     C     *INZSR        BEGSR
     C**
     C                   EVAL      #CTL = 'HED'
     C**
     C                   ENDSR
