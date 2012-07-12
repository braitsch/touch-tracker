package com.braitsch.ui.forms {
	import com.braitsch.txt.TextField;

	public class FormFieldText extends TextField {
		
		public function FormFieldText()
		{
			super(DroidSerifBold);
			super.size = 11;
			super.color = TextField.GREY;
			this.label.x = 10; this.label.y = 7;
		}
		
	}
	
}
