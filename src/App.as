package 
{
	import model.AppEngine;
	import model.AppSettings;

	import view.AppView;

	import com.braitsch.evt.AirEvent;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;

	public class App extends Sprite
	{
		
		static public const WIDTH				:uint = 1050;
		static public const HEIGHT				:uint = 1680;
		
		private static var _view				:AppView;
		static public function get view()		:AppView 		{ return _view; }	
		private static var _engine				:AppEngine 		= new AppEngine();
		static public function get engine()		:AppEngine 		{ return _engine; }	
		
		public function App()
		{	
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
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
			_view = new AppView(); 
			addChild(_view); 
			stage.nativeWindow.visible = true;
			App.engine.removeEventListener(AirEvent.SETTINGS_LOADED, onAppSettings);
			App.engine.addEventListener(AirEvent.DISPLAY_MODE_NORMAL, onDisplayModeNormal);
			App.engine.addEventListener(AirEvent.DISPLAY_MODE_FULLSCREEN, onDisplayModeFullscreen);
			App.engine.dispatchEvent(new AirEvent(AirEvent.DISPLAY_MODE_FULLSCREEN));
		}

		private function onDisplayModeNormal(e:AirEvent):void
		{
			stage.displayState = StageDisplayState.NORMAL;
			_view.x = _view.y = 0;
			stage.nativeWindow.width = App.WIDTH;
			stage.nativeWindow.height = App.HEIGHT;
		}

		private function onDisplayModeFullscreen(e:AirEvent):void
		{
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			if (stage.stageWidth > App.WIDTH) _view.x = (stage.stageWidth - App.WIDTH) / 2;
			if (stage.stageHeight > App.HEIGHT) _view.y = (stage.stageHeight - App.HEIGHT) / 2;
		}
		
	}
	
}
