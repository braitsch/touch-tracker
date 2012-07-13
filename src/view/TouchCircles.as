package view {
	import flash.events.TransformGestureEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;

	public class TouchCircles extends Sprite {
		
		private static var _margin			:uint = 50;
		private static var _activeTarget	:Circle;
		
		public function TouchCircles()
		{
			this.visible = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function clear():void
		{
			while(numChildren) {
				var k:Circle = getChildAt(0) as Circle;
				k.removeEventListener(Event.ENTER_FRAME, onDropFrame);
				removeChild(getChildAt(0));	
			}
		}		

		private function onAddedToStage(e:Event):void
		{
			attachRandomCircle();
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseCircle);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCircle);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, attachCircle);
			stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onStageZoom);
			stage.addEventListener(TransformGestureEvent.GESTURE_ROTATE, onStageRotate);
		}

		private function onStageZoom(e:TransformGestureEvent):void
		{
		//	this.scaleX *= e.scaleX;
		//	this.scaleX *= e.scaleX;
		}

		private function onStageRotate(e:TransformGestureEvent):void
		{
		//	this.rotation += e.rotation;
		}

		private function attachRandomCircle():void
		{
			var c:Circle = new Circle();
			c.x = (Math.random()*(stage.stageWidth - (_margin*2))) + _margin;
			c.y = (Math.random()*_margin) + (_margin*2);
			addChild(c); drop(c);
			setTimeout(attachRandomCircle, (Math.random()*3000) + 1000);
		}

		private function attachCircle(e:MouseEvent):void
		{
			if (e.stageY > _margin){
				_activeTarget = new Circle();
				_activeTarget.x = e.stageX;
				_activeTarget.y = e.stageY;
				_activeTarget.startDrag();
				addChild(_activeTarget);
			}
		}

		private function dragCircle(e:MouseEvent):void
		{
			if (_activeTarget != null){
				if (e.stageY < _margin + _activeTarget.height/2){
					_activeTarget.y = _margin + _activeTarget.height/2;
				}	
			}
		}

		private function releaseCircle(e:MouseEvent):void
		{
			if (_activeTarget != null){
				_activeTarget.stopDrag();
				drop(_activeTarget);
				_activeTarget = null;
			}
		}
		
		private function drop(c:Circle):void
		{
			c.addEventListener(Event.ENTER_FRAME, onDropFrame);	
		}

		private function onDropFrame(e:Event):void
		{
			e.target.y += e.target.speed;
			if (e.target.y > stage.stageHeight + e.target.height / 2){
				removeChild(e.target as Circle);
				e.target.removeEventListener(Event.ENTER_FRAME, onDropFrame);	
			}
		}

	}
	
}
import com.greensock.TweenLite;

import flash.display.GradientType;
import flash.display.LineScaleMode;
import flash.display.Sprite;
class Circle extends Sprite
{
	
	public var speed:Number = ((Math.random()*15) + 5)/20;
	
	public function Circle()
	{
		this.graphics.beginFill(0xff0000);
		this.graphics.lineStyle(4, 0x0069bb, 1, false, LineScaleMode.NONE);
		this.graphics.beginGradientFill(GradientType.RADIAL, [0x0387cf, 0x005ad0], [1, 1], [0, 255]);
		this.graphics.drawCircle(0, 0, 5);
		TweenLite.to(this, this.speed, {scaleX:this.speed * 10, scaleY:this.speed * 10});
	}
}
