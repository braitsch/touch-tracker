package view.debug {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;

	public class PrettyCircles extends Sprite {
		
		public function PrettyCircles()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			if (Multitouch.supportsTouchEvents){
				stage.addEventListener(TouchEvent.TOUCH_MOVE, addCircle);
			}	else{
				stage.addEventListener(MouseEvent.MOUSE_MOVE, addCircle);
			}
		}
		
		private function addCircle(e:*):void
		{
			var c:Circle = new Circle();
			c.x = e.stageX - App.view.x; c.y = e.stageY - App.view.y;
			c.addEventListener(Event.ENTER_FRAME, onCircleFrame);
			addChild(c);
		}

		private function onCircleFrame(e:Event):void
		{
			var c:Circle = e.target as Circle;
			c.scaleX -= c.sx;
			c.scaleY -= c.sx;
			c.dx += .15;
			c.dy += .15;
			c.x += Math.sin(c.dx) * c.force;
			c.y += Math.cos(c.dy) * c.force;
			if (c.scaleX <=0 || c.scaleY <=0 )
			{
				removeChild(c);
				c.removeEventListener(Event.ENTER_FRAME, onCircleFrame);
			}
		}
		
	}
	
}
import flash.display.Sprite;
class Circle extends Sprite
{

	public var dx		:Number = Math.random() / 10;
	public var dy		:Number = Math.random() / 10;
	public var sx		:Number = (Math.random() / 50) + .01;
	public var size		:Number = (Math.random() * 25) + 25;
	public var force	:Number = (Math.random() * 10);
	
	private static var _colors	:Vector.<uint> = new <uint>[0x69D2E7, 0xA7DBD8, 0xE0E4CC, 0xF38630, 0xFA6900];
	
	public function Circle()
	{
		var i:uint = Math.floor(Math.random()*_colors.length);
		this.graphics.beginFill(_colors[i]);
		this.graphics.drawCircle(0, 0, this.size);
		this.graphics.endFill();
	}
}


