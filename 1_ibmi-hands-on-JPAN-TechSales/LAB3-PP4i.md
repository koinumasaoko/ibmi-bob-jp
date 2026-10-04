> 🚧 **このラボは現在作成中です。内容は予告なく変更される場合があります。**

# LAB3-PP4i: PP4iワークフロー・スラッシュコマンドを体験 ⚙️

## 🎯 このラボの目標

PP4iが提供する**ワークフロー**と**/(スラッシュ)コマンド**を実際に動かして、IBM i 開発における複雑な作業の自動化を体験します。ビジネスルールの抽出、固定形式RPGの自由形式への変換、ERD生成、SQLレビューなど、実務で即活用できる機能を習得します。

**所要時間**: 20-25分  
**難易度**: ★★★☆☆（中級）  
**使用モード**: IBM i Developer モード  
**ワークスペース**: Library List

---

## 📚 学習内容

このラボでは、以下のスキルを習得します：

- ✅ ワークフローの起動と操作方法
- ✅ **Business Rules 抽出ワークフロー**の実行
- ✅ **RPG Modernization ワークフロー**による固定形式→自由形式変換
- ✅ **/(スラッシュ)コマンド**（`/erd`・`/review_SQL`）の活用
- ✅ ワークフローとスラッシュコマンドの使い分け

---

## ステップ1: 事前準備（3分）

### 1.1 ワークスペースを Library List に切り替える

このラボでは IBM i 上のソースを直接操作するため、ワークスペースを **Library List** に切り替えます。

1. チャット入力欄の上部にある **New Task** をクリック
2. **「Library List」** を選択
3. LAB1-PP4i で追加した `STUDYxx` ライブラリーが含まれていることを確認

> 💡 **LAB1-PP4iとの違い**: LAB1-PP4iではLocalワークスペースでHTMLを生成しました。このラボではIBM i 上のソースメンバーを直接読み書きするため Library List を使用します。

### 1.2 IBM i Developer モードを選択

1. **チャットウィンドウ左下**のモード選択から **「IBM i Developer」** モードを選択

---

## ステップ2: Business Rules 抽出ワークフローを実行（8分）

PP4iのワークフローを使って、既存RPGプログラムからビジネスルールを自動抽出します。

> 💡 **ワークフローとは？**  
> 複数のスキル・ツールを組み合わせて複雑なタスクを**手順通りに自動実行**するPP4i固有の機能です。「手順書を自動で実行してくれる仕組み」とイメージしてください。

### 2.1 ワークフローの起動

1. チャット画面の **「Start Workflow」** ボタンを押下

2. ワークフローを実行する**ワークスペースを指定**し、**Enter キー** を押下  
   - 今回は **Library List** を指定

3. 表示されるワークフロー一覧から **「Business Rules 抽出」** の開始ボタン（▶）を押下

### 2.2 抽出対象の指定

Bobから対象プログラムを聞かれたら以下を入力してください：

```
STUDYxx/QEOLRPG の bch110 メンバー
```

### 2.3 抽出結果の確認

**期待される動作**:
1. `read_member` ツールが `bch110` を IBM i から直接取得
2. ビジネスルール（計算式・条件分岐・処理フロー）を自動解析
3. Markdown形式のドキュメントを生成・表示

**期待される回答のポイント**:
- 計算ルール（例：利用可能額 = 信用限度額 − 売掛金残高）
- ループ・条件分岐のロジック
- 入出力ファイルの役割
- エラー処理の有無

---

## ステップ3: RPG Modernization ワークフローを実行（10分）

固定形式RPG（RPG III）を自由形式RPG（RPGLE フリーフォーム）に変換するワークフローを体験します。

> 📖 **参考**: [RPG Modernization Workflow 公式ドキュメント](https://bob.ibm.com/docs/ide/premium-packages/bob-for-i/workflows#rpg-modernization-workflow)

### 3.1 事前準備：変換先ソースファイルの作成

> ⚠️ **重要**: STUDYxxのソースファイルはCCSID **5026**（日本語EBCDIC・DBCS混在）で作成されています。変換先のRPGLEソースファイルを新規作成する際は、以下のパラメーターが必要です。

BobまたはIBM i のコマンド画面で以下のCLコマンドを実行してください：

```cl
CRTSRCPF FILE(STUDYxx/QEOLRPGLE2) +
         RCDLEN(112) +
         CCSID(1399) +
         IGCDTA(*YES) +
         TEXT('LAB3-PP4i 変換先RPGLEソース')
```

| パラメーター | 値 | 理由 |
|-----------|---|------|
| `RCDLEN(112)` | 112バイト | DBCSデータを含む日本語ソース用（デフォルト92では不足） |
| `CCSID(1399)` | Unicode対応の日本語CCSID | 5026より新しく、変換後のソースに適切 |
| `IGCDTA(*YES)` | DBCSデータ使用を明示 | 日本語コメント等のDBCSデータを正しく扱う |

> 💡 **Bobへ依頼する場合**:
> ```
> IBM i 上に STUDYxx/QEOLRPGLE2 というソースファイルを
> RCDLEN(112) CCSID(1399) IGCDTA(*YES) で作成してください。
> ```

### 3.2 RPG Modernization ワークフローの起動

1. チャット画面の **「Start Workflow」** ボタンを押下
2. ワークスペースに **Library List** を指定し、**Enter キー** を押下
3. ワークフロー一覧から **「RPG Modernization」** の開始ボタン（▶）を押下

### 3.3 変換対象・変換先の指定

Bobの指示に従って以下を入力してください：

| 項目 | 入力値 |
|-----|-------|
| 変換元 | `STUDYxx/QEOLRPG` の `bch110` メンバー |
| 変換先 | `STUDYxx/QEOLRPGLE2` の `BCH110` メンバー |

### 3.4 変換結果の確認

**期待される動作**:
1. Bobが固定形式RPG IIIの構文を解析
2. 自由形式RPGLE（フリーフォーム）に変換
3. 変換後のソースを `STUDYxx/QEOLRPGLE2/BCH110` に書き込み

**変換例（イメージ）**:

| 変換前（固定形式） | 変換後（自由形式） |
|-----------------|----------------|
| `C           TKGEND    SUB  TKUZAN    WKRIYO  90` | `WKRIYO = TKGEND - TKUZAN;` |
| `C           *IN99     DOWEQ'0'` | `DOW NOT %EOF(TOKMSL03);` |
| `C                     EXCPTMIDASI` | `WRITE MIDASI;` |

> 💡 **ポイント**: ワークフローは段階的に進み、各ステップでBobから確認を求められる場合があります。内容を確認しながら進めましょう。

---

## 📐 ステップ4: /erdコマンドでERDを生成（5分）

スラッシュコマンドを使って、接続中のIBM i データベースのER図を自動生成します。

> 💡 **スラッシュコマンドとは？**  
> ワークフローほど複雑ではないが、よく使う作業をコマンド化したPP4i固有の機能です。`/` を入力するとコマンド一覧が表示されます。

### 4.1 /erdコマンドの実行

1. チャット入力欄で **`/erd`** と入力
2. コマンド一覧から `erd` を選択
3. 対象ライブラリー名を入力：

```
STUDYxx
```

**期待される出力（Mermaid ERD）**:

```mermaid
erDiagram
    TOKMSP {
        char TKBANG "得意先番号"
        char TKNAKJ "得意先名漢字"
        char TKADR1 "住所1"
        numeric TKGEND "信用限度額"
        numeric TKUZAN "売掛金残高"
    }
    JUMEIP {
        char JUKOBANG "得意先番号"
        numeric JUKIN "受注金額"
    }
    TOKMSP ||--o{ JUMEIP : "得意先番号"
```

💡 **活用シーン**: 引き継ぎ資料・設計書にそのまま貼り付けて使えます。ドキュメント不足のシステムでも即座にDB全体像を把握できます。

---

## ステップ5: /review_SQLコマンドでSQLをレビュー（3分）

### 5.1 /review_SQLコマンドの実行

1. チャット入力欄で **`/review_SQL`** と入力
2. コマンド一覧から `review_SQL` を選択
3. 続けて以下のSQLを貼り付けて送信：

```sql
SELECT TKBANG, TKNAKJ, TKGEND, TKUZAN, (TKGEND - TKUZAN) AS RIYO
FROM STUDYxx/TOKMSP
WHERE TKUZAN > 0
ORDER BY TKUZAN DESC
```

**期待される回答のポイント**（事前定義のチェックリストに基づく）:
- ✅ **正確性**: SQLが意図した結果を返すか
- ✅ **パフォーマンス**: インデックスの活用・実行計画
- ✅ **セキュリティ**: リスクの有無
- ✅ **ベストプラクティス**: Db2 for i の推奨事項への準拠（`STUDYxx/TOKMSP` → `STUDYxx.TOKMSP` 形式など）

---

## ✅ チェックポイント

このラボを完了したら、以下を確認してください：

- [ ] ワークスペースを Library List に切り替えられた
- [ ] Business Rules 抽出ワークフローを実行できた
- [ ] RPG Modernization ワークフローを実行できた
- [ ] CRTSRCPF の CCSID・RCDLEN・IGCDTA の意味を説明できる
- [ ] `/erd` コマンドでERDを生成できた
- [ ] `/review_SQL` コマンドでSQLをレビューできた
- [ ] ワークフローとスラッシュコマンドの違いを説明できる

---

## 💡 このラボで学んだこと

### PP4iワークフロー・スラッシュコマンドでできたこと

✅ **複雑な作業を手順通りに自動化（ワークフロー）**
- 従来: マニュアルを読んで手動でコードを変換（数時間〜数日）
- PP4i活用: ワークフローを起動するだけでビジネスルール抽出・変換を自動実行（数分）

✅ **よく使う作業をコマンド1つで実行（スラッシュコマンド）**
- `/erd` でDB全体のER図を即生成
- `/review_SQL` でSQLを包括的にレビュー

### ワークフローとスラッシュコマンドの使い分け

| | ワークフロー | スラッシュコマンド |
|--|------------|----------------|
| 複雑さ | 多段階・複雑なタスク | 比較的シンプルなタスク |
| 起動方法 | Start Workflow ボタン | `/` から入力 |
| 例 | Business Rules抽出、RPG Modernization | /erd、/review_SQL |
| 対話 | Bobと対話しながら進む | 入力後すぐ結果が返る |

### PP4i全機能マップ（おさらい）

```
PP4i
├── スキル（自動適用） ← LAB1-PP4iで体験
│   └── RPG/DDS/CL/SQLの専門知識で精度向上
├── ツール（明示的に呼び出し可能） ← LAB1-PP4iで体験
│   └── read_member / write_member / execute_cl_command 等
├── RAG（IBM i 公式ドキュメント参照） ← LAB1-PP4iで体験
├── ワークフロー（Start Workflowから起動） ← このラボで体験
│   ├── Business Rules 抽出
│   └── RPG Modernization
└── /(スラッシュ)コマンド ← このラボで体験
    ├── /erd -> ERD生成
    └── /review_SQL -> SQLレビュー
```

### 実務での活用シーン

1. **引き継ぎ・ドキュメント整備**
   - Business Rules 抽出で既存システムを即座にドキュメント化
   - `/erd` で複雑なDB設計を可視化して後任者に引き継ぎ

2. **段階的なモダナイゼーション**
   - RPG Modernization ワークフローで固定形式→自由形式に安全に変換
   - 変換後のコードをBobでレビュー・改善

3. **SQL品質向上**
   - `/review_SQL` でパフォーマンス問題を事前発見
   - Db2 for i のベストプラクティスへの準拠を確認

---

## 🎯 よくある質問

**Q: RPG Modernization ワークフローで変換が失敗した場合は？**

A: 変換先ソースファイルのCCSIDやRCDLENを確認してください。日本語コメントを含むソースは `CCSID(1399)` `RCDLEN(112)` `IGCDTA(*YES)` が必要です。Bobにエラーメッセージを貼り付けて相談するのが最も早い解決方法です。

**Q: ワークフローの結果はどこに保存される？**

A: Library List ワークスペースの場合、書き込みは `write_member` ツールを通じてQSYSソースメンバーに直接行われます。

**Q: /erdで特定のテーブルだけ表示できる？**

A: `/erd` 実行後、Bobにテーブルを絞り込むよう指示することができます（例：「TOKMSPとJUMEIPのみのERDを生成してください」）。

---

## 🎉 ラボ完了！

お疲れ様でした！PP4iのワークフローとスラッシュコマンドを使った自動化を体験しました。

### このワークショップで学んだこと（まとめ）

| ラボ | 内容 | 習得スキル |
|-----|------|----------|
| LAB1 | 既存プログラムの理解 | Ask/Agentモード、コード解析、設計書生成 |
| LAB2 | プログラムの修正 | DDS/RPGの修正、影響分析 |
| LAB3-FIX | 新規プログラム作成 | RPG III固定形式の開発 |
| LAB1-PP4i | PP4i基本操作 | IBM i 接続、スキル/ツール/RAG、HTML設計書生成 |
| LAB2-PP4i | ソース改修・テスト | RPGソース改修、RPGUnit テスト |
| **LAB3-PP4i** | **ワークフロー・スラッシュコマンド** | **Business Rules抽出、RPG変換、ERD生成、SQLレビュー** |

### 次のステップ

- 📖 [PP4i公式ドキュメント](https://bob.ibm.com/docs/ide/premium-packages/bob-for-i/workflows) でワークフローの詳細を確認
- 💡 [Qiitaサンプルプロンプト集](https://qiita.com/amogi23/items/fd91ddddf93057e562b5) で実践例を参考にする
- 🏗️ 自社システムのRulesとSkillsを作成して、チーム開発に活用する

---

**前のページ**: [LAB2-PP4i](./LAB2-PP4i.md) | **トップに戻る**: [README](./README.md)
