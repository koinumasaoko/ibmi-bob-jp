iproj.jsonで定義されたプロジェクトメタデータを使用した、複数のソースタイプを持つサンプルIBM iアプリケーション（SAMCO）。

最近、既存のグリーンスクリーンアプリケーションのリファクタリングに**#IBMBob**を使用しました。最初のフィードバックをお伝えします。リファクタリングの結果を確認するには、ブランチ[tobitest](https://github.com/bmarolleau/bob-ibmi-demo/tree/tobitest)を参照してください。私の経験：Bobプレビューバージョンを使用したユーザーエクスペリエンスは素晴らしかったです！数時間のガイド付きインタラクションで、BobとI私は、まったく新しいドキュメント、新しいフロントエンドアプリ、リファクタリングされたバックエンドプログラムを備えたアプリケーションの最初のバージョンを作成することができました。

初期プロンプト：
*Hello Bob, in this folder, a legacy application with various "IBM i" languages like RPG , CL, COBOL... I would like to modernize one screen/menu on Articles, could you generate architecture schemas and docs,  equivalent 'screens' in react (IBM Carbon Design System) with web service client to back-end. I'll create REST services from each service program.*

アプリケーションのビルドは、適切なmakeiコマンドを使用した[Tobi](https://ibm.github.io/ibmi-tobi/#/)で実行されます。IBM Bobが残りを行います。

Bobによって生成されたドキュメントは、[moderzation-plan](./modernization-plan/)ディレクトリに保存されています。

フロントエンドアプリケーションは、[article-management-web](./article-management-web)ディレクトリに生成されています。

**このリポジトリを使用して、自分で確認してテストしてください！！**

![alt text](image.png)