package view {
	import evt.AppEvent;

	import flash.display.Sprite;

	public class AppView extends Sprite {
		
		private static var _nav		:AppNav = new AppNav();
		private static var _bkgd	:AppBkgd = new AppBkgd();
		private static var _circle	:TouchCircles = new TouchCircles();
		private static var _console	:TouchConsole = new TouchConsole();
		
		public function AppView()
		{
			addChild(_bkgd);
			addChild(_nav);
			addChild(_circle);
			addChild(_console);
			_nav.addEventListener(AppEvent.CLEAR_VIEW, onClearView);
			_nav.addEventListener(AppEvent.SHOW_CIRCLES, onShowCircles);
			_nav.addEventListener(AppEvent.SHOW_CONSOLE, onShowConsole);
		}

		private function onClearView(e:AppEvent):void
		{
			_circle.clear();
			_console.clear();
		}

		private function onShowConsole(e:AppEvent):void
		{
			_circle.visible = false;
			_console.visible = true;			
		}

		private function onShowCircles(e:AppEvent):void
		{
			_circle.visible = true;
			_console.visible = false;			
		}

	}
	
}
