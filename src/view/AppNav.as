package view {
	import evt.AppEvent;
	import flash.events.MouseEvent;
	import com.braitsch.ui.btns.LabelButton;
	import com.braitsch.ui.theme;

	import flash.display.Sprite;
	import flash.events.Event;

	public class AppNav extends Sprite {
		
		private static var _btns	:Sprite = new Sprite();
		private static var _btn1	:LabelButton = new LabelButton(90, 30, 'Console', theme.DEFAULT);
		private static var _btn2	:LabelButton = new LabelButton(90, 30, 'Circles', theme.DEFAULT);
		
		public function AppNav()
		{
			_btn2.x = _btn1.width + 10;
			_btns.y = 10;
			_btns.addChild(_btn2);
			_btns.addChild(_btn1);
			addChild(_btns);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_btn1.addEventListener(MouseEvent.CLICK, showConsole);
			_btn2.addEventListener(MouseEvent.CLICK, showCircles);
		}

		private function showCircles(e:MouseEvent):void
		{
			this.dispatchEvent(new AppEvent(AppEvent.SHOW_CIRCLES));
		}

		private function showConsole(e:MouseEvent):void
		{
			this.dispatchEvent(new AppEvent(AppEvent.SHOW_CONSOLE));
		}
		
		private function onAddedToStage(e:Event):void
		{
			onStageResize(e);
			stage.addEventListener(Event.RESIZE, onStageResize);
		}

		private function onStageResize(e:Event):void
		{
			_btns.x = stage.stageWidth - _btns.width - 10;
			this.graphics.clear();
			this.graphics.beginFill(0x000000, .3);
			this.graphics.drawRect(0, 0, stage.stageWidth, 50);
		}
				
	}
	
}
