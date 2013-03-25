package Shin.ShinUI
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class VerticalToolBar extends toolbar
	{
		protected var vy:Number;
		protected var fr:Number=0.2;
		public function VerticalToolBar()
		{
			//super($bar,$rec);
			//super.isChild=true;
			
		}
		override protected function onEnterframe(e:Event):void
		{
			super.onEnterframe(e);
			if(_client && _client.height>this._maskLength)
			{
				//trace(vy);
				vy=(_bar.y-_dragRectangle.y)/(this._dragRectangle.height)*(this._maskLength-_client.height)+this._startPoint.y;
				_client.y+=(vy-_client.y)*fr;
			}
		}
		public function set maskH(val:Number):void
		{
			super.maskLength=val;
		}
	}
}