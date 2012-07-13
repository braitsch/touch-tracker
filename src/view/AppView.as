package view {
	import com.braitsch.ui.btns.LabelButton;
	import com.braitsch.ui.theme;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class AppView extends Sprite {
		
		private static var _bkgd	:AppBkgd = new AppBkgd();
		private static var _circle	:TouchCircle = new TouchCircle();
		private static var _console	:TouchConsole = new TouchConsole();
		
		private static var _nav		:Sprite	= new Sprite();
		private static var _btn1	:LabelButton = new LabelButton(120, 40, 'Console', theme.DEFAULT);
		private static var _btn2	:LabelButton = new LabelButton(120, 40, 'Circle', theme.DEFAULT);
		
		public function AppView()
		{
			addChild(_bkgd);
			addChild(_nav);
			addChild(_circle);
			addChild(_console);
			_btn2.x = _btn1.width + 10;
			_nav.addChild(_btn1);
			_nav.addChild(_btn2);
			_nav.addEventListener(MouseEvent.CLICK, onButtonClick);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			onStageResize(e);
			stage.addEventListener(Event.RESIZE, onStageResize);
		}

		private function onStageResize(e:Event):void
		{
			_nav.y = 20;
			_nav.x = stage.stageWidth - _nav.width - 20;
		}

		private function onButtonClick(e:MouseEvent):void
		{
			if (e.target == _btn1){
				_circle.visible = false;
				_console.visible = true;
			}	else if (e.target == _btn2){
				_circle.visible = true;
				_console.visible = false;
			}
		}

	}
	
}
