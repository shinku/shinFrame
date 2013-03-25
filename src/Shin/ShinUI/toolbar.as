package Shin.ShinUI
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class toolbar extends Sprite
	{
		protected var _bar:Sprite;
		protected var _client:DisplayObject;
		protected var _maskLength:Number;
		protected var _startPoint:Point;
		protected var _toolbarLength:Number
		protected var _dragRectangle:Rectangle;
		protected var isChild:Boolean=false;
		public function toolbar():void
		{
				if(!stage)
				{
					this.addEventListener(Event.ADDED_TO_STAGE,handleAdded);
				}
				else
				{
					setInit();
				}
		}
		
		//子类在初始化的时候进行 option的初始化工作 ;
		protected function initOption($bar:Sprite,$_rentangel:Rectangle):void
		{
			_bar=$bar;
			_dragRectangle=$_rentangel;
			_bar.buttonMode=true;
		}
		private function handleAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,handleAdded);
			setInit();
		}
		public function setInit():void
		{
			if(_bar)
			{
				_bar.x=_dragRectangle.x;
				_bar.y=_dragRectangle.y;
				_bar.addEventListener(MouseEvent.MOUSE_DOWN,clickBar);
				if(_client)
				{
					this.addEventListener(Event.ENTER_FRAME,onEnterframe);
				}
				if(stage)
				{
					stage.addEventListener(MouseEvent.MOUSE_UP,upStage);
				}
				this.addEventListener(Event.REMOVED_FROM_STAGE,handleremoved);
			}
		}
		public function set client(obj:DisplayObject):void
		{
			this._client=obj;
			_bar.x=_dragRectangle.x;
			_bar.y=_dragRectangle.y;
			this.addEventListener(Event.ENTER_FRAME,onEnterframe);
			if(_client.height<this._maskLength)
			{
				this.visible=false;
			}
			else
			{
				this.visible=true;
			}
		}
		public function set startPoint(point:Point):void
		{
			this._startPoint=point;
		}
		protected function set maskLength(val:Number):void
		{
			this._maskLength=val;
			if(!_client)
			{
				return;
				
			}
			if(_client.height<this._maskLength)
			{
				this.visible=false;
			}
			else
			{
				this.visible=true;
			}
		}
		protected function onEnterframe(e:Event):void
		{
			//if(_client)
			//{
			//	_client.x=
			//}
			
		}
		private function clickBar(e:MouseEvent):void
		{
			if(_dragRectangle)
			{
				_bar.startDrag(false,_dragRectangle);
			}
			else
			{
				throw(new Error("子类的 dragRectangle(拖拽范围)没有定义"));
			}
		}
		private function upStage(e:MouseEvent):void
		{
			_bar.stopDrag();
			
		}
		protected function handleremoved(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME,onEnterframe);
			stage.removeEventListener(MouseEvent.MOUSE_UP,upStage);
		}
	}
}