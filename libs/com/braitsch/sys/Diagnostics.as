package com.braitsch.sys {

	import com.braitsch.evt.AirEvent;

	import flash.display.Sprite;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	public class Diagnostics extends Sprite {

		private static var _view		:DiagnosticView = new DiagnosticView();
		private static var _controls	:DiagnosticControls = new DiagnosticControls();
		private static var _circles		:TrackingCircles = new TrackingCircles();

		public function Diagnostics(mode:String = MultitouchInputMode.TOUCH_POINT)
		{
			addChild(_controls);
			Multitouch.inputMode = mode;
			App.engine.addEventListener(AirEvent.NORMAL_MODE, onNormalMode);
			App.engine.addEventListener(AirEvent.CONTROL_MODE, onControlMode);
		}

		private function onNormalMode(e:AirEvent):void
		{
			if (_view.stage) removeChild(_view);
			if (_circles.stage) removeChild(_circles);
		}
		
		private function onControlMode(e:AirEvent):void
		{
			addChildAt(_view, 0);
			addChildAt(_circles, 1);			
		}
		
	}
	
}
