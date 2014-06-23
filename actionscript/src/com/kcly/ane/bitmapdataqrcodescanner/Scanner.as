package com.kcly.ane.bitmapdataqrcodescanner {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class Scanner extends EventDispatcher {
		
		private static var extCtx:ExtensionContext = null;
		private static var isInstantiated:Boolean = false;
		
		public function Scanner() {
			
			if (!isInstantiated) {
				extCtx = ExtensionContext.createExtensionContext("com.kcly.ane.bitmapdataqrcodescanner", null);
				
				if (extCtx != null) {
					
					extCtx.addEventListener(StatusEvent.STATUS, onStatus);
					
				} else {
					throw new Error("Extension not supported");
				}
				
				isInstantiated = true;
			}
		}

		public function dispose():void {
			extCtx.dispose();
			extCtx = null;
			isInstantiated = false;
		}
		
		public function scan(bmpData:BitmapData):String {
			var ret:Object = extCtx.call("scan", bmpData);
			
			if (ret == null)
				return "";
			else
				return ret as String;
		}
		
		public function stop():Boolean {
			var ret:Object = extCtx.call("stop");
			
			if (ret == null)
				return false;
			else
				return ret as Boolean;
		}
		
		private function onStatus(evt:StatusEvent):void {
			switch (evt.code) {
				case "data": 
					dispatchEvent(new ScannerEvent(ScannerEvent.SCAN, evt.level));
					break;
			}
		}
	}
}