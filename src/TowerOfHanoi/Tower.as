package TowerOfHanoi 
{
	import gfw.core.GameObject;
	import gfw.graphic.GraphicsResource;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author jk
	 */
	public class Tower extends GameObject
	{
		
		public function Tower() {
			m_Blocks = new Array(0);
		}
		override public function Startup():void 
		{
			if (!inuse)	{
				inuse = true;
				var h:int = 30;
				var w:int = 20*5;
				var square:Shape = new Shape();
				square.graphics.clear();
				square.graphics.beginFill(0xFFFF00, 1); 
				square.graphics.drawRoundRect(0, 0, w, h,5); 
				square.graphics.endFill();
				square.graphics.beginFill(0xFF00FF, 1); 
				square.graphics.drawRoundRect(w, 0, w, h,5); 
				square.graphics.endFill();
				square.graphics.beginFill(0x0A00FF, 1); 
				square.graphics.drawRoundRect(2*w, 0, w, h,5); 
				square.graphics.endFill();
				square.graphics.beginFill(0x00FF0A, 1); 
				square.graphics.drawRoundRect(3*w, 0, w, h,5); 
				square.graphics.endFill();

				var gr:GraphicsResource = new GraphicsResource(square, 1, -1, new Rectangle(0, 0, w, h));
				this.m_Graphic = gr;
				this.width = this.m_Graphic.drawRect.width;
				this.height = this.m_Graphic.drawRect.height;
				m_Name = new TextField();
				var format:TextFormat = new TextFormat();
				format.font = "Arial Black";
				format.size = 14;
				m_Name.defaultTextFormat = format;
				m_Name.text = "";
				m_Name.x = this.width / 2;
				addChild(m_Name);
			}
		}
		public function SetText(text:String):void {
			m_Name.text = text;
			m_Name.x = (this.width / 2) -m_Name.textWidth / 2;
		}
		override public function Shutdown():void {
			m_Blocks = null;
			if(m_Name!=null) removeChild(m_Name) ;
			m_Name = null;
			super.Shutdown();
		}
		public function CanPushBlockOnTower(block:Block):Boolean {
			var Result:Boolean = true;
			if (m_Blocks.length == 0) return true;
			Result = (m_Blocks[m_Blocks.length - 1] as Block).GetSize() > block.GetSize();
			return Result;
		}
		public function PushBlockOnTower( block:Block):void {
				m_Blocks.push(block);
		}
		public function PopBlockFromTower( ):Block {
			return (m_Blocks.pop()) as Block;
		}
		public function CanPopBlockFromTower():Boolean {
			var Result:Boolean = true;
			if (m_Blocks.length == 0) return false;
			return Result;
		}
		public function SelectAsTarget(flag:Boolean):void {
			m_IsTarget = flag;
			m_CurrentFrame = flag?1:0;
			Invalidate();
		}
		private var m_Name:TextField = null;
		private var m_IsTarget:Boolean = false;
		public var m_Blocks:Array = null;
	}

}