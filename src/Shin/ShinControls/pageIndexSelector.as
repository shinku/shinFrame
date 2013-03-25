package Shin.ShinControls
{
	import Shin.ShinControls.controlTools.pageIndexNode;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	public class pageIndexSelector extends Sprite
	{
		private var totalPageNum:int=1;
		private var selectedPageIndex:int=1;
		private var showNum:Number=7;
		private var selectedNodes:Vector.<pageIndexNode>=new Vector.<pageIndexNode>();
		private var numbersChoosen:Object=new Object();
		private var _clickedID:int=0;
		public var effectColor:uint=0x00CCFF;
		public function pageIndexSelector(_showNum:int=6)
		{
			this.showNum=_showNum;
		}
		public function upDatePageIndex(_currentPage:int,totalPageIndex:int):void
		{
			this.selectedPageIndex=_currentPage;
			this.totalPageNum=totalPageIndex;
			removeAllChild();
			if(totalPageIndex>0 && _currentPage>0)
			{
				//trace("build num line");
				//selectedNodes=new Vector.<pageIndexNode>
				buildNumLine();
			}
		}
		private function removeAllChild():void
		{
			while(this.numChildren>0)
			{
				var child:DisplayObject=this.getChildAt(0);
				removeChild(child);
				child=null;
			}
		}
		private function buildNumLine():void
		{
			this.numbersChoosen=new Object();
			selectedNodes=new Vector.<pageIndexNode>();
			var labsStr:Vector.<String>=new Vector.<String>();
			if(totalPageNum>this.showNum)
			{
				if(this.totalPageNum-this.selectedPageIndex>this.showNum)
				{
					
					for(var i:int=this.selectedPageIndex;i<=this.selectedPageIndex+4;i++)
					{
						labsStr.push(i);
					}
					labsStr.push("...");
					labsStr.push(this.totalPageNum);
				}
				else
				{
					for(i=this.totalPageNum;i>this.totalPageNum-this.showNum;i--)
					{
						labsStr.unshift(i);
					}
				}
			}
			else
			{
				for(i=1;i<=this.totalPageNum;i++)
				{
					labsStr.push(i);
				}
			}		
			var disSpecial:Number=0;
			for(i=0;i<labsStr.length;i++)
			{
				var node:pageIndexNode=new pageIndexNode(labsStr[i]);
				var length:int=0;
				if(labsStr[i]!="...")
				{
					node.buttonMode=true;
					selectedNodes.push(node);
				}
				else
				{
					length=selectedNodes.length;
					disSpecial=node.width+2;
					node.x=selectedNodes[length-1].x+selectedNodes[length-1].width+2
				}
				
				if(selectedNodes.length>=2)
				{
					length=selectedNodes.length-1;
					node.x=selectedNodes[length-1].x+selectedNodes[length-1].width+2+disSpecial;
				}
				addChild(node);
			}
			for(i=0;i<selectedNodes.length;i++)
			{
				selectedNodes[i].addEventListener(MouseEvent.MOUSE_DOWN,clickNode);
				numbersChoosen[selectedNodes[i].label]=selectedNodes[i];
				//this.dispatchEvent(new Event(Event.CHANGE));
				//var node:pageIndexNode=selectedNodes[i];
			}
			if(this._clickedID!=0 && numbersChoosen[this._clickedID]!=undefined)
			{
				this.newClickedID=this._clickedID;
			}
			else
			{
				if(selectedNodes.length>0)
				{
					setUE(selectedNodes[0]);
				}
			}
			
		}
		private function clickNode(e:MouseEvent):void
		{
			var node:pageIndexNode=e.currentTarget as pageIndexNode;
			this._clickedID=int(node.label);
			dispatchEvent(new Event(Event.CHANGE));
			setUE(node);
			var id:int=int(node.label)+1;
			if(this.numbersChoosen[id]==undefined && id<this.totalPageNum)
			{
				this.upDatePageIndex(id-this.showNum/2,this.totalPageNum);
				return;
			}
			id=int(node.label)-1;
			trace("NodeLabel="+_clickedID)
			if(this.numbersChoosen[id]==undefined && id!=0)
			{
				id=Math.max(1,id-1);
				//trace(id);
				this.upDatePageIndex(id,this.totalPageNum);
				return;
			}
		}
		public function get clickedID():int
		{
			return this._clickedID;
		}
		public function set newClickedID(id:int):void
		{
			this._clickedID=id;
			if(numbersChoosen[id]==undefined)
			{
				this.upDatePageIndex(id,this.totalPageNum);
			}
			else
			{
				var tid:int=id+1;
				if(numbersChoosen[tid]==undefined && tid<this.totalPageNum)
				{
					this.upDatePageIndex(tid,this.totalPageNum)
						return;
				}
				tid=id-1;
				if(numbersChoosen[tid]==undefined && tid!=0)
				{
					tid=Math.max(1,tid-1);
					//trace(tid);
					this.upDatePageIndex(tid,this.totalPageNum);
					return;
				}
			}
			setUE(numbersChoosen[id]);
			return;
		}
		protected function setUE(node:pageIndexNode):void
		{
			for(var i:int=0;i<selectedNodes.length;i++)
			{
				if(selectedNodes[i]!=node)
				{
					selectedNodes[i].filters=null;
				}
				else
				{
					node.filters=[new GlowFilter(effectColor,1,6,6,3)]
				}
			}	
		}
	}
}