package gfw.core
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import gfw.graphic.GraphicsResource;
	import spark.components.Group;
	import spark.core.SpriteVisualElement;
	/**
	 * ...
	 * @author jk
	 */
	public class GameObject extends SpriteVisualElement
	{
		public function GameObject() {

		}
	public function CopyToBackBuffer(db:BitmapData):void	{
		if (m_Graphic == null || !visible) return;
		//db.copyPixels(m_Graphic.bitmap, m_Graphic.bitmap.rect, GetPosition(), m_Graphic.bitmapAlpha, new Point(0, 0), true);
		db.copyPixels(m_BackBuffer, m_BackBuffer.rect, GetPosition());
	}
		/*	
		 * public function copyToBackBuffer(db:BitmapData):void
		{
			if (m_Graphic != null) {
				var position:Point = GetPosition();
				var drawRect:Rectangle = new Rectangle(m_CurrentFrame * m_Graphic.drawRect.width, 0, m_Graphic.drawRect.width, m_Graphic.bitmap.height);
				position.x = GetPosition().x * Game.m_physScale - m_Graphic.drawRect.width/2;
				position.y = GetPosition().y * Game.m_physScale - m_Graphic.drawRect.height / 2;
				/*bmp.rotation = 0;
				
				matrix = bmp.transform.matrix;
				matrix.tx = -bmp.width / 2;
				matrix.ty = -bmp.height / 2;
				matrix.rotate(actor.GetAngle());// * (180 / Math.PI) % 360);
				matrix.tx += actor.GetPosition().x * m_physScale;
				matrix.ty += actor.GetPosition().y * m_physScale;
				bmp.transform.matrix = matrix;
				var matrix:Matrix = new Matrix();
				matrix.translate(position.x, position.y);
				//db.draw(graphics.bitmap, matrix, null, BlendMode.NORMAL);// , new Matrix(), null, flash.display.BlendMode.LAYER, drawRect);
				db.copyPixels(m_Graphic.bitmap, drawRect, position , m_Graphic.bitmapAlpha, new Point(0, 0), true);
			}
		}*/
	protected var m_Position:Point = new Point(0,0);	
	public function GetPosition():Point {
			return m_Position;
			
	}
	override public function set x(value:Number):void {
		m_Position.x =value;
		super.x = value;
	}
	override public function set y(value:Number):void {
		m_Position.y = value;
		super.y = value;
	}
	override public function set visible(value:Boolean):void {
		super.visible = value;
		Invalidate();
	}
	public function Invalidate():void {
		m_Invalidate = true;
	};
	private var m_Invalidate:Boolean = false;
	public function Render(e:Event):void {
		if (m_Graphic == null) return; //skip if shuting down
		if (m_BackBuffer == null) {
				m_BackBuffer = new BitmapData(m_Graphic.drawRect.width, m_Graphic.drawRect.height, true, 0x00000000);
		} else {
			if (!m_Invalidate) return;
		}
		m_Invalidate = false;
		m_BackBuffer.fillRect(m_Graphic.drawRect,0x00000000);
		drawRect= new Rectangle(m_CurrentFrame * m_Graphic.drawRect.width, 0, m_Graphic.drawRect.width, m_Graphic.bitmap.height);
		m_BackBuffer.lock();
		m_BackBuffer.copyPixels(m_Graphic.bitmap, drawRect,pt , m_Graphic.bitmapAlpha, pt, true);
		m_BackBuffer.unlock();
		graphics.clear(); //if clear is not called, we get a memory leak
		graphics.beginBitmapFill(m_BackBuffer,null,false,false);
		graphics.drawRect(0, 0, m_BackBuffer.width, m_BackBuffer.height);
		graphics.endFill();
	
	}
	private var pt:Point = new Point(0, 0);
	private var drawRect:Rectangle = new Rectangle();
	
	public function Tick(dt:Number):void
	{
		if (inuse && m_Graphic != null )
		{
			m_FrameTime += dt;
			//timeDamageIndicator = Math.max(0,(timeDamageIndicator -= 1/graphics.fps));
			if (m_Graphic.fps != -1)
			{
				while (m_FrameTime > 1/m_Graphic.fps)
				{
					m_FrameTime -= 1/m_Graphic.fps;
					m_CurrentFrame = (m_CurrentFrame + 1) % m_Graphic.frames;
					/*if (m_CurrentFrame == 0 && playOnce)
					{
						shutdown();
						break;
					}*/
				}
			}
			/*if (m_Graphic != null) {
				//var position:Point = GetPosition();
				var drawRect:Rectangle = new Rectangle(m_CurrentFrame * m_Graphic.drawRect.width, 0, m_Graphic.drawRect.width, m_Graphic.drawRect.height);
				//position.x = GetPosition().x * Game.m_physScale - graphics.drawRect.width/2;
				//position.y = GetPosition().y * Game.m_physScale - graphics.drawRect.height / 2;
				m_TempBD= new BitmapData(graphics.drawRect.width, graphics.drawRect.height, true , 0x00000000);
				matrix.identity();
				matrix.tx = graphics.drawRect.width / ( -2);
				matrix.ty = graphics.drawRect.height / ( -2);
				matrix.rotate(0);
				matrix.tx += position.x - graphics.drawRect.width / ( -2);
				matrix.ty += position.y - graphics.drawRect.height / ( -2);
				m_TempBD.copyPixels(m_Graphic.bitmap, drawRect, new Point(0,0) , m_Graphic.bitmapAlpha, new Point(0, 0), true)
				m_BackBuffer.draw(m_TempBD, matrix);

			}*/
			
		}
	}
	
	public function StartAnim(Anim:int):void {
			m_AnimationIndex = Anim;
			m_FrameTime = 0;
		}
		public function GetTyp():int {
			return 1;
		}
		public function Hit(Other:GameObject):void {
		}
		public function IsDead():Boolean {
			return false;
		}
		public function Startup():void {
			if (!inuse)	{
				inuse = true;			
				var h:int = 30;
				var w:int = 30;
				var square:Shape = new Shape(); 
				square.graphics.beginFill(0xFF00FF, 1); 
				square.graphics.drawRect(0, 0, w, h); 
				square.graphics.endFill();
				/*backBuffer.copyPixels(g.bitmap,	g.drawRect, 
						new Point(w, h) , 
						g.bitmapAlpha, new Point(0, 0), true);*/
			
				var gr:GraphicsResource = new GraphicsResource(square);
				square = null;
				this.m_Graphic = gr;
				//setupCollision();
			}
		}
		public function Shutdown():void		{
			if (inuse)	{				
				m_Graphic = null;		
				m_Owner = null;
				m_BackBuffer = null;
				if (this.parent != null ) (this.parent as Group).removeElement(this);	//removeChild not supported if container is spark group component
			}
			inuse = false;
		}
		public function SetOwner(owner:GameObject):void {
			m_Owner = owner;
		}
		protected var m_Owner:GameObject = null;
		public var inuse:Boolean = false;
		// higher zOrder objects are rendered on top of lower ones
		public var zOrder:int = 0;
		// the bitmap data to display
		public var m_BackBuffer:BitmapData = null;
		protected var m_TempBD:BitmapData=null;
		protected var m_Graphic:GraphicsResource= null;
		protected var m_AnimationIndex:int = 0;
		protected var m_FrameTime:Number = 0;
		protected var m_CurrentFrame:int = 0;

	}

}