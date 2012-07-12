package model {
	import com.braitsch.evt.AirEvent;
	import com.braitsch.utils.FileUtils;

	import flash.display.Stage;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.System;
	
	public class AppSettings {

		public static const APP_DIRECTORY			:String = 'AppDirectory';

		private static var _file		:File;
		private static var _xml			:XML;
		private static var _stage		:Stage;
		private static var _settings	:Object = {};

		public static function init(stage:Stage):void
		{
			_stage = stage;
			_file = File.applicationStorageDirectory.resolvePath("app-settings.xml");
			_file.exists ? readXML() : setDefaultSettings();
			App.engine.addEventListener(AirEvent.APP_CLOSING, onAppClosing);
		}
		
		public static function setSetting(name:String, val:*):void
		{
			if (_settings[name] != val){
				_settings[name] = val;
				AppEngine.dispatch(new AirEvent(AirEvent.SETTINGS_UPDATED, name));
			}
		}
		
		public static function getSetting(name:String):*
		{
			for (var p:String in _settings) if (name == p) return _settings[p];
		}

		private static function readXML():void 
		{
			var stream:FileStream = new FileStream();
    			stream.open(_file, FileMode.READ);
			_xml = XML(stream.readUTFBytes(stream.bytesAvailable));
				stream.close();
			_stage.nativeWindow.x = _xml['window'].@x;
			_stage.nativeWindow.y = _xml['window'].@y;
			_stage.nativeWindow.width = _xml['window'].@width;
			_stage.nativeWindow.height = _xml['window'].@height;
			_stage.nativeWindow.visible = true;
		// store user-defined preferences //	
			var p:XMLList = _xml['user-defined'].children();
			for (var i:int = 0; i < p.length(); i++) _settings[p[i].name()] = castSetting(p[i].valueOf());
			System.disposeXML(_xml);
			AppEngine.dispatch(new AirEvent(AirEvent.SETTINGS_LOADED));
		//	traceSettings();
		}
		
		private static function castSetting(s:String):*
		{
		// cast xml strings to boolean for faster comparisons 	
			if (s == 'true') return true;
			if (s == 'false') return false;
			return s;
		}
		
		private static function setDefaultSettings():void
		{
			_settings[APP_DIRECTORY] = '';
			AppEngine.dispatch(new AirEvent(AirEvent.SETTINGS_LOADED));			
		}
		
		private static function onAppClosing(e:AirEvent):void
		{
			getSettings(); 
			writeToFile();
		}
		
		private static function getSettings():void 
		{
			_xml = <preferences/>;
			_xml['window'].@width = _stage.nativeWindow.width;
			_xml['window'].@height = _stage.nativeWindow.height;
			_xml['window'].@x = _stage.nativeWindow.x;
			_xml['window'].@y = _stage.nativeWindow.y;
		// write user-defined preferences //	
			for (var p:String in _settings) _xml['user-defined'][p] = _settings[p];
			_xml['lastSaved'] = new Date().toString();
		}
		
		private static function traceSettings():void
		{
			for (var p:String in _settings) trace('prop & value = '+p, _settings[p]);
		}
		
		private static function writeToFile():void 
		{
			traceSettings();
			var output:String = '<?xml version="1.0" encoding="utf-8"?>\n';
				output += _xml.toXMLString();
			FileUtils.write(_file, output);
		}

	}
	
}
