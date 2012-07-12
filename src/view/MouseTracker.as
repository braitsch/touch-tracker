package view {
	import com.braitsch.txt.TextField;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.PressAndTapGestureEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	public class MouseTracker extends Sprite {
		
		private static var _touch:TextField = new TextField();
		private static var _state:TextField = new TextField();
		
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT; 
		
		public function MouseTracker()
		{
			_touch.x = 50; _state.x = 300;
			_touch.y = _state.y = 20;
			_touch.text = _state.text = '';
			_touch.size = _state.size = 14;
			_touch.color = _state.color = 0xffffff;
			addChild(_touch);
			addChild(_state);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			getHardwareStatus();
			stage.addEventListener(MouseEvent.CLICK, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			stage.addEventListener(GestureEvent.GESTURE_TWO_FINGER_TAP, onGestureEvent);
			stage.addEventListener(PressAndTapGestureEvent.GESTURE_PRESS_AND_TAP, onPressAndTap); 
			stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onTransformGestureEvent);
		}

		private function getHardwareStatus():void
		{
			_state.text = 'hardware status \n--------------------------------------\n';
			_state.label.text += 'Multitouch.maxTouchPoints : ' +Multitouch.maxTouchPoints+'\n';
			var gestures:Boolean = Multitouch.supportsGestureEvents;
			_state.label.text += 'Multitouch.supportsGestureEvents : ' +gestures;	
			if (gestures){
                var supportedGesturesVar:Vector.<String> = Multitouch.supportedGestures;
                for (var i:int=0; i<supportedGesturesVar.length; ++i) {
          			_state.label.text += '\n\t'+supportedGesturesVar[i];
                }
				_state.label.text +='\n--------------------------------------\n';
			}
			_state.label.text += 'Multitouch.supportsTouchEvents : ' +Multitouch.supportsTouchEvents;
		}

		private function onMouseEvent(e:MouseEvent):void
		{
			var s:String = e.type+' :: x = '+e.stageX+' y = '+e.stageY + '<br>' +_touch.label.text;
			if (_touch.label.numLines > 50){
				var n:uint = _touch.label.getLineOffset(50);
				s = s.substring(0, n);
			}
			_touch.label.htmlText = s;
		}
		
		private function onGestureEvent(e:GestureEvent):void
		{
			var s:String = e.type+' :: x = '+e.stageX+' y = '+e.stageY + '<br>' +_touch.label.text;
			if (_touch.label.numLines > 50){
				var n:uint = _touch.label.getLineOffset(50);
				s = s.substring(0, n);
			}
			_touch.label.htmlText = s;
		}
		
		private function onPressAndTap(e:PressAndTapGestureEvent):void
		{
			var s:String = e.type+' :: x = '+e.stageX+' y = '+e.stageY + '<br>' +_touch.label.text;
			if (_touch.label.numLines > 50){
				var n:uint = _touch.label.getLineOffset(50);
				s = s.substring(0, n);
			}
			_touch.label.htmlText = s;
		}		
		
		private function onTransformGestureEvent(e:TransformGestureEvent):void
		{
			var s:String = e.type+' :: x = '+e.stageX+' y = '+e.stageY + '<br>' +_touch.label.text;
			if (_touch.label.numLines > 50){
				var n:uint = _touch.label.getLineOffset(50);
				s = s.substring(0, n);
			}
			_touch.label.htmlText = s;
		}		
		
		private var tmi:int = 0;
		private function onTouchBegin(e:TouchEvent):void 
		{ 
		    if (tmi == 0) {
			    tmi = e.touchPointID; 
				_touch.label.text += 'Touch Start' + e.touchPointID; 
			    stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
			    stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd); 
			}
		} 
		private function onTouchMove(e:TouchEvent):void 
		{ 
		    if (e.touchPointID == tmi) {
			    _touch.label.text += 'Touch Move' + e.touchPointID;
			}
		} 
		private function onTouchEnd(e:TouchEvent):void
		{ 
		    if(e.touchPointID == tmi) {
			    tmi = 0; 
			    stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
			    stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd); 
			    _touch.label.text += 'Touch Complete' + e.touchPointID;
			}
		}
		
	}
	
}