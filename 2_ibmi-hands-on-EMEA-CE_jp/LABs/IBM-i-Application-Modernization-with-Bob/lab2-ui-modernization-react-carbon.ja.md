# Lab 101-2: ReactとCarbonでシンプルな商品リストを構築

## 概要
IBM Bobを使用して、ゼロから20分でモダンなウェブインターフェースを作成し、商品を表示します。IBM i接続は不要 - サンプルデータを使用します。

**所要時間**: 20分
**難易度**: 初級
**構築するもの**: 商品リストと検索機能を持つスタンドアロンReactアプリ

---

## 前提条件
- Node.jsがインストール済み（v18+）
- VS Codeがインストール済み
- IBM Bob AIアシスタントが利用可能
- ウェブ開発の基本的な理解

---

## ユースケース: 商品リストの表示

グリーンスクリーンに似ているが、モダンでレスポンシブな、検索機能付きのテーブルで商品を表示する完全なReactアプリケーションをゼロから作成します。

---

## ステップ0: 新しいReactプロジェクトの作成（3分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
Carbon Design Systemを使用して、ViteでReact + TypeScriptプロジェクトを新規作成してください。

要件：
- プロジェクト名: article-list-app
- 高速開発のためにViteを使用
- TypeScriptを含める
- Carbon Design System (@carbon/react)をインストール
- Carbonスタイルをインストール
- 基本的なプロジェクト構造をセットアップ

現在のディレクトリにプロジェクトを作成してください。

英語版 / English Version:
Create a new React + TypeScript project using Vite with Carbon Design System.

Requirements:
- Project name: article-list-app
- Use Vite for fast development
- Include TypeScript
- Install Carbon Design System (@carbon/react)
- Install Carbon styles
- Set up basic project structure

Create the project in the current directory.
```

**期待される出力:**
Bobが以下を含む新しいReactプロジェクトを作成：
- Vite設定
- TypeScriptセットアップ
- Carbon Design Systemがインストール済み
- 基本的なフォルダ構造（src/、public/など）

**手動の代替方法（必要な場合）:**
```bash
npm create vite@latest article-list-app -- --template react-ts
cd article-list-app
npm install
npm install @carbon/react @carbon/styles
```

---

## ステップ1: Bobにグリーンスクリーンレイアウトの表示を依頼（2分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
@SAMCO/QDDSSRC/ART200D-Work_with_Article.DSPF

商品リスト画面（SFL01）がどのように見えるか見せてください。
以下を示すASCIIアートで描いてください：
- ヘッダー "Work with Articles"
- 列ヘッダー（Opt, Id, Description, Fam, Del）
- 3行のサンプルデータ
- シンプルに保つ

英語版 / English Version:
@SAMCO/QDDSSRC/ART200D-Work_with_Article.DSPF

Show me what the article list screen (SFL01) looks like.
Draw it as ASCII art showing:
- The header "Work with Articles"
- Column headers (Opt, Id, Description, Fam, Del)
- 3 sample rows of data
- Keep it simple
```

**確認すべきポイント:**
- Bobが24x80文字の画面レイアウトを表示
- 列構造が見える
- 表示されるデータを理解

---

## ステップ2: Bobにサンプルデータの作成を依頼（3分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
ART400構造に基づいて、10個のサンプル商品を含むTypeScriptファイルを作成してください。

各商品には以下を含める：
- id（"ART001"のような6文字）
- description（50文字）
- familyCode（"ELE"のような3文字）
- familyDescription（"Electronics"のような）
- salePrice（数値）
- stock（数値）

以下に保存：article-list-app/src/data/sampleArticles.ts

英語版 / English Version:
Create a TypeScript file with 10 sample articles based on the ART400 structure.

Each article should have:
- id (6 chars like "ART001")
- description (50 chars)
- familyCode (3 chars like "ELE")
- familyDescription (like "Electronics")
- salePrice (number)
- stock (number)

Save it as: article-list-app/src/data/sampleArticles.ts
```

**期待される出力:**
Bobが開発に使用できるサンプルデータを含むファイルを作成。

---

## ステップ3: Bobに商品リストコンポーネントの作成を依頼（5分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
Carbon DataTableで商品を表示するReactコンポーネントを作成してください。

要件：
- Carbon Design System DataTableコンポーネントを使用
- 列を表示：ID、Description、Family、Price、Stock
- 上部に検索ボックスを追加
- sampleArticles.tsのサンプルデータを使用
- シンプルに保つ - 表示のみ、編集/削除はまだなし

以下に保存：article-list-app/src/components/SimpleArticleList.tsx

英語版 / English Version:
Create a React component that displays articles in a Carbon DataTable.

Requirements:
- Use Carbon Design System DataTable component
- Show columns: ID, Description, Family, Price, Stock
- Add a Search box at the top
- Use the sample data from sampleArticles.ts
- Keep it simple - just display, no edit/delete yet

Save as: article-list-app/src/components/SimpleArticleList.tsx
```

**期待される出力:**
Bobが以下を含むコンポーネントを作成：
- Carbon DataTable
- 検索機能
- サンプルデータが表示

---

## ステップ4: Bobにメインアプリのセットアップを依頼（3分）

**Bobへのプロンプト:**
```
日本語版 / Japanese Version:
article-list-app/src/App.tsxを更新して、SimpleArticleListコンポーネントを表示してください。

要件：
- Carbonスタイルをインポート（@carbon/styles/css/styles.css）
- SimpleArticleListコンポーネントをインポート
- Carbon Themeでメインアプリに表示
- タイトル"Article Management"を追加
- Carbonのwhiteテーマを使用

英語版 / English Version:
Update article-list-app/src/App.tsx to display the SimpleArticleList component.

Requirements:
- Import Carbon styles (@carbon/styles/css/styles.css)
- Import the SimpleArticleList component
- Display it in the main app with Carbon Theme
- Add a title "Article Management"
- Use Carbon's white theme
```

**期待される出力:**
BobがApp.tsxを更新して新しいコンポーネントを表示。

---

## ステップ5: 実行とテスト（2分）

**アプリケーションの実行:**
```bash
cd article-list-app
npm run dev
```

**テスト:**
1. ブラウザでhttp://localhost:5173を開く（またはターミナルに表示されたURL）
2. 商品リストが表示されることを確認
3. 検索ボックスを試す
4. データが正しく表示されることを確認
5. ブラウザをリサイズしてレスポンシブデザインをテスト

---

## ✅ 成功基準

以下の条件を満たせば、このラボは正常に完了です：
- [ ] ゼロから新しいReactプロジェクトを作成
- [ ] グリーンスクリーンレイアウトを確認（ステップ1）
- [ ] サンプルデータファイルを作成
- [ ] 商品リストがブラウザに表示
- [ ] 検索機能が動作
- [ ] テーブルがすべての列を正しく表示
- [ ] アプリケーションが独立して実行

---

## 構築したもの

```
┌─────────────────────────────────────────┐
│     Article Management (Modern Web)     │
├─────────────────────────────────────────┤
│ Search: [____________]                  │
├─────────────────────────────────────────┤
│ ID     │ Description      │ Family │... │
├────────┼──────────────────┼────────┼────┤
│ ART001 │ Laptop Computer  │ ELE    │... │
│ ART002 │ Office Chair     │ FUR    │... │
│ ART003 │ Printer          │ ELE    │... │
└─────────────────────────────────────────┘
```

**対 グリーンスクリーン:**
```
┌────────────────────────────────────────┐
│ Work with Articles          12/15/2025 │
│ Opt  Id     Description         Fam    │
│ [_]  000001 Laptop Computer     ELE    │
│ [_]  000002 Office Chair        FUR    │
│ [_]  000003 Printer             ELE    │
└────────────────────────────────────────┘
```

---

## 重要なポイント

1. **スタンドアロン開発**: ゼロから完全なReactアプリを作成
2. **Bobが視覚化を支援**: Bobにレガシー画面を表示するよう依頼
3. **サンプルデータを最初に**: モックデータから開始し、後で実際のAPIに接続
4. **Carbonコンポーネント**: 事前構築されたプロフェッショナルなUIコンポーネント
5. **段階的開発**: シンプルに開始し、後で機能を追加

---

## プロジェクト構造

完了後、プロジェクトは次のようになります：
```
article-list-app/
├── src/
│   ├── components/
│   │   └── SimpleArticleList.tsx
│   ├── data/
│   │   └── sampleArticles.ts
│   ├── App.tsx
│   └── main.tsx
├── package.json
└── vite.config.ts
```

---

## 次のステップ

**さらに機能を追加（オプション）:**
- Bobに「商品作成」ボタンの追加を依頼
- Bobに行アクション（編集、削除）の追加を依頼
- Bobにページネーションの追加を依頼
- Bobにソートとフィルタリングの追加を依頼

**実際のデータに接続:**
- REST APIバックエンドを作成（Lab 101-3参照）
- Bobにコンポーネントを実際のAPIに接続するよう依頼
- サンプルデータをAPI呼び出しに置き換え

**アプリをデプロイ:**
- Bobに本番用ビルドの支援を依頼（`npm run build`）
- Vercel、Netlify、または好みのホスティングにデプロイ

**自分で試す:**
- サンプルデータを変更
- 表示される列を変更
- カスタムスタイリングを追加
- ダークモードトグルを実装