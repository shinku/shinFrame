package Shin.ShinControls.controlTools
{
	public class marqueeOption
	{
		private var spacing:Number;
		private var rollingSpeed:Number;
		private var myitemHeightPer:Number;
		private var myitemWidthPer:Number;
		private var myItemNumber:int=1;
		public function marqueeOption(speed:Number=0,spacebetween:Number=2,itemWidthPer:Number=100,itemHeightPer:Number=100,initNumber:int=1):void
		{
			spacing=spacebetween;
			rollingSpeed=speed;
			myitemHeightPer=itemHeightPer;
			myitemWidthPer=itemWidthPer;
			myItemNumber=initNumber;
		}
		public function set RollingSpeed(val:Number):void
		{
			rollingSpeed=val;
		}
		public function set spacingBetween(val:Number):void
		{
			spacing=val;
		}
		public function set itemHeight(val:Number):void
		{
			this.myitemHeightPer=val;
		}
		public function set itemWidth(val:Number):void
		{
			this.myitemWidthPer=val;
		}
		public function get RollingSpeed():Number
		{
			return rollingSpeed;
		}
		public function get spacingBetween():Number
		{
			return spacing;
		}
		public function get itemHeight():Number
		{
			return myitemHeightPer;
		}
		public function get itemWidth():Number
		{
			return myitemWidthPer;
		}
		public function set initNum(val:int):void
		{
			this.myItemNumber=val;
		}
		public function get initNum():int
		{
			return this.myItemNumber;
		}
	}
}