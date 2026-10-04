> 🚧 **このラボは現在作成中です。内容は予告なく変更される場合があります。**

# LAB2-PP4i: PP4iでソース改修・テストを体験 🔧

## 🎯 このラボの目標

PP4iを使って IBM i 上のRPGLEソースを**Bobへの自然言語指示で改修**し、**コンパイル**して**RPGUnitでテスト**する、一連の開発サイクルを体験します。

**所要時間**: 15-20分  
**難易度**: ★★★☆☆（中級）  
**使用モード**: IBM i Developer モード  
**ワークスペース**: Library List

---

## 📚 学習内容

このラボでは、以下のスキルを習得します：

- ✅ `read_member` でIBM i からソースを直接読み込み
- ✅ Bobへの自然言語指示によるRPGLEソース改修
- ✅ `write_member` でIBM i に直接書き戻し
- ✅ `execute_compile_action` によるコンパイル
- ✅ **RPGUnit** によるユニットテストの生成と実行

---

## 📋 このラボで使うソース

ラボ専用のシンプルなRPGLEプログラム `ADDVAL` を使います。

```rpgle
     H DFTACTGRP(*NO) ACTGRP(*NEW)

     * プロトタイプの定義
    D ADDVAL      PR             9Z 0
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
    P ADDVAL      B
     * パラメーターインターフェース
    D ADDVAL      PI             9Z 0
    D  NUMBER                        9Z 0
    C*
    C                   RETURN    NUMBER + 100
    P                 E
```

**ポイント**:
- `ADDVAL` プロシージャ：引数に 100 を加算して返す
- `DFTACTGRP(*NO)` により ILE プログラムとして動作
- エクスポートプロシージャなので RPGUnit でテスト可能

---

## ステップ1: 事前準備（3分）

### 1.1 ソースファイルの作成とメンバーの転送

このソースを IBM i の `STUDYxx/QEOLRPGLE` に `ADDVAL` メンバーとして登録します。

以下のようにBobへ依頼してください：

```
STUDYxx/QEOLRPGLE に ADDVAL メンバーを作成して、
以下のソースを書き込んでください。

     H DFTACTGRP(*NO) ACTGRP(*NEW)

     * プロトタイプの定義
    D ADDVAL      PR             9Z 0
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
    P ADDVAL      B
     * パラメーターインターフェース
    D ADDVAL      PI             9Z 0
    D  NUMBER                        9Z 0
    C*
    C                   RETURN    NUMBER + 100
    P                 E
```

### 1.2 ワークスペースを Library List に切り替える

1. チャット入力欄の上部にある **New Task** をクリック
2. **「Library List」** を選択
3. `STUDYxx` ライブラリーが含まれていることを確認

### 1.3 IBM i Developer モードを選択

1. **チャットウィンドウ左下**のモード選択から **「IBM i Developer」** モードを選択

---

## ステップ2: ソースを読み込んで内容を把握する（3分）

改修前に対象プログラムの内容をBobに読み込ませ、現状を把握します。

```
STUDYxx/QEOLRPGLE の ADDVAL メンバーを読み込んで、
このプログラムの処理内容を日本語で説明してください。
```

**期待される動作**:
1. `read_member` ツールが `ADDVAL` を IBM i から直接取得
2. IBM i Developer モードのRPGスキルが解析
3. `ADDVAL` プロシージャの動作を日本語で説明

---

## ステップ3: ソースを改修する（5分）

`ADDVAL` プロシージャの加算値を **100 → 200** に変更します。

### 3.1 改修内容の指示

```
ADDVAL の ADDVAL プロシージャの加算値を 100 から 200 に変更してください。
変更後のソースを STUDYxx/QEOLRPGLE の ADDVAL メンバーに書き戻してください。
```

**期待される動作**:
1. Bobが `RETURN NUMBER + 100` の行を特定
2. `RETURN NUMBER + 200` に変更
3. `write_member` ツールで IBM i のソースメンバーに直接書き戻し

> 💡 **ポイント**: `write_member` ツールはPP4i固有です。Base Bobではソースをチャット上で確認するだけで、IBM i への書き戻しはできません。

### 3.2 コンパイル

```
STUDYxx/QEOLRPGLE の ADDVAL をコンパイルしてください。
```

**期待される動作**:
1. `execute_compile_action` ツールが `CRTBNDRPG` を実行
2. コンパイル結果（成功 / エラーメッセージ）をチャットに表示
3. エラーがあればBobが原因を説明・修正を提案

> ✅ **確認**: コンパイルが正常終了したことを確認してください。

---

## ステップ4: RPGUnit でテストする（7分）

### 4.1 テストスイートの生成をBobに依頼

```
STUDYxx/QEOLRPGLE の ADDVAL に対する
RPGUnit テストスイートのスタブを生成してください。
```

**期待される動作**:
1. `generate_rpg_unit_test_stub` ツールがテストスタブを自動生成
2. `ADDVAL` プロシージャ用のテストケースひな形を提示
3. テストファイルの保存先（例：`STUDYxx/QEOLRPGLE/ADDVALT`）を提案

**生成されるテストスタブ（イメージ）**:

```rpgle
**FREE
ctl-opt nomain;

/copy QUSRTOOL/QRPGLESRC,TESTCASE

dcl-pr ADDVAL int(10);
  NUMBER int(10) const;
end-pr;

dcl-proc testAddHundred export;
  dcl-pi *n end-pi;
  aEqual(300 : ADDVAL(100));   // 100 + 200 = 300
end-proc;
```

### 4.2 テストの実行

```
STUDYxx/QEOLRPGLE の ADDVALT テストスイートを実行してください。
```

**期待される動作**:
1. `run_rpg_unit_test_suite` ツールがテストをコンパイル・実行
2. テスト結果サマリー（成功 / 失敗件数）をチャットに表示

> ✅ **確認**: `testAddHundred` が成功することを確認してください。

### 4.3 わざと失敗させてみる（オプション）

テストが失敗するとどうなるか確認してみましょう：

```
ADDVAL の ADDVAL プロシージャの加算値を 300 に変更してコンパイルし、
テストを再実行してください。
```

テストが **FAIL** になり、期待値 `300` に対して実際の値 `400` がチャットに表示されます。  
これがRPGUnitの「デグレード検知」です。

---

## ✅ チェックポイント

このラボを完了したら、以下を確認してください：

- [ ] ワークスペースを Library List に切り替えられた
- [ ] `read_member` でソースを読み込み内容を把握できた
- [ ] Bobへの指示でソースを改修（100→200加算）できた
- [ ] `write_member` でIBM i に書き戻しできた
- [ ] コンパイルが成功した
- [ ] RPGUnit テストスタブを生成できた
- [ ] RPGUnit テストを実行して **PASS** を確認できた
- [ ] （オプション）意図的に FAIL させてデグレード検知を体験した

---

## 💡 このラボで学んだこと

### PP4i の開発サイクル

```
read_member（取得）
    ↓
Bob に改修を指示（自然言語）
    ↓
write_member（書き戻し）
    ↓
execute_compile_action（コンパイル）
    ↓
run_rpg_unit_test_suite（テスト）
```

### Base Bob と PP4i の比較

| 作業 | Base Bob | PP4i |
|-----|---------|------|
| ソース取得 | 手動でコピー＆ペースト | `read_member` で自動取得 |
| ソース改修 | ローカルで編集 | チャットで指示→自動編集 |
| IBM i への反映 | 手動でアップロード | `write_member` で自動書き戻し |
| コンパイル | 手動でCLコマンド | `execute_compile_action` |
| テスト実行 | 手動でRPGUnit起動 | `run_rpg_unit_test_suite` |

---

## 🎉 ラボ完了！

お疲れ様でした！PP4iを使ったRPGLEソースの改修・テストサイクルを体験しました。

### 次のステップ

準備ができたら、次のラボに進みましょう：

👉 **[LAB3-PP4i: ワークフローとスラッシュコマンドで業務を効率化](./LAB3-PP4i.md)** - Business Rules 抽出・RPG Modernization などのワークフローを体験します

---

**前のページ**: [LAB1-PP4i](./LAB1-PP4i.md) | **次のページ**: [LAB3-PP4i](./LAB3-PP4i.md)
