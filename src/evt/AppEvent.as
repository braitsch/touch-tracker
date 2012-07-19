package evt {
	import flash.events.Event;

	public class AppEvent extends Event {
		
		public static const NORMAL_MODE		:String = "NORMAL_MODE";
		public static const HARDWARE_TEST	:String = "HARDWARE_TEST";
		
		public var data:Object;
		
		public function AppEvent($type:String, $data:Object = null)
		{
			data = $data;
			super($type, false, false);
		}
		
	}
	
}
