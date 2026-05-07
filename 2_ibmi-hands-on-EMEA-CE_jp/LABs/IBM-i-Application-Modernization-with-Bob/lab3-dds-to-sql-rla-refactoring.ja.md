# Lab 101-3: BobによるRLA操作からSQLへの変換

## 概要
IBM Bobを使用して、15分で1つのレコードレベルアクセス（RLA）操作をモダンなSQLに変換する方法を学びます。

**所要時間**: 15分  
**難易度**: 初級  
**構築するもの**: 1つのCHAIN操作をSQL SELECTに変換

---

## 前提条件
- VS Codeでプロジェクトファイルにアクセス可能
- IBM Bob AIアシスタントが利用可能
- ファイル: `SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE`

---

## ユースケース: 商品検索をRLAからSQLに変換

商品編集時に使用される商品検索操作（CHAIN）をSQLを使用するように変換します。

---

## ステップ1: BobにRLA操作の説明を依頼（3分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
@SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE

249行目を見てください：chain arid article1;

シンプルな言葉で説明してください：
1. CHAINは何をしますか？
2. どのデータを取得しますか？
3. レコードが見つからない場合はどうなりますか？

英語版 / English Version:
@SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE

Look at line 249: chain arid article1;

Explain in simple terms:
1. What does CHAIN do?
2. What data does it retrieve?
3. What happens if the record is not found?
```

**確認すべきポイント:**
- BobがCHAINはキーで1レコードを読み取ることを説明
- FARTIレコード形式に商品データを取得
- 見つからない場合、%FOUND()がfalse

---

## ステップ2: BobにSQL相当を表示するよう依頼（4分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
このRLA操作をSQLに変換してください：

chain arid article1;

要件：
- SQL SELECT文を使用
- 同じフィールドを取得
- "見つからない"ケースを処理
- シンプルに保つ
- SQLコードを見せてください

英語版 / English Version:
Convert this RLA operation to SQL:

chain arid article1;

Requirements:
- Use SQL SELECT statement
- Get the same fields
- Handle "not found" case
- Keep it simple
- Show me the SQL code
```

**期待される出力:**
```rpgle
// 古いRLA方式:
chain arid article1;

// 新しいSQL方式:
Exec SQL
  SELECT ARID, ARDESC, ARSALEPR, ARWHSPR, ARTIFA,
         ARSTOCK, ARMINQTY, ARVATCD
  INTO :article.arid, :article.ardesc, :article.arsalepr,
       :article.arwhspr, :article.artifa, :article.arstock,
       :article.arminqty, :article.arvatcd
  FROM ARTICLE
  WHERE ARID = :arid;

If SQLCODE = 0;
  // レコードが見つかった
Else;
  // レコードが見つからない
EndIf;
```

---

## ステップ3: Bobに関連データの追加を依頼（4分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
SQLを改善して、1つのクエリでファミリー説明も取得してください。

元のコードはこれを別々に行います：
- 249行目：chain arid article1;
- 250行目：famdesc = getArtFamDesc(artifa);

JOINを使用して、1つのSQL文で商品とファミリーデータの両方を取得する方法を見せてください。

英語版 / English Version:
Improve the SQL to also get the family description in one query.

The original code does this separately:
- Line 249: chain arid article1;
- Line 250: famdesc = getArtFamDesc(artifa);

Show me how to get both article and family data in one SQL statement using JOIN.
```

**期待される出力:**
```rpgle
Exec SQL
  SELECT A.ARID, A.ARDESC, A.ARSALEPR, A.ARWHSPR, 
         A.ARTIFA, A.ARSTOCK, A.ARMINQTY, A.ARVATCD,
         F.FADESC
  INTO :article.arid, :article.ardesc, :article.arsalepr,
       :article.arwhspr, :article.artifa, :article.arstock,
       :article.arminqty, :article.arvatcd,
       :familyDesc
  FROM ARTICLE A
  LEFT JOIN FAMILLY F ON A.ARTIFA = F.FAID
  WHERE A.ARID = :arid;
```

---

## ステップ4: Bobに利点について質問（4分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
この操作でRLAの代わりにSQLを使用する利点は何ですか？
2-3のシンプルな利点をリストしてください。

英語版 / English Version:
What are the benefits of using SQL instead of RLA for this operation?
List 2-3 simple benefits.
```

**期待される利点:**
1. **データベースへの1回のトリップ**: JOINで1つのクエリで関連データを取得
2. **より柔軟**: フィールドや条件の追加が容易
3. **パフォーマンス向上**: SQLオプティマイザーが最適なアクセスパスを選択可能

---

## ✅ 成功基準

以下の条件を満たせば、このラボは正常に完了です：
- [ ] CHAINが何をするか理解
- [ ] SQL相当を確認
- [ ] JOINがコードをどのように改善するか理解
- [ ] SQLがRLAより優れている理由を理解

---

## 変換前後の比較

### 変換前（RLA - 2操作）:
```rpgle
// 操作1: 商品を取得
chain arid article1;

// 操作2: ファミリー説明を取得
famdesc = getArtFamDesc(artifa);
```

### 変換後（SQL - 1操作）:
```rpgle
// 1つのクエリで両方を取得
Exec SQL
  SELECT A.*, F.FADESC
  INTO :article, :familyDesc
  FROM ARTICLE A
  LEFT JOIN FAMILLY F ON A.ARTIFA = F.FAID
  WHERE A.ARID = :arid;
```

**結果**: データベース操作が少なく、コードがよりクリーン！

---

## 重要なポイント

1. **SQLはより強力**: 1つのクエリで関連データを取得可能
2. **Bobは変換できる**: BobにRLAからSQLへの変換を依頼
3. **JOINは便利**: 複数のテーブルからデータを結合
4. **小さく始める**: 一度に1つの操作を変換

---

## 実世界の例

このパターンは`SAMCO/QRPGLESRC/ART400.SQLRPGLE`（79-97行）で使用されています：

```rpgle
Exec SQL
  DECLARE C1 CURSOR FOR
  SELECT 
    A.ARID, A.ARDESC, A.ARTIFA,
    COALESCE(F.FADESC, ''),
    A.ARVATCD,
    COALESCE(V.VATRATE, 0),
    A.ARSALEPR, A.ARWHSPR, A.ARSTOCK, A.ARMINQTY, A.ARDEL
  FROM ARTICLE A
  LEFT JOIN FAMILLY F ON A.ARTIFA = F.FAID
  LEFT JOIN VATDEF V ON A.ARVATCD = V.VATCODE
  WHERE A.ARDEL = ' '
  ORDER BY A.ARID;
```

**これは商品 + ファミリー + VATデータを1つのクエリで取得！**

---

## 次のステップ

**さらに操作を変換してみる:**
- BobにREADループ（s01lod）の変換を依頼
- BobにUPDATE操作の変換を依頼
- BobにWRITE操作の変換を依頼

**さらに学習:**
- 完全なSQL例についてはART400.SQLRPGLEを確認
- BobにSQLカーソルの説明を依頼
- BobにSQLパフォーマンスのヒントについて質問