package view {
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class TouchCircle extends Sprite {
		
		public function TouchCircle()
		{
			this.visible = false;
			this.buttonMode = true;
			this.graphics.beginFill(0xff0000);
			this.graphics.lineStyle(4, 0x0069bb);
			this.graphics.beginGradientFill(GradientType.RADIAL, [0x0387cf, 0x005ad0], [1, 1], [0, 255]);
			this.graphics.drawCircle(0, 0, 100);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		private function onMouseMove(e:MouseEvent):void
		{
			if (e.stageY < 80 + this.height/2){
				this.y = 80 + this.height/2;
			}	else{
				this.x = e.stageX;
				this.y = e.stageY;
			}
		}
		
	}
	
}
