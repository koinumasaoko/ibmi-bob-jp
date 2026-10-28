-- ===================================================================
-- LAB2-OPS 参考SQL：ジョブ／サブシステムの見える化
-- ===================================================================

-- 1. サブシステム一覧（WRKSBS 相当）
SELECT SUBSYSTEM_DESCRIPTION         AS サブシステム,
       SUBSYSTEM_DESCRIPTION_LIBRARY AS ライブラリー,
       STATUS                        AS 状況,
       CURRENT_ACTIVE_JOBS           AS アクティブジョブ数,
       MAXIMUM_ACTIVE_JOBS           AS 最大ジョブ数,
       TEXT_DESCRIPTION              AS 説明
  FROM QSYS2.SUBSYSTEM_INFO
 ORDER BY CURRENT_ACTIVE_JOBS DESC NULLS LAST;

-- 2. 自動開始ジョブ
SELECT SUBSYSTEM_DESCRIPTION_LIBRARY AS ライブラリー,
       SUBSYSTEM_DESCRIPTION         AS サブシステム,
       AUTOSTART_JOB_NAME            AS 自動開始ジョブ,
       JOB_DESCRIPTION_LIBRARY CONCAT '/' CONCAT JOB_DESCRIPTION AS ジョブ記述
  FROM QSYS2.AUTOSTART_JOB_INFO
 ORDER BY 1, 2, 3;

-- 3. 特定サブシステムのジョブ（WRKACTJOB SBS(HANDSON) 相当）
SELECT JOB_NAME_SHORT AS ジョブ名,
       JOB_USER       AS ユーザー,
       JOB_NUMBER     AS ジョブ番号,
       JOB_STATUS     AS 状況,
       JOB_TYPE       AS タイプ,
       FUNCTION       AS 機能
  FROM TABLE(QSYS2.ACTIVE_JOB_INFO(
         SUBSYSTEM_LIST_FILTER => 'HANDSON',
         DETAILED_INFO         => 'NONE')) X
 ORDER BY JOB_NAME_SHORT;

-- 4. システム全体の応答待ち（MSGW）ジョブ
SELECT JOB_NAME, SUBSYSTEM, JOB_STATUS, FUNCTION
  FROM TABLE(QSYS2.ACTIVE_JOB_INFO(DETAILED_INFO => 'NONE')) X
 WHERE JOB_STATUS = 'MSGW';

-- 5. 未回答の照会メッセージ（ハンズオン用メッセージ待ち行列）
--    本番では MESSAGE_QUEUE_LIBRARY = 'QSYS' AND MESSAGE_QUEUE_NAME = 'QSYSOPR'
SELECT MESSAGE_TIMESTAMP AS 時刻,
       FROM_JOB          AS 送信元ジョブ,
       MESSAGE_ID        AS メッセージID,
       MESSAGE_TEXT      AS メッセージ,
       HEX(MESSAGE_KEY)  AS メッセージキー
  FROM QSYS2.MESSAGE_QUEUE_INFO A
 WHERE MESSAGE_QUEUE_LIBRARY = 'STUDY01'
   AND MESSAGE_QUEUE_NAME    = 'OPSMSGQ'
   AND MESSAGE_TYPE          = 'INQUIRY'
   AND NOT EXISTS (SELECT 1 FROM QSYS2.MESSAGE_QUEUE_INFO R
                    WHERE R.MESSAGE_QUEUE_LIBRARY = A.MESSAGE_QUEUE_LIBRARY
                      AND R.MESSAGE_QUEUE_NAME    = A.MESSAGE_QUEUE_NAME
                      AND R.ASSOCIATED_MESSAGE_KEY = A.MESSAGE_KEY)
 ORDER BY MESSAGE_TIMESTAMP DESC;

-- 6. ジョブ・スケジュール項目（WRKJOBSCDE 相当）
SELECT SCHEDULED_JOB_NAME AS ジョブ名,
       STATUS             AS 状況,
       FREQUENCY          AS 頻度,
       SCHEDULED_TIME     AS 時刻,
       NEXT_SUBMISSION_DATE AS 次回投入日,
       COMMAND_STRING     AS コマンド
  FROM QSYS2.SCHEDULED_JOB_INFO
 ORDER BY CASE STATUS WHEN 'HELD' THEN 0 ELSE 1 END, SCHEDULED_JOB_NAME;
