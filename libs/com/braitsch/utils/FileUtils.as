package com.braitsch.utils {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	public class FileUtils {
		
		public static function dirIsEmpty(f:File):Boolean
		{
			if (f.isDirectory) {
				var a:Array = f.getDirectoryListing();
				for (var i:int = 0; i < a.length; i++) if (a[i].isHidden == false) return false;
				return true;
			}
			return false;			
		}
		
		public static function write(f:File, s:String):void
		{
			s.replace(/\n/g, File.lineEnding);
			var stream:FileStream = new FileStream();
				stream.open(f, FileMode.WRITE);
				stream.writeUTFBytes(s);
			stream.close();			
		}
		
	}
	
}
