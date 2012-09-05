package 
{

	import com.braitsch.air.AirApp;
	import com.braitsch.evt.AirEvent;
	import com.braitsch.sys.Diagnostics;

	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.EventDispatcher;

	public class App extends AirApp
	{
		
		static public const WIDTH				:uint = 1080;
		static public const HEIGHT				:uint = 1920;
		
		static private var _view				:Sprite = new Sprite();
		static private var _engine				:EventDispatcher = new EventDispatcher();
		public static function get engine()		:EventDispatcher { return _engine; }
		
		public function App()
		{	
			addEventListener(AirEvent.SETTINGS_LOADED, onAppReady);
		}

		private function onAppReady(e:AirEvent):void
		{
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			attachView();
		}

		private function attachView():void
		{
		// _view layer is your app, the diagnostics layer just sits on top //	
			_view.graphics.beginFill(0x333333);
			_view.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			_view.graphics.endFill();
			_view.addChild(new Diagnostics());
			if (stage.width > WIDTH) _view.x = (stage.width - WIDTH) / 2;
			if (stage.height > HEIGHT) _view.y = (stage.height - HEIGHT) / 2;
			addChild(_view);
		}
		
	}
	
}
