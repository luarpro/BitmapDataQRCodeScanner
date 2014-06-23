package com.kcly.ane.bitmapdataqrcodescanner {
	import flash.events.Event;
	
	public class ScannerEvent extends Event	{
		public static const SCAN:String = "com.kcly.ane.bitmapdataqrcodescanner.ScannerEvent";
		private var _data:String;
		
		public function ScannerEvent(type:String, data:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data():String {
			return _data;
		}
		
		public override function clone():Event {
			return new ScannerEvent(type, _data, bubbles,cancelable);
		};
	}
}