PixelShadow
===========
Pixel Shadowは画像ファイルからCSSのbox-shadowプロパティの値を生成するツールです。

How To Use
----------

### Pixel Size
1dotのサイズを指定できます。  
この値を大きくすると、画像は荒く(モザイクのように)なり、出力データ量は小さくなります。  
box-shadowでは、各ピクセルは指定値から各辺2倍の大きさで表示されます。  

###### 画像の幅または高さより大きな値は指定できません。

### Blur
各ピクセルのblurの量を指定できます。

#### Adjest Position
各ピクセルの座標の単位をPixel Sizeにするか、Pixel Sizeの2倍にするかを選択できます。

### Shuffle Pixcel
各ピクセルの座標をランダムに出力します。

### Export CSS Code
box-shadowの値のみを出力するか、CSSのセレクタコードとして出力するかを選択できます。

### Preview
Executeすると、結果をWebViewのプレビューで確認できます。
