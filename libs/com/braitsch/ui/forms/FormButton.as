package com.braitsch.ui.forms {
	import com.braitsch.ui.btns.SimpleButton;
	import com.braitsch.ui.theme;

	public class FormButton extends SimpleButton {
		
		public function FormButton(label:String)
		{
			super(80, 34, theme.DEFAULT, label);
		}
	}
}
