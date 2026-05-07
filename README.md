# IBM Bob for IBM i - 日本語リソース

IBM BobをIBM i開発で活用するための日本語リソース集です。

## 📚 このリポジトリについて

このリポジトリは、IBM iのユーザーとビジネス・パートナーがIBM Bobを使ってIBM i開発を効率化する方法を学ぶための教材を提供します。

## 🎯 対象者

- IBM i 開発者
- IBM i システムの保守担当者
- レガシーコードの理解・モダナイゼーションに取り組む方
- IBM Bobを初めて使う方

## 📁 コンテンツ

### 1. IBM i 開発ハンズオン（日本テクニカルセールス版）

IBM BobをIBM i開発で活用する方法を学ぶ実践的なハンズオン資料です。

📖 **[1_ibmi-hands-on-JPAN-TechSales](./1_ibmi-hands-on-JPAN-TechSales/ハンズオン資料/README.md)**

**内容:**
- LAB1: 既存プログラムの理解（RPGコードの解析）
- LAB2: プログラムの修正（画面・プログラムへの項目追加）
- LAB3: 新規プログラムの作成（ゼロからの開発）

**所要時間:** 約60分
**難易度:** 初級〜中級

**サンプルプログラム:**
- RPG III/ILE プログラム
- 画面ファイル（DDS）
- データベースファイル
- QEOL400実習回答からの抜粋

### 2. IBM i アプリケーションモダナイゼーション ハンズオン（EMEA CE版）

IBM Bob Client Engineering EMEAチームが作成したモダナイゼーションのハンズオン資料（日本語化版）です。

📖 **[2_ibmi-hands-on-EMEA-CE_jp](./2_ibmi-hands-on-EMEA-CE_jp/README.md)**

**内容:**
- Lab 101-1: RPG固定形式からフリー形式への変換（15分）
- Lab 101-2: シンプルな商品リストの構築 - グリーンスクリーンからReact UIへ（15分）
- Lab 101-3: RLAからSQLへの変換（15分）

**所要時間:** 各15分（合計45分）
**難易度:** 初級

**特徴:**
- 実践的な15分の短いラボ
- SAMCOサンプルアプリケーション（受注管理システム）
- モダンなウェブUI（React + Carbon Design System）
- SQL変換の実践

## 🚀 クイックスタート

### リポジトリの取得

**Git cloneで取得（推奨）:**
```bash
git clone https://github.com/koinumasaoko/ibmi-bob-jp.git
cd ibmi-bob-jp
```

**ZIPファイルでダウンロード:**
1. GitHubの「Code」→「Download ZIP」
2. ZIPを解凍

### ハンズオンを始める

**日本テクニカルセールス版（基礎編）:**
```bash
cd 1_ibmi-hands-on-JPAN-TechSales/ハンズオン資料
```
📖 **[README.md](./1_ibmi-hands-on-JPAN-TechSales/ハンズオン資料/README.md)** を開いて、詳細な手順を確認してください。

**EMEA CE版（モダナイゼーション編）:**
```bash
cd 2_ibmi-hands-on-EMEA-CE_jp
```
📖 **[README.md](./2_ibmi-hands-on-EMEA-CE_jp/README.md)** を開いて、詳細な手順を確認してください。

## ✅ 前提条件

- IBM Bobアカウント（[30日間無料トライアル](https://bob.ibm.com/trial)）
- Bob IDE（[ダウンロード](https://bob.ibm.com/download)）
- Webブラウザ（Chrome、Firefox、Safari、Edge等）
- インターネット接続

## 💡 IBM Bobとは

IBM Bob（watsonx Code Assistant）は、AI駆動の開発アシスタントです。

**主な機能:**
- コードの理解と解析
- コードの自動生成
- コードレビューと品質向上
- ドキュメントの自動作成
- 多言語対応（RPG、COBOL、Java、Python等）

## 🎓 学習成果

このリポジトリの教材を完了すると、以下ができるようになります：

✅ IBM Bobを使ってRPGコードを理解できる  
✅ IBM Bobを使って既存コードを修正できる  
✅ IBM Bobを使って新規プログラムを作成できる  
✅ IBM i開発の生産性を大幅に向上できる  
✅ レガシーコードの保守・モダナイゼーションを効率化できる

## 🔗 関連リソース

### IBM Bob 公式
- [IBM Bob 公式サイト](https://www.ibm.com/products/watsonx-code-assistant)
- [IBM Bob ドキュメント](https://www.ibm.com/docs/en/watsonx-code-assistant)

### IBM i 関連
- [IBM i Information Center](https://www.ibm.com/support/pages/ibm-i-documentation)
- [RPG Programmer's Guide](https://www.ibm.com/support/pages/rpg-programmers-guide)
- [IBM i QEOL サンプルプログラム](https://community.ibm.com/community/user/viewdocument/ibm-i-qeol?CommunityKey=2bf1e52c-a706-482b-86e8-018e81a19ab5&tab=librarydocuments)

## 📝 コンテンツ一覧

| ディレクトリ | 内容 | 対象 | 状態 |
|------------|------|------|------|
| [1_ibmi-hands-on-JPAN-TechSales](./1_ibmi-hands-on-JPAN-TechSales/) | IBM i開発ハンズオン（LAB1-3）<br>基礎編：コード理解・修正・作成 | 初心者〜中級者 | ✅ 公開中 |
| [2_ibmi-hands-on-EMEA-CE_jp](./2_ibmi-hands-on-EMEA-CE_jp/) | アプリケーションモダナイゼーション<br>RPG変換・UI刷新・SQL移行 | 初心者〜中級者 | ✅ 公開中 |

## 🤝 コントリビューション

このリポジトリへの貢献を歓迎します！

- バグ報告: Issueを作成してください
- 改善提案: Pull Requestを送ってください
- 質問: Discussionsで質問してください

## 📄 ライセンス

© 2026 IBM Corporation. All rights reserved.

## 📧 お問い合わせ

このリポジトリに関するご質問は、IBM担当者までお問い合わせください。

---

<<<<<<< HEAD
**さあ、始めましょう！**

👉 **基礎から学ぶ**: [IBM i開発ハンズオン（日本テクニカルセールス版）](./1_ibmi-hands-on-JPAN-TechSales/ハンズオン資料/README.md)

👉 **モダナイゼーションを学ぶ**: [アプリケーションモダナイゼーション（EMEA CE版）](./2_ibmi-hands-on-EMEA-CE_jp/README.md)
=======
**さあ、始めましょう！** 👉 [IBM i 開発ハンズオンを開く](./1_ibmi-hands-on/ハンズオン資料/README.md)
>>>>>>> 8f9c01326e6dba339d25d4b4f6480580dd3bf972
