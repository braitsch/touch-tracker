package com.braitsch.utils {

	public class StringUtils {
		
		public static function trim(s:String):String
		{
			return s.replace(/^\s+|\s+$/g, '');			
		}
		
		public static function hasTrailingWhiteSpace(s:String):Boolean
		{
			return s.search(/\s+$/)!=-1;			
		}
		
		public static function capitalize(s:String):String
		{
			return s.substr(0, 1).toUpperCase()+s.substr(1);
		}
		
		public static function validateEmail(s:String):Boolean
		{
			return s.search(/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/) != -1;
		}
		
		public static function parseISO8601Date(x:String):Date
		{
			var y:uint = uint(x.substr(0, 4));
			var m:uint = uint(x.substr(5, 2)) - 1;
			var d:uint = uint(x.substr(8, 2));
			var h:uint = uint(x.substr(11, 2));
			var n:uint = uint(x.substr(14, 2));
			var s:uint = uint(x.substr(17, 2));
			return new Date(Date.UTC(y, m, d, h, n, s));
		}		
		
	}
	
}
