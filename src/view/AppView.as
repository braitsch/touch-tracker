package view {
	import view.controls.AppControls;
	import view.debug.HardwareTest;

	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class AppView extends Sprite {
		
		private static var _appControls		:AppControls = new AppControls();
		private static var _hardwareTest	:HardwareTest = new HardwareTest();
		private static var _bkgdGradient	:Bitmap = new Bitmap(new BkgdGradFull());
		
		public function AppView()
		{
			addChild(_bkgdGradient);
			addChild(_hardwareTest);
			addChild(_appControls);
		}

	}
	
}
