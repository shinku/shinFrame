package Shin.ShinControls
{
	import Shin.ShinControls.controlTools.marqueeOption;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Marquee extends Sprite
	{
		internal var marqueeVisio:Bitmap;
		internal var marqueeVisioBitmapdata:BitmapData;
		private var MyOption:marqueeOption;
		private var myData:Array;
		internal var moveRect:Rectangle;
		protected var stopIndex:int=-1;
		protected var filter:BlurFilter=new BlurFilter();
		public function Marquee()
		{
			super();
		}
		public function clone():Marquee
		{ 
			var marq:Marquee=new Marquee();
			marq.setOptions(myData,MyOption);
			return marq;
		}
		public function setOptions(datas:Array,option:marqueeOption):void
		{
			MyOption=option || new marqueeOption();
			myData=datas;
			marqueeVisio=new Bitmap();
			addChild(marqueeVisio);
			moveRect=new Rectangle(0,0,option.itemWidth,option.itemHeight);
			marqueeVisio.bitmapData=new BitmapData(option.itemWidth,option.itemHeight,true,0xffffff);
			buildData();
		}
		private function buildData():void
		{
			var length:Number=myData.length*(MyOption.itemHeight+MyOption.spacingBetween)+MyOption.itemHeight;
			marqueeVisioBitmapdata=new BitmapData(MyOption.itemWidth,length,true,0xffffff);
			//var mc:MovieClip=new MovieClip();
			var frontBitd:BitmapData;
			for(var i:int=0;i<myData.length;i++)
			{
				var bitd:BitmapData=new BitmapData(MyOption.itemWidth,MyOption.itemHeight,true,0xffffff);
				var scX:Number=bitd.width/myData[i].width;
				var scY:Number=bitd.height/myData[i].height;
				var max:Matrix=new Matrix();
				max.scale(scX,scY);
				bitd.draw(myData[i],max);
				if(i==0)
				{
					frontBitd=bitd.clone();
				}
				marqueeVisioBitmapdata.copyPixels(bitd,bitd.rect,new Point(0,(MyOption.itemHeight+MyOption.spacingBetween)*i));
				bitd.dispose();
				max=null;
				//myData[i]=null;
			}
			marqueeVisioBitmapdata.copyPixels(frontBitd,frontBitd.rect,new Point(0,(MyOption.itemHeight+MyOption.spacingBetween)*i));
			frontBitd=null;
			marqueeVisio.bitmapData.copyPixels(marqueeVisioBitmapdata,moveRect,new Point(0,0));
		}
		public function update():void
		{
			var speed:Number=MyOption.RollingSpeed;
			var rolledIndex:int=int(moveRect.y/(MyOption.itemHeight+MyOption.spacingBetween));
			if(speed>0)
			{
				if(stopIndex>-1)
				{
					//trace(rolledIndex,stopIndex);
					if(stopIndex>=rolledIndex)
					{
						speed=Math.min(MyOption.RollingSpeed,((MyOption.itemHeight+MyOption.spacingBetween)*stopIndex-moveRect.y)*0.2);
					}
				}
				moveRect.y+=speed;
				
				if(moveRect.y>=marqueeVisioBitmapdata.height-MyOption.itemHeight)
				{
					moveRect.y=0;
				}
				
			}
			else if(speed<0)
			{
				if(stopIndex>-1)
				{
					
					if(stopIndex<=rolledIndex)
					{
						speed=Math.max(MyOption.RollingSpeed,((MyOption.itemHeight+MyOption.spacingBetween)*stopIndex-moveRect.y)*0.2);
					}
					//trace(speed);
				}
				moveRect.y+=speed;
				if(moveRect.y<0)
				{
					
					moveRect.y=marqueeVisioBitmapdata.height-MyOption.itemHeight;
				}
			}
			//trace(marqueeVisio.bitmapData,marqueeVisioBitmapdata);
			filter.blurY=speed;
			filter.blurX=0;
			
			marqueeVisio.bitmapData.copyPixels(marqueeVisioBitmapdata,moveRect,new Point(0,0));
			marqueeVisio.filters=[filter];
			
		}
		public function stopAt(index:int):void
		{
			this.stopIndex=index;
		}
	}
}