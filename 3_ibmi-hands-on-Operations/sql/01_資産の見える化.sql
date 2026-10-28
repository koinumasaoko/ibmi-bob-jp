-- ===================================================================
-- LAB1-OPS 参考SQL：資産の見える化
--   Bob が生成した SQL の答え合わせ用です。STUDY01 は自分の番号に置き換えてください。
-- ===================================================================

-- 1. オブジェクト種類別の件数
SELECT OBJTYPE, COUNT(*) AS 件数
  FROM TABLE(QSYS2.OBJECT_STATISTICS('STUDY01', '*ALL')) X
 GROUP BY OBJTYPE
 ORDER BY 件数 DESC;

-- 2. プログラム・ファイルの一覧（最終使用日付き）
SELECT OBJNAME             AS オブジェクト名,
       OBJTYPE             AS 種類,
       OBJATTRIBUTE        AS 属性,
       OBJTEXT             AS 説明,
       DATE(OBJCREATED)    AS 作成日,
       DATE(LAST_USED_TIMESTAMP) AS 最終使用日,
       DAYS_USED_COUNT     AS 使用日数
  FROM TABLE(QSYS2.OBJECT_STATISTICS('STUDY01', '*PGM *SRVPGM *FILE')) X
 ORDER BY OBJTYPE, OBJNAME;

-- 3. ソースメンバーの集計（ソースファイル別・タイプ別）
SELECT TABLE_NAME AS ソースファイル,
       SOURCE_TYPE AS ソースタイプ,
       COUNT(*)    AS メンバー数
  FROM QSYS2.SYSPARTITIONSTAT
 WHERE TABLE_SCHEMA = 'STUDY01'
   AND SOURCE_TYPE IS NOT NULL
 GROUP BY TABLE_NAME, SOURCE_TYPE
 ORDER BY TABLE_NAME, SOURCE_TYPE;

-- 4. 最近更新されたソースメンバー上位10件
SELECT TABLE_NAME AS ソースファイル,
       TABLE_PARTITION AS メンバー,
       SOURCE_TYPE AS タイプ,
       PARTITION_TEXT AS 説明,
       LAST_SOURCE_UPDATE_TIMESTAMP AS 最終更新
  FROM QSYS2.SYSPARTITIONSTAT
 WHERE TABLE_SCHEMA = 'STUDY01'
   AND SOURCE_TYPE IS NOT NULL
 ORDER BY LAST_SOURCE_UPDATE_TIMESTAMP DESC
 FETCH FIRST 10 ROWS ONLY;

-- 5. 整理候補：一度も使われていない／1年以上使われていないオブジェクト
SELECT OBJNAME, OBJTYPE, OBJTEXT,
       DATE(LAST_USED_TIMESTAMP) AS 最終使用日,
       CASE WHEN LAST_USED_TIMESTAMP IS NULL THEN '未使用'
            ELSE '1年以上未使用' END AS 判定
  FROM TABLE(QSYS2.OBJECT_STATISTICS('STUDY01', '*PGM *SRVPGM *FILE')) X
 WHERE LAST_USED_TIMESTAMP IS NULL
    OR LAST_USED_TIMESTAMP < CURRENT TIMESTAMP - 1 YEAR
 ORDER BY 最終使用日 NULLS FIRST;

-- 6. プログラム⇔ファイル相互参照（事前に CL で出力しておく）
--    DSPPGMREF PGM(STUDY01/*ALL) OUTPUT(*OUTFILE) OUTFILE(STUDY01/PGMREF)
SELECT WHPNAM AS プログラム,
       WHFNAM AS 参照オブジェクト,
       WHLNAM AS ライブラリー,
       WHOTYP AS 種類,
       CASE WHFUSG WHEN 1 THEN '入力' WHEN 2 THEN '出力' WHEN 3 THEN '入力/出力'
                   WHEN 4 THEN '更新' ELSE CHAR(WHFUSG) END AS 使用区分
  FROM STUDY01.PGMREF
 ORDER BY WHPNAM, WHOTYP, WHFNAM;

-- 7. 論理ファイル → 基になる物理ファイル
SELECT DBFFIL AS 論理ファイル, DBFLIB AS ライブラリー,
       DBFFDP AS 物理ファイル, DBFLDP AS 物理ファイルライブラリー
  FROM QSYS.QADBFDEP
 WHERE DBFLIB = 'STUDY01';
