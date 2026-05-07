# Lab 101-1: BobによるRPG固定形式からフリー形式への変換

## 概要
IBM Bobを使用してレガシーRPGコードを分析し、わずか15分で固定形式からモダンなフリー形式に変換する方法を学びます。

**所要時間**: 15分  
**難易度**: 初級  
**構築するもの**: 1つのRPGサブルーチンを固定形式からフリー形式に変換

---

## 前提条件
- VS Codeでプロジェクトファイルにアクセス可能
- IBM Bob AIアシスタントが利用可能
- ファイル: `SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE`

---

## ユースケース: サブファイルロードロジックの変換

`s01lod`（サブファイルロード）サブルーチンを固定形式からフリー形式に変換します。

---

## ステップ1: Bobにコードの説明を依頼（3分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
@SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE

s01lodサブルーチン（102-118行）が何をするか説明してください。
以下に焦点を当ててください：
1. どのデータを読み取るか
2. どのようにサブファイルをロードするか
3. ループが何をするか
シンプルで簡潔に説明してください。

英語版 / English Version:
@SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE

Explain what the s01lod subroutine does (lines 102-118).
Focus on:
1. What data it reads
2. How it loads the subfile
3. What the loop does
Keep it simple and concise.
```

**確認すべきポイント:**
- BobがARTICLE2ファイルから読み取ることを説明
- サブファイルに14レコードをロード
- カウンターと%EOFを使用してループを制御

---

## ステップ2: Bobにフリー形式への変換を依頼（5分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
s01lodサブルーチン（102-118行）を固定形式からフリー形式に変換してください。

要件：
- BEGSR/ENDSRの代わりにDcl-Procを使用
- 同じロジックを保持
- 各セクションを説明するコメントを追加
- モダンなRPG IV構文を使用

変換されたコードを見せてください。

英語版 / English Version:
Convert the s01lod subroutine (lines 102-118) from Fixed format to Free format.

Requirements:
- Use Dcl-Proc instead of BEGSR/ENDSR
- Keep the same logic
- Add comments explaining each section
- Use modern RPG IV syntax

Show me the converted code.
```

**期待される出力:**
```rpgle
// Load Subfile Procedure
Dcl-Proc LoadSubfile;
  
  // Restore position from last read
  RestorePosition();
  
  // Initialize subfile
  RRb01 = RRn01 + 1;
  opt01 = 0;
  count = 0;
  
  // Read and load up to 14 records
  Read ARTICLE2;
  DoW Not %Eof(ARTICLE2) And count < 14;
    RRN01 += 1;
    count += 1;
    Write SFL01;
    Read ARTICLE2;
  EndDo;
  
  // Set end of file indicator
  sflend = %Eof(ARTICLE1);
  step01 = dsp;
  
  // Save current position
  SavePosition();
  
End-Proc;
```

---

## ステップ3: Bobに改善点を質問（4分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
この変換されたコードにどのような改善ができますか？
読みやすさや保守性を向上させるための2-3のシンプルな改善を提案してください。

英語版 / English Version:
What improvements can be made to this converted code?
Suggest 2-3 simple improvements for better readability or maintainability.
```

**期待される提案:**
1. マジックナンバー14を定数に抽出
2. より説明的な変数名を使用
3. エラー処理を追加

---

## ステップ4: 1つの改善を適用（3分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
LoadSubfileプロシージャを更新して、マジックナンバー14の代わりに
名前付き定数を使用してください。改善されたコードを見せてください。

英語版 / English Version:
Update the LoadSubfile procedure to use a named constant
instead of the magic number 14. Show me the improved code.
```

**期待される出力:**
```rpgle
// Constants
Dcl-C SUBFILE_PAGE_SIZE 14;

// Load Subfile Procedure
Dcl-Proc LoadSubfile;
  
  RestorePosition();
  
  RRb01 = RRn01 + 1;
  opt01 = 0;
  count = 0;
  
  Read ARTICLE2;
  DoW Not %Eof(ARTICLE2) And count < SUBFILE_PAGE_SIZE;
    RRN01 += 1;
    count += 1;
    Write SFL01;
    Read ARTICLE2;
  EndDo;
  
  sflend = %Eof(ARTICLE1);
  step01 = dsp;
  SavePosition();
  
End-Proc;
```

---

## ✅ 成功基準

以下の条件を満たせば、このラボは正常に完了です：
- [ ] Bobが元の固定形式コードを説明
- [ ] Dcl-Procを使用してフリー形式に変換
- [ ] マジックナンバーを名前付き定数に置き換え
- [ ] 変換前後の違いを理解

---

## 重要なポイント

1. **Bobは説明できる**: Bobを使用してレガシーコードを素早く理解
2. **フリー形式はより明確**: モダンな構文はより読みやすい
3. **名前付き定数**: 保守性のためにマジックナンバーを置き換え
4. **段階的な変更**: 一度に1つのサブルーチンを変換

---

## 次のステップ

- 別のサブルーチン（s01chkまたはs01act）の変換を試す
- Bobにパネル全体（pnl02）の変換を依頼
- UIモダナイゼーションのためにLab 101-2に進む