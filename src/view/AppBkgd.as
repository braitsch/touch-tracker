package view {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	public class AppBkgd extends Sprite {
		
		private static var _noise		:Shape = new Shape();
		private static var _pattern		:DkBrownPattern = new DkBrownPattern();
		
		public function AppBkgd()
		{
			addChild(_noise); _noise.alpha = .02;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			onStageResize(e);
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void
		{
			graphics.clear();
			graphics.beginBitmapFill(_pattern);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			_noise.graphics.clear();
			_noise.graphics.beginBitmapFill(new NoisePattern());
			_noise.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			_noise.graphics.endFill();				
		}
		
	}
	
}
