package TowerOfHanoi 
{
	import animation.MoveThis;
	import gfw.core.GameObject;
	import gfw.graphic.GraphicsResource;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	/**
	 * ...
	 * @author jk
	 */
	public class Block extends GameObject
	{
		
		public function Block() 	{
			
		}
		override public function Startup():void 
		{
			if (!inuse)	{
				inuse = true;
				SetSize(1);
				
				//MoveThis.startTween(this, { x:this.x+30, y:this.y + 30 }, 30,{easing:"Reverse.easeInOut", loop:true }); 
				//MoveThis.startTween(null,{pause:k},0,{onComplete:OnPlayFrameCompleted});
			}
		}
		private function CreateGraphic():void {
			var h:int = 30;
			var w:int = 20 * GetSize();
			var square:Shape = new Shape(); 
			square.graphics.beginFill(0xFF0000, 1); 
			square.graphics.drawRect(0, 0, w, h); 
			square.graphics.endFill();
			var gr:GraphicsResource = new GraphicsResource(square);
			this.m_Graphic = gr;
			this.width = w;
			this.height = h;
		}
		public function SetSize(size:int):void {
			m_Size = size;
			CreateGraphic();		
		}
		public function GetSize():int {
			return m_Size;
		}
		private var m_Size:int = 1;
	}

}