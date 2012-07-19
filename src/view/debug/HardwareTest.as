package view.debug {
	import com.braitsch.txt.TextField;

	import flash.display.Sprite;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.PressAndTapGestureEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.ui.Multitouch;

	public class HardwareTest extends Sprite {
		
		private static var _specs	:TextField = new TextField();
		private static var _events	:TextField = new TextField();
		private static var _circles	:PrettyCircles = new PrettyCircles();
		
		public function HardwareTest()
		{
			_specs.x = _events.x = 20;
			_specs.y = _events.y = 70;
			_specs.text = _events.text = '';
			_specs.size = _events.size = 14;
			_specs.color = _events.color = 0xffffff;
			addChild(_circles);
			addChild(_specs);
			addChild(_events);
			this.graphics.beginBitmapFill(new DkBrownPattern());
			this.graphics.drawRect(0, 0, App.WIDTH, App.HEIGHT);
			this.graphics.endFill();
			getHardwareStatus();
			addEventListeners();
		}

		private function getHardwareStatus():void
		{
			_specs.text = 'Hardware Status \n---------------------------------------------\n';
			_specs.label.text += 'Multitouch.maxTouchPoints : ' +Multitouch.maxTouchPoints+'\n';
			var gestures:Boolean = Multitouch.supportsGestureEvents;
			_specs.label.text += 'Multitouch.supportsGestureEvents : ' +gestures + '\n';	
			if (gestures){
                var supportedGesturesVar:Vector.<String> = Multitouch.supportedGestures;
                for (var i:int=0; i<supportedGesturesVar.length; ++i) {
          			_specs.label.text += '\t'+supportedGesturesVar[i] + '\n';
                }
			}
			_specs.label.text += 'Multitouch.supportsTouchEvents : ' +Multitouch.supportsTouchEvents + '\n';
			_specs.label.text +='---------------------------------------------\n\n';
			_specs.label.text +='Touch Events Received\n';
			_specs.label.text +='---------------------------------------------';
			_events.y = _specs.y + _specs.height;
		}
		
		private function addEventListeners():void
		{
			addEventListener(MouseEvent.CLICK, onTouchEvent);
			addEventListener(MouseEvent.MOUSE_UP, onTouchEvent);
			addEventListener(MouseEvent.MOUSE_DOWN, onTouchEvent);
			addEventListener(MouseEvent.MOUSE_MOVE, onTouchEvent);
			addEventListener(TouchEvent.TOUCH_TAP, onTouchEvent);
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchEvent);
			addEventListener(TouchEvent.TOUCH_MOVE, onTouchEvent);
			addEventListener(TransformGestureEvent.GESTURE_ZOOM, onTouchEvent); 
			addEventListener(TransformGestureEvent.GESTURE_PAN, onTouchEvent); 
			addEventListener(TransformGestureEvent.GESTURE_ROTATE, onTouchEvent); 
			addEventListener(TransformGestureEvent.GESTURE_SWIPE, onTouchEvent);
			addEventListener(GestureEvent.GESTURE_TWO_FINGER_TAP, onTouchEvent);
			addEventListener(PressAndTapGestureEvent.GESTURE_PRESS_AND_TAP, onTouchEvent);
		}

		private function onTouchEvent(e:*):void
		{
			var s:String = e.type+' :: x = '+e.stageX+' y = '+e.stageY + '<br>' +_events.label.text;
			if (_events.label.numLines > 50){
				var n:uint = _events.label.getLineOffset(50);
				s = s.substring(0, n);
			}
			_events.label.htmlText = s;			
		}
		
	}
	
}
