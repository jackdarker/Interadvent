package gfw.components 
{
	import spark.components.TextArea;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.conversion.TextConverter;
    import spark.utils.TextFlowUtil;
	/**
	 * ...
	 * @author jk
	 */
	public class TextWindow extends TextArea
	{
		
		public function TextWindow() {
			super();
			this.editable = false;
			//var markup:String = "<p>Hello <b>world!</b></p>"; 
			setStyle("color", 0x000000);
		}
		public function SetText(Text:String):void {
			var flow:TextFlow = TextConverter.importToFlow(Text, TextConverter.TEXT_FIELD_HTML_FORMAT)
			content = flow;
		}
		
	}

}