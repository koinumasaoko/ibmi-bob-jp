# IBM i アプリケーションモダナイゼーション ハンズオン (EMEA CE版 日本語化)

## 概要

IBM Bob AIアシスタントを使用してIBM iモダナイゼーションを学ぶための3つのシンプルな15分ラボ。各ラボは、すぐに完了できる1つの実践的なユースケースに焦点を当てています。

アプリケーションSAMCOは、シンプルな受注管理システムです。グリーンスクリーンインターフェースと20年以上前のRPGコードを持っています。IBM iプラットフォームでのモダナイゼーションの恩恵を受けられるシステムの良い例です！

![alt text](LABs/IBM-i-Application-Modernization-with-Bob/pics/green-screen-to-react.png)

---

## 🎯 ラボ

### Lab 101-1: RPG固定形式からフリー形式への変換
**所要時間**: 15分 | **ファイル**: [lab1-rpg-documentation-fixed-to-free.ja.md](LABs/IBM-i-Application-Modernization-with-Bob/lab1-rpg-documentation-fixed-to-free.ja.md)

**実施内容:**
- Bobにレガシー RPGコードの説明を依頼
- 1つのサブルーチンを固定形式からフリー形式に変換
- マジックナンバーを名前付き定数に置き換え

**ユースケース**: サブファイルロードロジック（s01lod）をモダンRPGに変換

---

### Lab 101-2: シンプルな商品リストの構築
**所要時間**: 15分 | **ファイル**: [lab2-ui-modernization-react-carbon.ja.md](LABs/IBM-i-Application-Modernization-with-Bob/lab2-ui-modernization-react-carbon.ja.md)

**実施内容:**
- Bobにグリーンスクリーンレイアウトの表示を依頼
- Bobの支援でサンプルデータを作成
- 検索機能付きのモダンなウェブテーブルを構築

**ユースケース**: Carbon Design Systemを使用してウェブブラウザで商品を表示

---

### Lab 101-3: RLAからSQLへの変換
**所要時間**: 15分 | **ファイル**: [lab3-dds-to-sql-rla-refactoring.ja.md](LABs/IBM-i-Application-Modernization-with-Bob/lab3-dds-to-sql-rla-refactoring.ja.md)

**実施内容:**
- BobにCHAIN操作の説明を依頼
- SQL SELECTに変換
- JOINを使用して1つのクエリで関連データを取得

**ユースケース**: 商品検索をRLAからJOINを使用したSQLに変換

---

## 🚀 クイックスタート

### 前提条件
- このプロジェクトを開いたVS Code
- IBM Bob AIアシスタントが利用可能
- Lab 2用: Node.jsがインストール済み

### ラボの開始方法
1. ラボのマークダウンファイルを開く
2. 順番に手順に従う
3. プロンプトをコピーしてBobに質問
4. Bobの応答を確認
5. 成功基準を完了

---

## 💡 これらのラボの使用方法

### Bobとの作業

各ラボには、Bobに質問する**特定のプロンプト**があります。例：

```
@SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE

Explain what the s01lod subroutine does (lines 102-118).
```

**ヒント:**
- ✅ プロンプトを表示されたとおりに正確にコピー
- ✅ 指定された場合は@ファイル参照を含める
- ✅ Bobの応答を注意深く読む
- ✅ 不明な場合はフォローアップの質問をする

---

## 📚 学習内容

### Lab 1のスキル
- レガシーRPGコードの理解
- 固定形式からフリー形式への変換
- サブルーチンの代わりにプロシージャを使用
- 保守性のための名前付き定数

### Lab 2のスキル
- グリーンスクリーンレイアウトの視覚化
- サンプルデータの作成
- モダンなウェブUIの構築
- Carbon Design Systemコンポーネントの使用

### Lab 3のスキル
- RLA操作の理解
- SQLへの変換
- 関連データのためのJOINの使用
- SQLパフォーマンスの利点

---

## 🎓 学習パス

**推奨順序:**

```
ここから開始
    ↓
Lab 101-1 (RPG基礎)
    ↓
Lab 101-3 (SQL変換)
    ↓
Lab 101-2 (ウェブUI)
    ↓
完了！ 🎉
```

**またはLab 2から開始**してウェブUIを最初に見ることもできます！

---

## ✅ 成功基準

### Lab 1
- [ ] Bobが固定形式コードを説明
- [ ] コードがフリー形式に変換
- [ ] マジックナンバーが定数に置き換え

### Lab 2
- [ ] グリーンスクリーンレイアウトが視覚化
- [ ] サンプルデータが作成
- [ ] 商品リストがブラウザに表示
- [ ] 検索が機能

### Lab 3
- [ ] CHAIN操作が説明
- [ ] SQL SELECTに変換
- [ ] 関連データのためのJOINが追加
- [ ] 利点が理解

---

## 🔧 トラブルシューティング

### Bobが応答しない？
- 接続を確認
- 質問を言い換えてみる
- ファイル参照が正しいことを確認

### Lab 2 - npm installが失敗？
```bash
cd article-management-web
rm -rf node_modules package-lock.json
npm install
```

### Lab 3 - SQL構文エラー？
- 動作例についてはART400.SQLRPGLEファイルを確認
- Bobにエラーの説明を依頼

---

## 📖 参照ファイル

ラボで使用されるファイル：

| ファイル | 使用ラボ | 目的 |
|------|---------|---------|
| `SAMCO/QRPGLESRC/ART200-Work_with_article.PGM.SQLRPGLE` | Lab 1, 3 | レガシーRPGプログラム |
| `SAMCO/QDDSSRC/ART200D-Work_with_Article.DSPF` | Lab 2 | グリーンスクリーン定義 |
| `SAMCO/QRPGLESRC/ART400.SQLRPGLE` | Lab 3 | モダンSQL例 |
| `article-management-web/` | Lab 2 | Reactアプリケーション |

---

## 🎯 ラボ完了後

### 次のステップは？

**スキルを拡張:**
- ART200でさらにサブルーチンを変換
- ウェブUIに編集/削除を追加
- さらにRLA操作をSQLに変換

**自分のコードに適用:**
- アプリケーションで類似のパターンを特定
- 小さく、リスクの低い変更から開始
- Bobを使用して変換を支援

**さらに学習:**
- 完全なART400サービスプログラムを探索
- 完全なReactアプリケーションを研究
- modernization-plan/ディレクトリを確認

---

## 💬 ヘルプの取得

**Bobに質問:**
- "このコードを説明してください"
- "これをフリー形式に変換するにはどうすればよいですか？"
- "このRLA操作のSQL相当は何ですか？"
- "...の例を見せてください"

**よくある質問:**

**Q: IBM iシステムが必要ですか？**  
A: Lab 2には不要です。Lab 1と3はコードファイルのみで動作します。

**Q: ラボをスキップできますか？**  
A: はい！各ラボは独立しています。

**Q: 各ラボは実際にどのくらいかかりますか？**  
A: プロンプトに従えば15分です。探索したい場合はもっと時間をかけてください！

---

## 📝 ラボ形式

各ラボは次のシンプルな構造に従っています：

1. **概要** - 構築するもの
2. **前提条件** - 必要なもの
3. **ユースケース** - 実践的な例
4. **手順** - Bobプロンプト付きの4-5のシンプルな手順
5. **成功基準** - 完了したことを知る方法
6. **重要なポイント** - 学んだこと
7. **次のステップ** - ここからどこへ行くか

---

## 🌟 成功のためのヒント

1. **プロンプトに従う**: Bobで動作するように設計されています
2. **Bobの応答を読む**: コードをコピーするだけでなく、理解する
3. **一度に1ステップ**: 次に進む前に各ステップを完了
4. **質問する**: Bobはヘルプのためにあります - 使用してください！
5. **楽しむ**: モダナイゼーションは怖くありません！

---

## 📊 時間の内訳

| ラボ | セットアップ | 手順 | レビュー | 合計 |
|-----|-------|-------|--------|-------|
| Lab 1 | 2分 | 10分 | 3分 | 15分 |
| Lab 2 | 2分 | 10分 | 3分 | 15分 |
| Lab 3 | 2分 | 10分 | 3分 | 15分 |
| **全3つ** | | | | **45分** |

---

## 📂 ファイル構成

```
2_ibmi-hands-on-EMEA-CE_jp/
├── README.md                    # このファイル
├── AGENTS.md                    # AIアシスタント向けガイド
└── LABs/
    └── IBM-i-Application-Modernization-with-Bob/
        ├── lab1-*.ja.md        # Lab 1（日本語）
        ├── lab2-*.ja.md        # Lab 2（日本語）
        ├── lab3-*.ja.md        # Lab 3（日本語）
        └── SAMCO/              # サンプルアプリケーション
            ├── iproj.json      # プロジェクト設定
            ├── README.ja.md    # SAMCOの説明
            ├── QPROTOSRC/      # プロトタイプ
            ├── QRPGLESRC/      # RPGLEソース
            ├── QSQLSRC/        # SQLソース
            └── ...             # その他のソースファイル
```

---

## 📖 ドキュメント

- **[AGENTS.md](AGENTS.md)** - AIアシスタント向けのプロジェクトガイダンス
- **[SAMCO README](LABs/IBM-i-Application-Modernization-with-Bob/SAMCO/README.ja.md)** - サンプルアプリケーションの説明
- **[QPROTOSRC README](LABs/IBM-i-Application-Modernization-with-Bob/SAMCO/QPROTOSRC/README.ja.md)** - プロトタイプの説明
- **[QSQLSRC README](LABs/IBM-i-Application-Modernization-with-Bob/SAMCO/QSQLSRC/readme.ja.md)** - SQLソースの説明

---

## 🎉 おめでとうございます！

これらのラボを完了すると、次のことができるようになります：
- ✅ Bobを使用してRPGコードを理解しモダナイゼ
- ✅ IBM iアプリケーション用のモダンなウェブインターフェースを構築
- ✅ RLA操作をSQLに変換
- ✅ これらのパターンを自分のコードに適用

**学習とモダナイゼーションを続けましょう！** 🚀

---

## 📚 追加リソース

- **IBM Bobドキュメント**: Bobに"効果的に使用する方法は？"と質問
- **Carbon Design System**: https://carbondesignsystem.com/
- **RPG Cafe**: https://www.rpgpgm.com/
- **IBM i Modernization**: https://www.ibm.com/support/pages/ibm-i-modernization

---

## 📝 ライセンスと謝辞

このプロジェクトは、IBM Bob Client Engineering EMEAチームのオリジナル作品を基に、日本語化および日本市場向けにカスタマイズされたものです。

**オリジナル作成者**: IBM Bob Client Engineering EMEA Team  
**日本語化**: IBM Japan

---

## 🤝 貢献

改善提案やバグ報告は、Issueまたはプルリクエストでお願いします。

---

*これらのラボは初心者向けに設計されています。事前のモダナイゼーション経験は不要です！*
