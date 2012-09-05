package com.braitsch.air {
	import com.braitsch.evt.AirEvent;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	
	public class AirApp extends Sprite {
		
		private static var _settings			:AirSettings;
		
		public function AirApp()
		{
			stage.frameRate = 30;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvokeEvent);
		}

		static public function get settings()	:AirSettings 	{ return _settings; }		

		private function onInvokeEvent(e:InvokeEvent):void
		{
			stage.nativeWindow.visible = false;
			loadApplicationSettings();
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvokeEvent);
			stage.nativeWindow.addEventListener(Event.CLOSING, onApplicationClose);
		}
		
		private function loadApplicationSettings():void
		{
			_settings = new AirSettings(stage);
			_settings.addEventListener(AirEvent.SETTINGS_LOADED, onSettingsLoaded);
			_settings.load();
		}

		private function onSettingsLoaded(e:AirEvent):void
		{
			stage.nativeWindow.visible = true;
			dispatchEvent(new AirEvent(AirEvent.SETTINGS_LOADED));
		}

		private function onApplicationClose(e:Event):void
		{
			_settings.save();
			dispatchEvent(new AirEvent(AirEvent.APP_CLOSING));
		}
		
	}
	
}
