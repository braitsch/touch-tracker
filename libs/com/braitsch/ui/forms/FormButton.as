package com.braitsch.ui.forms {
	import com.braitsch.ui.btns.LabelButton;
	import com.braitsch.ui.theme;

	public class FormButton extends LabelButton {
		
		public function FormButton(label:String)
		{
			super(80, 34, label, theme.DEFAULT);
		}
	}
}
