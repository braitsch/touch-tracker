package view {
	import flash.display.Sprite;


	public class AppView extends Sprite {
		
		private static var _bkgd	:AppBkgd = new AppBkgd();
		private static var _mouse	:MouseTracker = new MouseTracker();
		
		public function AppView()
		{
			addChild(_bkgd);
			addChild(_mouse);
		}

	}
	
}
