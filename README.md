PixelShadow
===========
#####Pixel Shadow is a tool that generates the pixel datas for CSS3 box-shadow from any images.
######Note:Be carefull.It`s not the tool to create the "Drop Shadow".

How To Use
----------

### Pixel Size
You can set the size of 1dot.
box-shadow`s visual will be rough like a mosaic image if the 'Pixel Size' get bigger.
######Note:According to the box-shadow`s rule, each pixels are displayed twice the size of 'Pixel Size' basically.  
######Note:You can not set the bigger size than Image size to the 'Pixel Size'.

### Blur
You can set the Blur property for the pixels.

### Adjust Position
You can choose the coordinates of pixel. [Pixel Size or twice the size of Pixel Size]

### Shuffle Pixcel
The coordinates of each pixels will be exported randomly.
######Note:the counts of the pixels are same.

### Export CSS Code
The data will be exported as a css selector or the only box-shadow`s data.

### Preview
You can check the result with Webkit preview after the execution.

###Note:Please do not open the big images.It crashes.



PixelShadow(JP)
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

### Adjust Position
各ピクセルの座標の単位をPixel Sizeにするか、Pixel Sizeの2倍にするかを選択できます。

### Shuffle Pixcel
各ピクセルの座標をランダムに出力します。

### Export CSS Code
box-shadowの値のみを出力するか、CSSのセレクタコードとして出力するかを選択できます。

### Preview
Executeすると、結果をWebkitプレビューで確認できます。
