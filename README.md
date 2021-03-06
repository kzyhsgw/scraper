**museum-app(仮)**  
*-限られた時間の中で効率よく美術館を巡りたい方へ-*

- スクレイピング先「美術館・アート情報 artscape」
- 会場名の類推と緯度・経度「Google Maps JavaScript API」
- 電車の移動時間「Tokyo乗り換えAPI」
- 最寄り駅とそこまでの距離「HeartRails Express」
- 最短経路計算「ダイクストラアルゴリズム」(予定)

[本番環境へはこちらのリンクをお進みください。](https://scraper-35207.herokuapp.com/)  
BASIC認証  
ID: admin  
PASS: 2222  

### 使い方
1. ページを訪れていただくと、現在東京都で行われている展覧会の一覧が表示されます
2. プルダウンメニューから展覧会の会場名を選択すると経度と緯度が表示されます
3. ３つ選んでいただいて、検索ボタンを押してください
4. 最短経路と所要時間が表示されます（現在はスタート品川駅、ゴール東京駅で固定されています）

### 仕組み
1. 展覧会の情報は『Mechanize』というRubyのライブラリでスクレイピングしています
2. 緯度・経度は『Google Maps API』を利用しています、会場名はメディアによって一意でないことがありますがAPIの力でそれをクリアしました
3. 取得した座標はフォームのhidden属性要素にも格納されパラメータとしてRailsアクションへ引き渡されます
4. 位置情報をもとに『HeartRails Express』で最寄り駅を決定します、それを使い『Tokyo乗り換えAPI』から全ての会場間の所要時間を取得します、そして全ての組み合わせの中で最も早い順路を表示します

### 展望
1. アルゴリズムを理解して目的地の数に寄らない検索を可能にする、電車の所要時間は向きによって変わるため単純な最短経路理論では上手く行かない
2. 自動で定期的にスクレイピングさせる、カウントをデータベースに記録するなど方法は考えられるがまずは常套手段を学ぶ
3. 検索結果に展覧会の画像やurlなどを記載し美しくする
4. API間の表記ゆれによるエラーを解消する

### 感想
プログラミングを始めて2ヶ月、始めて一人で作った一生心に残るアプリです。JavaScriptとRailsアクションの混在による通信エラーに悩まされました。『Google Maps API』では日本の公共交通機関の経路を取得できないことなど、勉強の少し外のビジネス的な制約を経験できました。ようやくできたかと本番環境に移すと、これまた『Heroku』のクエリ数の制約に悩まされました。ここでも解決には総合的な知識が必要になると現場の難しさを想像でき恐くもあり楽しみでもあります。
