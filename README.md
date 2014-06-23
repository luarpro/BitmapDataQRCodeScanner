BitmapDataQRCodeScanner (ANE)
=============================

Flash AIR Native Extension:  QRCode reader/decoder which accept BitmapData, therefore you can design your own scanner UI, adding overlay image, without launch  fullscreen native Camera UI


Setup in application.xml
========================
for Android, include the followings inside &lt;android&gt;&lt;manifestAdditions&gt;...&lt;/manifestAdditions&gt;&lt;/android&gt;<br />
　<code>&#09;&lt;uses-permission android:name="android.permission.CAMERA"/&gt;
　&#09;&lt;uses-feature android:name="android.hardware.camera" /&gt;</code>
for both iOS and Android, include the followings inside &lt;extensions&gt;...&lt;/extensions&gt;
　<code>&#09;&lt;extensionID&gt;com.kcly.ane.bitmapdataqrcodescanner&lt;/extensionID&gt;</code>
for Flash, add this swc<br />
　<code>&#09;com.kcly.ane.bitmapdataqrcodescanner.swc</code><br />
Usage
=====
<code>
import com.kcly.ane.bitmapdataqrcodescanner.Scanner;
import com.kcly.ane.bitmapdataqrcodescanner.ScannerEvent;
...

scanner = new Scanner();
scanner.addEventListener(ScannerEvent.SCAN, onScanFound);
...

scanner.scan(bmpData);

...

private function onScanFound(evt:ScannerEvent):void {
　&#09;trace ('onScanFound: ', evt.data);
}
</code>
Note
====
If you want a continous scanning, you can use Enterframe, setInterval, Timer whatever you like to call scanner.scan(bmpData) 


Credit
======
Native Extension template forked from https://github.com/saumitrabhave/qr-zbar-ane
