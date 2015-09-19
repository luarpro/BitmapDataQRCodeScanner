BitmapDataQRCodeScanner (ANE)
=============================

Flash AIR Native Extension:  QRCode reader/decoder which accept BitmapData, therefore you can design your own scanner UI, adding overlay image, without launch  fullscreen native Camera UI


Setup in application.xml
========================
for Android, include the followings inside &lt;android&gt;&lt;manifestAdditions&gt;...&lt;/manifestAdditions&gt;&lt;/android&gt;
　<pre><code>&lt;uses-permission android:name="android.permission.CAMERA"/&gt;
&lt;uses-feature android:name="android.hardware.camera" /&gt;</code></pre>
for both iOS and Android, include the followings inside &lt;extensions&gt;...&lt;/extensions&gt;
　<pre><code>&lt;extensionID&gt;com.kcly.ane.bitmapdataqrcodescanner&lt;/extensionID&gt;</code></pre>
for Flash, add this swc
　<pre><code>com.kcly.ane.bitmapdataqrcodescanner.swc</code></pre>

Usage
=====
<pre><code>import com.kcly.ane.bitmapdataqrcodescanner.Scanner;
import com.kcly.ane.bitmapdataqrcodescanner.ScannerEvent;
...

scanner = new Scanner();
scanner.addEventListener(ScannerEvent.SCAN, onScanFound);
...

scanner.scan(bmpData);

...

private function onScanFound(evt:ScannerEvent):void {
　trace ('onScanFound: ', evt.data);
}
</code></pre>

Note
====
If you want a continous scanning, you can use Enterframe, setInterval, Timer whatever you like to call scanner.scan(bmpData) 


Credit
======
Native Extension template forked from https://github.com/saumitrabhave/qr-zbar-ane
ZBar 64-Bit version from https://markobl.com/2015/03/27/zbar-sdk-64-bit-for-iphone-6-and-ios-8-download/
