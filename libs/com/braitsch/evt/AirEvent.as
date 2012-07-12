package com.braitsch.evt {
	import flash.events.Event;

	public class AirEvent extends Event {
		
		public static const APP_CLOSING						:String = "APP_CLOSING";
		public static const SETTINGS_LOADED					:String = "SETTINGS_LOADED";
		public static const SETTINGS_UPDATED				:String = "SETTINGS_UPDATED";
		
		public static const NATIVE_PROCESS_FAILURE			:String = "NATIVE_PROCESS_FAILURE";
		public static const NATIVE_PROCESS_PROGRESS			:String = "NATIVE_PROCESS_PROGRESS";
		public static const NATIVE_PROCESS_COMPLETE			:String = "NATIVE_PROCESS_COMPLETE";	
		public static const NATIVE_PROCESS_QUEUE_COMPLETE	:String = "NATIVE_PROCESS_QUEUE_COMPLETE";
		
		public var data:Object;
		
		public function AirEvent($type:String, $data:Object = null)
		{
			data = $data;
			super($type, false, false);
		}
		
	}
	
}
