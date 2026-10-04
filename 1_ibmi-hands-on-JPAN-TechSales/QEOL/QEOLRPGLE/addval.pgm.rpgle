     H DFTACTGRP(*NO) ACTGRP(*NEW)

     * プロトタイプの定義
    D ADDVAL          PR             9Z 0
    D                                9Z 0

     * 変数の定義
    D RESULT          S              9Z 0
    D INPUT           S              9Z 0

     * メイン処理
    C     *ENTRY        PLIST
    C                   PARM                    INPUT
    C*
    C                   EVAL      RESULT = ADDVAL(INPUT)
    C                   DSPLY                   RESULT
    C                   SETON                                        LR
    C                   RETURN

     * ここからサブ・プロシージャー
    P ADDVAL          B
     * パラメーターインターフェース
    D ADDVAL          PI             9Z 0
    D  NUMBER                        9Z 0
    C*
    C                   RETURN    NUMBER + 100
    P                 E
