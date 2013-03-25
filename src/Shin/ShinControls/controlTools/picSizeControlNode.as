// ActionScript file
package Shin.ShinControls.controlTools
{
	import flash.display.Sprite;
	public class picSizeControlNode extends Sprite
	{
		public function picSizeControlNode()
		{
			graphics.lineStyle(1,0xcccccc,1);
			graphics.beginFill(0xffffff,.6);
			graphics.drawRect(-2,-2,4,4);
			graphics.endFill();
			this.buttonMode=true;
		}
	}
}