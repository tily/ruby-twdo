Twitter のプロフィールでタスク管理する TwDo コマンド
====================================================

使い方
------

 * 初期化する
 
        $ twdo init 牛乳買う ビデオ返す 印鑑会社に持ってく
        done.
 
 * 一覧を見る
 
        $ twdo list
        (0) [ ] 牛乳買う
        (1) [ ] ビデオ返す
        (2) [ ] 印鑑会社に持ってく
 
 * 追加する
 
        $ twdo add 田中さんに本返す 傘持って帰る
        done.
        $ twdo list
        (0) [ ] 牛乳買う
        (1) [ ] ビデオ返す
        (2) [ ] 印鑑会社に持ってく
        (3) [ ] 田中さんに本返す
        (4) [ ] 傘持って帰る
 
 * 削除する
 
        $ twdo del 0
        done.
        $ twdo del ビデオ返す          
        done.
        $ twdo list
        (0) [ ] 印鑑会社に持ってく
        (1) [ ] 田中さんに本返す
        (2) [ ] 傘持って帰る
 
 * 完了にする

        $ twdo done 0
        done.
        $ twdo done 傘持って帰る
        done.
        $ twdo list
        (0) [*] 印鑑会社に持ってく
        (1) [ ] 田中さんに本返す
        (2) [*] 傘持って帰る
 
 * 未完了にする

        $ twdo undo 0
        done.
        $ twdo undo 傘持って帰る
        done.
        $ twdo list
        (0) [ ] 印鑑会社に持ってく
        (1) [ ] 田中さんに本返す
        (2) [ ] 傘持って帰る
 
 * ヘルプを見る

        $ twdo help

インストール
-------------

        rake install

Copyright
---------

Copyright (c) 2010 tily. See LICENSE for details.
