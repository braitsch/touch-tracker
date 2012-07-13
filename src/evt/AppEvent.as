package evt {
	import flash.events.Event;

	public class AppEvent extends Event {
		
		public static const SHOW_CIRCLES			:String = "SHOW_CIRCLES";
		public static const SHOW_CONSOLE			:String = "SHOW_CONSOLE";
		
		public var data:Object;
		
		public function AppEvent($type:String, $data:Object = null)
		{
			data = $data;
			super($type, false, false);
		}
		
	}
	
}
