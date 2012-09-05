package com.braitsch.sys {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TrackingCircles extends Sprite {
		
		private static var _offsetX	:uint = 0;
		private static var _offsetY:uint=0;

		public function TrackingCircles()
		{
			mouseEnabled = mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function onAddedToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, addCircle);
			if (stage.stageWidth > App.WIDTH) _offsetX = (stage.stageWidth - App.WIDTH) / 2;
			if (stage.stageHeight > App.HEIGHT) _offsetY = (stage.stageHeight - App.HEIGHT) / 2;
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, addCircle);	
		}		
		
		private function addCircle(e:MouseEvent):void
		{
			var c:Circle = new Circle();
			c.x = e.stageX - _offsetX; c.y = e.stageY - _offsetY;
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

import flash.display.Shape;
class Circle extends Shape
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


