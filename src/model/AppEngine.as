package model {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class AppEngine extends EventDispatcher {
		
		private static var _instance	:AppEngine;
		
		public function AppEngine() {
			_instance = this;	
		}
		
		static public function dispatch(e:Event):void
		{
			
			_instance.dispatchEvent(e);
		}
		
	}
	
}
