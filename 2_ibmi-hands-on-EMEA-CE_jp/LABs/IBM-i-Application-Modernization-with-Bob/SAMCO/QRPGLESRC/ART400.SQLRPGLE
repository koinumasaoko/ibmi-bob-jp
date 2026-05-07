**FREE
//==============================================================================
// プログラム: ART400 - 商品REST APIサービスプログラムモジュール
// Program: ART400 - Article REST API Service Program Module
// 説明: すべての商品をリストするシンプルなREST API
// Description: Simple REST API to list all articles
//              IBM i統合Webサービス（IWS）用に設計
//              Designed for IBM i Integrated Web Services (IWS)
// 作成者: 商品管理モダナイゼーション用に生成
// Author: Generated for Article Management Modernization
// 日付: 2025-12-17
// Date: 2025-12-17
//==============================================================================

Ctl-Opt NoMain PGMINFO(*PCML : *MODULE : *DCLCASE);
Ctl-Opt DatFmt(*ISO);
Ctl-Opt TimFmt(*ISO);


// IFSからフィールド定義をコピー
// Copy field definitions from IFS
/copy QPROTOSRC/ARTICLE

//==============================================================================
// 商品リスト項目のデータ構造
// Data Structure for Article List Item
//==============================================================================
Dcl-Ds ArticleItem Qualified Template;
  id Char(6);                      // 商品ID / Article ID
  description Char(50);            // 説明 / Description
  familyCode Char(3);              // ファミリーコード / Family Code
  familyDescription Char(50);      // ファミリー説明 / Family Description
  vatCode Char(1);                 // VATコード / VAT Code
  vatRate Packed(4:2);             // VAT率 / VAT Rate
  salePrice Packed(7:2);           // 販売価格 / Sale Price
  warehousePrice Packed(7:2);      // 倉庫価格 / Warehouse Price
  stock Packed(5:0);               // 在庫 / Stock
  minimumQuantity Packed(5:0);     // 最小数量 / Minimum Quantity
  deleted Char(1);                 // 削除フラグ / Deleted Flag
End-Ds;

//==============================================================================
// 商品リストレスポンスのデータ構造
// Data Structure for Article List Response
// IWSが自動的にJSONに変換
// IWS will automatically convert this to JSON
//==============================================================================
Dcl-Ds ArticleListResponse Qualified Template;
  success Ind;                                    // 成功フラグ / Success Flag
  message Char(256);                              // メッセージ / Message
  totalRecords Int(10);                           // 総レコード数 / Total Records
  articleData LikeDs(ArticleItem) Dim(1000);      // 商品データ（最大1000件）/ Article Data (Max 1000)
  articleCount Int(10);                           // 商品数 / Article Count
End-Ds;

//==============================================================================
// プロシージャ: ListAllArticles
// Procedure: ListAllArticles
// 説明: すべての商品を取得（ページネーションなし）
// Description: Get all articles (no pagination)
// パラメータ: なし
// Parameters: None
// 戻り値: データ構造（IWSがJSONに変換）
// Returns: Data structure (IWS converts to JSON)
//==============================================================================
Dcl-Proc ListAllArticles Export;
  Dcl-Pi *N LikeDs(ArticleListResponse);
  End-Pi;

  Dcl-Ds response LikeDs(ArticleListResponse);
  Dcl-S i Int(10);
  
  // SQL FETCH用の一時変数（配列要素に直接FETCHできないため）
  // Temporary variables for SQL FETCH (cannot FETCH directly into array elements)
  Dcl-S tempId Char(6);
  Dcl-S tempDesc Char(50);
  Dcl-S tempFamCode Char(3);
  Dcl-S tempFamDesc Char(50);
  Dcl-S tempVatCode Char(1);
  Dcl-S tempVatRate Packed(4:2);
  Dcl-S tempSalePrice Packed(7:2);
  Dcl-S tempWhsPrice Packed(7:2);
  Dcl-S tempStock Packed(5:0);
  Dcl-S tempMinQty Packed(5:0);
  Dcl-S tempDeleted Char(1);

  // レスポンスを初期化
  // Initialize response
  Clear response;
  response.success = *Off;
  response.articleCount = 0;

  // すべての商品用のカーソルを宣言
  // Declare cursor for all articles
  Exec SQL
    DECLARE C1 CURSOR FOR
    SELECT
      A.ARID,
      A.ARDESC,
      A.ARTIFA,
      COALESCE(F.FADESC, ''),      // nullの場合は空文字列 / Empty string if null
      A.ARVATCD,
      COALESCE(V.VATRATE, 0),      // nullの場合は0 / 0 if null
      A.ARSALEPR,
      A.ARWHSPR,
      A.ARSTOCK,
      A.ARMINQTY,
      A.ARDEL
    FROM ARTICLE A
    LEFT JOIN FAMILLY F ON A.ARTIFA = F.FAID
    LEFT JOIN VATDEF V ON A.ARVATCD = V.VATCODE
    WHERE A.ARDEL = ' '            // 削除されていない商品のみ / Only non-deleted articles
    ORDER BY A.ARID;

  Exec SQL OPEN C1;

  If SQLCODE = 0;                  // カーソルが正常にオープン / Cursor opened successfully
    i = 1;
    DoU SQLCODE <> 0 Or i > 1000;  // 最大1000件の商品 / Max 1000 articles
      Exec SQL
        FETCH C1 INTO
          :tempId,
          :tempDesc,
          :tempFamCode,
          :tempFamDesc,
          :tempVatCode,
          :tempVatRate,
          :tempSalePrice,
          :tempWhsPrice,
          :tempStock,
          :tempMinQty,
          :tempDeleted;

      If SQLCODE = 0;              // レコードが見つかった / Record found
        // 一時変数を配列要素にコピー
        // Copy temp variables to array element
        response.articleData(i).id = tempId;
        response.articleData(i).description = tempDesc;
        response.articleData(i).familyCode = tempFamCode;
        response.articleData(i).familyDescription = tempFamDesc;
        response.articleData(i).vatCode = tempVatCode;
        response.articleData(i).vatRate = tempVatRate;
        response.articleData(i).salePrice = tempSalePrice;
        response.articleData(i).warehousePrice = tempWhsPrice;
        response.articleData(i).stock = tempStock;
        response.articleData(i).minimumQuantity = tempMinQty;
        response.articleData(i).deleted = tempDeleted;
        i += 1;
      EndIf;
    EndDo;

    response.articleCount = i - 1;
    response.totalRecords = response.articleCount;
    response.success = *On;
    response.message = 'Articles retrieved successfully';
  Else;                            // カーソルオープンエラー / Cursor open error
    response.message = 'Error opening cursor: ' + %Char(SQLCODE);
  EndIf;

  Exec SQL CLOSE C1;               // カーソルをクローズ / Close cursor

  Return response;                 // レスポンスを返す / Return response
End-Proc;