package {
	import com.kcly.ane.bitmapdataqrcodescanner.Scanner;
	import com.kcly.ane.bitmapdataqrcodescanner.ScannerEvent;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setInterval;
	
	public class Demo extends Sprite {
		private var scanner:Scanner;
		private var tf:TextField;
		private var bmpData:BitmapData;
		private var video:Video;
		private var sp:Sprite;
		
		public function Demo():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		
			init();
		}
		
		private function init():void {
			scanner = new Scanner
			scanner.addEventListener(ScannerEvent.SCAN, onScanFound)
			
			var cam:Camera = Camera.getCamera();
			cam.setMode(480,480,15);
		
			sp = new Sprite
			addChild(sp)
			
			var stageW:int = stage.fullScreenWidth
			var vidH:int = stageW/(cam.width/cam.height)
			video = new Video(vidH, stageW);
			video.y = -stageW / 2;
			video.x = -vidH / 2;
			video.attachCamera(cam);
			sp.x = stageW / 2;
			sp.y = vidH / 2;
			sp.rotation = 90;
			sp.addChild(video);
			
			bmpData = new BitmapData(sp.width, sp.height, false, 0);
			
			tf = new TextField;
			tf.multiline = tf.wordWrap = true;
			tf.y = sp.height;
			addChild(tf)
			
			var tfmt:TextFormat = new TextFormat
			tfmt.font = "Arial"
			tfmt.size = 48;
			tf.defaultTextFormat = tfmt;
			
			tf.text = "Scanning...";
			tf.width = stageW;
			tf.autoSize = TextFieldAutoSize.LEFT;
			
			setInterval(doScan, 1000)
			
			trace ('inited')
		}
		
		private function doScan():void {
			bmpData.draw(video);
			trace ('doScan', bmpData.width, bmpData.height)
			scanner.scan(bmpData);
		}
		
		private function onScanFound(evt:ScannerEvent):void {
			trace ('onScanFound', evt.data)
			tf.text = evt.data;
			tf.autoSize = TextFieldAutoSize.LEFT;
		}
		
		private function deactivate(e:Event):void {
			//NativeApplication.nativeApplication.exit();
		}
	}
}