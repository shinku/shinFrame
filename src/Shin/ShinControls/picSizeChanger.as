package Shin.ShinControls
{
	
	import Shin.ShinControls.controlTools.picSizeControlNode;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class picSizeChanger extends Sprite
	{
		public static var _instance:picSizeChanger;
		private var leftTopNode:picSizeControlNode=new picSizeControlNode();
		private var rightTopNode:picSizeControlNode=new picSizeControlNode();
		private var leftButtomNode:picSizeControlNode=new picSizeControlNode();
		private var rightButtomNode:picSizeControlNode=new picSizeControlNode();
		private var leftMiddleNode:picSizeControlNode=new picSizeControlNode();
		private var topMiddleNode:picSizeControlNode=new picSizeControlNode();
		private var rightMiddleNode:picSizeControlNode=new picSizeControlNode();
		private var buttomMiddleNode:picSizeControlNode=new picSizeControlNode();
		private var _client:DisplayObject;
		private var initRect:Rectangle;
		private var initScaleX:Number;
		private var initScaleY:Number;
		private var initRotate:Number;
		private var conners:Vector.<picSizeControlNode>=new Vector.<picSizeControlNode>();
		private var middles:Vector.<picSizeControlNode>=new Vector.<picSizeControlNode>();
		private var clickedNode:picSizeControlNode;
		
		
		
		
		private var picMatrix:Matrix;
		public function picSizeChanger():void
		{
			if(!stage)
			{
				this.addEventListener(Event.ADDED_TO_STAGE,handleAdded);
			}
			else
			{
				init();
			}
		}
		private function handleAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,handleAdded);
			init();
		}
		private function init():void
		{
			addChild(leftTopNode);
			addChild(rightTopNode);
			addChild(leftButtomNode);
			addChild(rightButtomNode);
			
			addChild(leftMiddleNode);
			addChild(topMiddleNode);
			addChild(rightMiddleNode);
			addChild(buttomMiddleNode);
			conners=Vector.<picSizeControlNode>([leftTopNode,rightTopNode,rightButtomNode,leftButtomNode]);
			middles=Vector.<picSizeControlNode>([leftMiddleNode,topMiddleNode,rightMiddleNode,buttomMiddleNode]);
			configUI();
			unvisioNodes();
			this.addEventListener(Event.REMOVED_FROM_STAGE,handleRemoved);
		}
		public static function getInstance():picSizeChanger
		{
			if(!_instance)
			{
				_instance=new picSizeChanger();
			}
			return _instance;
		}
		private function configUI():void
		{
			for each(var node:picSizeControlNode in conners)
			{
				node.addEventListener(MouseEvent.MOUSE_DOWN,clickCornnerNode);
			}
			for each(node in middles)
			{
				node.addEventListener(MouseEvent.MOUSE_DOWN,clickMiddleNode);
			}
			stage.addEventListener(MouseEvent.MOUSE_UP,upStage);
		}
		public function control(dis:DisplayObject):void
		{
			_client=dis;
			if(dis.parent)
			{
				var rect:Rectangle=dis.getBounds(dis.parent);
				initRect=rect;
				initScaleX=dis.scaleX;
				initScaleY=dis.scaleY;
				leftTopNode.x=rect.topLeft.x;
				leftTopNode.y=rect.topLeft.y;
				rightTopNode.x=rect.topLeft.x+rect.width;
				rightTopNode.y=rect.topLeft.y;
				leftButtomNode.x=rect.topLeft.x;
				leftButtomNode.y=rect.topLeft.y+rect.height;
				rightButtomNode.x=rect.bottomRight.x;
				rightButtomNode.y=rect.bottomRight.y;
				leftMiddleNode.x=(leftTopNode.x+leftButtomNode.x)/2;
				leftMiddleNode.y=(leftTopNode.y+leftButtomNode.y)/2;
				topMiddleNode.x=(leftTopNode.x+rightTopNode.x)/2;
				topMiddleNode.y=(leftTopNode.y+rightTopNode.y)/2;
				rightMiddleNode.x=(rightTopNode.x+rightButtomNode.x)/2;
				rightMiddleNode.y=(rightTopNode.y+rightButtomNode.y)/2;
				buttomMiddleNode.x=(rightButtomNode.x+leftButtomNode.x)/2;
				buttomMiddleNode.y=(rightButtomNode.y+leftButtomNode.y)/2;
				this.x=dis.parent.x;
				this.y=dis.parent.y;
				visioNodes();
				drawPath();
			}
		}
		public function unvisioNodes():void
		{
			leftTopNode.visible=false;
			rightTopNode.visible=false;
			leftButtomNode.visible=false;
			rightButtomNode.visible=false;
			leftMiddleNode.visible=false;
			topMiddleNode.visible=false;
			rightMiddleNode.visible=false;
			buttomMiddleNode.visible=false;
			clearPath();
		}
		public function visioNodes():void
		{
			leftTopNode.visible=true;
			rightTopNode.visible=true;
			leftButtomNode.visible=true;
			rightButtomNode.visible=true;
			leftMiddleNode.visible=true;
			topMiddleNode.visible=true;
			rightMiddleNode.visible=true;
			buttomMiddleNode.visible=true;
		}
		private function drawPath():void
		{
			graphics.clear();
			graphics.lineStyle(1,0xcccccc);
			graphics.moveTo(leftTopNode.x,leftTopNode.y);
			graphics.lineTo(topMiddleNode.x,topMiddleNode.y);
			graphics.lineTo(rightTopNode.x,rightTopNode.y);
			graphics.lineTo(rightMiddleNode.x,rightMiddleNode.y);
			graphics.lineTo(rightButtomNode.x,rightButtomNode.y);
			graphics.lineTo(buttomMiddleNode.x,buttomMiddleNode.y);
			graphics.lineTo(leftButtomNode.x,leftButtomNode.y);
			graphics.lineTo(leftMiddleNode.x,leftMiddleNode.y);
			graphics.lineTo(leftTopNode.x,leftTopNode.y);
		}
		private  function clearPath():void
		{
			graphics.clear();
		}
		private function clickCornnerNode(e:MouseEvent):void
		{
			clickedNode=e.currentTarget as picSizeControlNode;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,handleMoveConner);
		}
		private function clickMiddleNode(e:MouseEvent):void
		{
			clickedNode=e.currentTarget as picSizeControlNode;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,handleMoveMiddle);
		}
		private function upStage(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,handleMoveConner);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,handleMoveMiddle);
		}
		private function handleRemoved(e:Event):void
		{
			
		}
		private function handleMoveConner(e:MouseEvent):void
		{
			
			clickedNode.x=mouseX;
			clickedNode.y=mouseY;
			if(clickedNode==leftTopNode)
			{
				leftButtomNode.x=caculateNewPoint(clickedNode.x);
				rightTopNode.y=caculateNewPoint(clickedNode.y);
				leftMiddleNode.x=caculateNewPoint(clickedNode.x);
				leftMiddleNode.y=caculateNewPoint((clickedNode.y+leftButtomNode.y)/2);
				topMiddleNode.y=caculateNewPoint(clickedNode.y);
				
				topMiddleNode.x=caculateNewPoint((clickedNode.x+rightTopNode.x)/2);
				
			}
			drawPath();
			CalculationSize();
		}
		public function caculateNewPoint(_x:Number):Number
		{
			return _x;
		}
		private function handleMoveMiddle(e:MouseEvent):void
		{
			if(clickedNode==topMiddleNode || clickedNode==buttomMiddleNode)
			{
				clickedNode.y=mouseY;
			}
			else
			{
				clickedNode.x=mouseX;
			}
			drawPath();
		}
		private function getIndexCornner(picnode:picSizeControlNode):int
		{
			var index:int;
			for(var i:int=0;i<this.conners.length;i++)
			{
				if(conners[i]==picnode)
				{
					index=i;
				}
			}
			return 	index;
		}
		private function CalculationSize():void
		{
			
			var tempRect:Rectangle=new Rectangle();
			tempRect.width=Math.sqrt((leftTopNode.x-rightTopNode.x)*(leftTopNode.x-rightTopNode.x)+(leftTopNode.y-rightTopNode.y)*(leftTopNode.y-rightTopNode.y));
			
		}
	}
}