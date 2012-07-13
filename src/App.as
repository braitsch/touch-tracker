package 
{
	import flash.display.StageDisplayState;
	import model.AppEngine;
	import model.AppSettings;

	import view.AppView;

	import com.braitsch.evt.AirEvent;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;

	public class App extends Sprite
	{
		
		private static var _engine				:AppEngine 		= new AppEngine();
		static public function get engine()		:AppEngine 		{ return _engine; }	
		
		public function App()
		{	
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvokeEvent);
		}
		
		private function onInvokeEvent(e:InvokeEvent):void
		{
			stage.nativeWindow.visible = false;
			App.engine.addEventListener(AirEvent.SETTINGS_LOADED, onAppSettings);
			AppSettings.init(stage);
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvokeEvent);
			stage.nativeWindow.addEventListener(Event.CLOSING, function():void{ AppEngine.dispatch(new AirEvent(AirEvent.APP_CLOSING));});
		}

		private function onAppSettings(e:AirEvent):void 
		{
			addChild(new AppView());
			stage.nativeWindow.visible = true;
			App.engine.removeEventListener(AirEvent.SETTINGS_LOADED, onAppSettings);
		}

	}
	
}
