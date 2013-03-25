package Shin.ShinControls.controlTools
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class pageIndexNode extends Sprite
	{ 
		private var _label:TextField=new TextField();
		public static const DIANDIANDIANNODE:pageIndexNode=new pageIndexNode("...");
		public function pageIndexNode(labelStr:String,size:Number=12)
		{
			var tf:TextFormat=new TextFormat();
			tf.size=size;
			tf.color=0x000000;
			_label.autoSize=TextFieldAutoSize.CENTER;
			_label.defaultTextFormat=tf;
			_label.text=labelStr;
			_label.width=_label.textWidth+2;
			_label.height=_label.textHeight+2;
			addChild(_label);
			this.mouseChildren=false;
		}
		public function get label():String
		{
			return _label.text;
		}
	}
}