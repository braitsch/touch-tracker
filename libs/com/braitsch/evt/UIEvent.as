package com.braitsch.evt{
	import flash.events.Event;

	public class UIEvent extends Event {
		
		public static const SHOW_ALERT				:String = "SHOW_ALERT";
		public static const HIDE_ALERT				:String = "HIDE_ALERT";
		public static const OPEN_WINDOW				:String = "OPEN_WINDOW";
		public static const CLOSE_WINDOW			:String = "CLOSE_WINDOW";
		
		public static const DRAG_AND_DROP			:String = "DRAG_AND_DROP";
		public static const FILE_BROWSER_SELECTION	:String = "FILE_BROWSER_SELECTION";
		
		public static const KEY_ENTER				:String = "KEY_ENTER";
		
		public var data:Object;

		public function UIEvent(type:String, obj:Object = null)
		{
			data = obj;
			super(type, true, false);
		}
		
	}
	
}