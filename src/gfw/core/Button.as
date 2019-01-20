package gfw.core 
{
	import gfw.core.GameObject;
	import gfw.graphic.GraphicsResource;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	/**
	 * ...
	 * @author jk
	 */
	public class Button extends GameObject
	{
		
		public function Button() 
		{
			
		}
		override public function CopyToBackBuffer(db:BitmapData):void 		{
		}
		override public function Startup():void 
		{
			if (!inuse)	{
				inuse = true;
				var h:int = 30;
				var w:int = 30;
				var square:Shape = new Shape(); 
		//frame0 = disabled
		//frame1 = enabled
		//frame2 = hover over
		//frame3 = activated
				square.graphics.beginFill(0xFFFF00, 1); 
				square.graphics.drawRect(0, 0, w, h); 
				square.graphics.endFill();
				square.graphics.beginFill(0xFF00FF, 1); 
				square.graphics.drawRect(w, 0, w, h); 
				square.graphics.endFill();
				square.graphics.beginFill(0x0A00FF, 1); 
				square.graphics.drawRect(2*w, 0, w, h); 
				square.graphics.endFill();
				square.graphics.beginFill(0x00FF0A, 1); 
				square.graphics.drawRect(3*w, 0, w, h); 
				square.graphics.endFill();

				var gr:GraphicsResource = new GraphicsResource(square,1,-1,new Rectangle(0,0,w,h));
				SetGraphic(gr);
				Enable(true);
				addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
				addEventListener(MouseEvent.CLICK, Click);
				addEventListener(MouseEvent.DOUBLE_CLICK, Click);
			}
		}
		
		public function SetGraphic(gr: GraphicsResource):void {
			
			/*var square:Shape = new Shape(); 
			square.graphics.beginBitmapFill(Resources.BtArrrowLeftGraphics.bitmap);
			square.graphics.drawRect(0, 0, Resources.BtArrrowLeftGraphics.drawRect.width*4,Resources.BtArrrowLeftGraphics.drawRect.height); 
			square.graphics.endFill();
			
			this.m_Graphic = new GraphicsResource(square,1,-1,new Rectangle(0,0,Resources.BtArrrowLeftGraphics.drawRect.width,Resources.BtArrrowLeftGraphics.drawRect.height));
			*/
			this.m_Graphic = gr;
			this.width = this.m_Graphic.drawRect.width;
			this.height = this.m_Graphic.drawRect.height;
		}
		private function MouseOver(e:MouseEvent):void {
			if(m_Enabled) {
				m_CurrentFrame = 2;
			}else {
				e.stopImmediatePropagation();
			}
		}
		private function Click(e:MouseEvent):void {
			if (m_Enabled) {
				Value = !Value;
			}
			else {
				e.stopImmediatePropagation();
			}
		}
		private function MouseOut(e:MouseEvent):void {
			if(m_Enabled) {
				m_CurrentFrame = m_Value ? 3 : 1;
			} else {
				e.stopImmediatePropagation();
			}
		}
		public function get Value():Boolean {
			return m_Value
		}
		public function set Value(flag:Boolean):void {
			m_Value = false;//flag;
			if (m_Enabled) {
				m_CurrentFrame = m_Value ? 3 : 1;
			}
		}
		public function Enable(flag:Boolean ):void {
			m_Enabled = flag;
			m_CurrentFrame = m_Enabled? ( m_Value ? 3 : 1):0;
			Invalidate();
		}
		public function IsEnabled():Boolean {
			return m_Enabled;
		}
		protected var m_Enabled:Boolean = true;
		protected var m_Value:Boolean = false;
	}

}