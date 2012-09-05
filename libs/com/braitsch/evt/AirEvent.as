package com.braitsch.evt {
	import flash.events.Event;

	public class AirEvent extends Event {
		
		public static const APP_CLOSING						:String = "APP_CLOSING";
		public static const SETTINGS_LOADED					:String = "SETTINGS_LOADED";
		public static const SETTINGS_UPDATED				:String = "SETTINGS_UPDATED";
		
		public static const NORMAL_MODE						:String = "NORMAL_MODE";
		public static const CONTROL_MODE					:String = "CONTROL_MODE";
		
		public var data:Object;
		
		public function AirEvent($type:String, $data:Object = null)
		{
			data = $data;
			super($type, false, false);
		}
		
	}
	
}
