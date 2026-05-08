# AGENTS.md

このファイルは、このリポジトリでコードを扱うエージェント向けのガイダンスを提供します。

## プロジェクト概要
SAMCO（Sample Company）受注管理システムを使用したレガシーRPG/COBOLアプリケーションのモダナイゼーションを実証するIBM iモダナイゼーションラボ。

## ビルドコマンド
- **プロジェクトのビルド**: `/QOpenSys/pkgs/bin/makei build` (SAMCOディレクトリから)
- **単一ファイルのコンパイル**: `/QOpenSys/pkgs/bin/makei c -f {filename}` (SAMCOディレクトリから)
- **ビルドシステム**: makeiコマンドを使用したTobi（IBM iビルドツール）
- **ターゲットCCSID**: 37（.ibmi.jsonで設定）

## 重要な非自明パターン

### ファイル構成（直感に反する）
- **QPROTOSRC/**: プロシージャプロトタイプ（.RPGLEINCファイル）を含む - ソースコードではない
- **QRPGLESRC/**: 固定形式とフリー形式のRPGが混在 - ファイルヘッダーで形式を確認
- **common/SAMREF.PF**: すべてのフィールドタイプを定義する中央参照ファイル - DDSファイルでREF()を使用必須
- **Rules.mkファイル**: ビルド依存関係を定義 - 各サブディレクトリに独自のRules.mkがある

### RPGコード規約（コードベースから発見）
- **固定形式ファイル**: オペコードに小文字を使用（begsr、endsr、read、chain）
- **フリー形式ファイル**: 1行目に**FREEディレクティブを使用、プロシージャにPascalCaseを使用（Dcl-Proc）
- **サブルーチン**: レガシーコードはEXSR呼び出しでBEGSR/ENDSRを使用（s01lod、s01rst、s01savパターン）
- **インジケーター**: INDDSデータ構造で定義（ART200の16-33行）、スタンドアロンの*IN01ではない
- **ファイル命名**: 論理ファイルは数字で終わる（ARTICLE1、ARTICLE2）、物理ファイルは終わらない（ARTICLE）

### SQL統合（非標準アプローチ）
- **RLA/SQL混在**: 同じプログラムでCHAIN操作とExec SQLの両方を使用可能
- **カーソルパターン**: 一時変数をFETCHに使用し、その後データ構造にコピー（ART400の60-131行参照）
- **COALESCE必須**: LEFT JOINのnullable フィールドにはCOALESCEが必要（ART400の85-86行）
- **TEXTとLABEL**: DDSはTEXT()を使用、SQLはLABEL ONを使用（QSQLSRC/readme.md参照）

### サービスプログラム（隠れた依存関係）
- **SAMPLE.BNDDIR**: すべてのサービスプログラムを含む - H-specでBNDDIR()に必須
- **エクスポートシンボル**: .BNDファイルでは大文字のみ（FARTICLE.BNDはGETARTDESCを表示、GetArtDescではない）
- **プロトタイプの場所**: /copyディレクティブ経由でQPROTOSRC/*.RPGLEINCファイル、ソースファイル内ではない

### 表示ファイル（DDS固有）
- **サブファイルパターン**: 3つのレコード形式 - SFL（データ）、CTL（制御）、KEY（ファンクションキー）
- **インジケーター使用**: 30=SFLCLR、31=SFLDSP、32=SFLDSPCTL、80=SFLEND（ART200の25-33行参照）
- **位置復元**: s01rst/s01savサブルーチンがページロード間でSETLL位置を保存

### テスト/開発
- **単体テストなし**: これはデモ/ラボプロジェクト - パターンの理解に焦点
- **サンプルデータ**: QSQLSRC/POPULATE_SAMPLE_DATA.SQLを使用してテストデータを作成
- **ラボ構造**: LABs/ディレクトリに特定のBobプロンプト付きの3つの15分ラボ

## コードスタイル（プロジェクト固有のみ）

### 変数命名
- **レガシースタイル**: 2文字のプレフィックス + 説明（ARID=Article ID、ARDESC=Article Description）
- **モダンスタイル**: フリー形式でcamelCase（ART400のtempId、tempDesc）
- **定数**: アンダースコア付き大文字（コードベースには表示されていない - 変換時に使用）

### プロシージャ構造（フリー形式）
```rpgle
Dcl-Proc ProcedureName Export;  // サービスプログラムの場合のみExport
  Dcl-Pi *N LikeDs(ReturnType);
    parmName Type;
  End-Pi;
  
  // ローカル変数
  Dcl-S localVar Type;
  
  // ロジックをここに
  
  Return value;
End-Proc;
```

### エラー処理
- **SQL**: Exec SQL後にSQLCODEをチェック（0=成功、100=見つからない）
- **RLA**: %EOF()と%FOUND()組み込み関数を使用
- **try/catchなし**: RPGには例外がない - リターンコードをチェック

## モダナイゼーションパターン（ラボから）

### 固定形式からフリー形式への変換
- BEGSR/ENDSRをDcl-Proc/End-Procに置き換え
- EXSRを直接プロシージャ呼び出しに置き換え
- DOW/ENDDOの代わりにDoW/EndDoを使用
- 先頭にCtl-Optディレクティブを追加（**FREE、モジュールの場合はNoMain）

### RLAからSQLへの変換
- CHAIN → WHEREを使用したSELECT
- SETLL/READループ → FETCHループを使用したDECLARE CURSOR
- 複数のCHAIN操作 → JOINを使用した単一SELECT
- オプションの関係には常にLEFT JOINを使用

### 表示ファイルからウェブへ
- サブファイル → Reactテーブル/グリッドコンポーネント
- ファンクションキー → ボタンクリックハンドラー
- インジケーター → 状態変数
- EXFMT → API呼び出し + 状態更新