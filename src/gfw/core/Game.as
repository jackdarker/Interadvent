package gfw.core
{
	import flash.events.Event;
	import flash.display.*;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.utils.Timer;
	import gfw.sound.SoundManager;
	import mx.collections.*;
	import mx.core.UIComponent;
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	import spark.core.SpriteVisualElement;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import gfw.input.Input;
	import gfw.core.GameObjectManager;
	import gfw.sound.SoundManager;
	/**
	 * ...
	 * @author jk
	 */
	public class Game 
	{
		static public const WndWidth:int = 700;
		static public const WndHeight:int = 500;
		static public const m_physScale:Number = 1;
	public function Game(sprite:Group) {
			m_Sprite = sprite;
			m_input = new Input(sprite);
			m_SoundManager = new SoundManager();
			m_BackBuffer = new BitmapData(m_Sprite.width, m_Sprite.height, false,m_ClearColor);
			//setupWorld();	
			//setupDebugDraw();
			//SetupHud();
			//NewLevel();
			//ShowMainMenu();
	}
	
	public function ShowMainMenu():void {
		/*m_Screen = null;
		m_Screen = new ScreenMainMenu(this);
		m_Sprite.addChild(m_Screen);
		m_Screen.CenterScreen();	*/	
	}
	public function ShowGameOver():void {
		/*m_Screen = null;
		m_Screen = new ScreenGameOver(this);
		m_Sprite.addChild(m_Screen);
		m_Screen.CenterScreen();*/
	}
	public function Shutdown():void {
		m_LoopTimer.stop();
		m_LoopTimer = null;
	}
	public function NewLevel():void	{	
		if (m_Level != null) {
			m_Level.Shutdown();
			m_Level = null;
		}
		
	}
	
	public function MouseDrag():void {
		if (IsGamePaused() || IsGameRunning()) return;
		Input.mouseDragX
	}
	public function MousePress():void {
		if (IsGamePaused() || !IsGameRunning()) return;
		//toogle pause on p
		if ( Input.isKeyReleased(80) ) {
			ShowMainMenu();
		}
	}
	public function UpdateMouseWorld():void{
		mouseXWorldPhys = (Input.mouseX)/m_physScale; 
		mouseYWorldPhys = (Input.mouseY)/m_physScale; 
		mouseXWorld = (Input.mouseX); 
		mouseYWorld = (Input.mouseY); 
	}
	public function PauseGame(Flag:Boolean):void {
		m_GamePaused = Flag;
		if (!Flag) {
			m_LastFrame = new Date();
		}
	}
	public function IsGamePaused():Boolean {
		return m_GamePaused;
	}
	public function IsLevelCompleted():Boolean {
		var result:Boolean = true;
		//??
		return result;
	}
	public function IsGameRunning():Boolean {
		if (m_Level != null) return true;
		
		return false;
	}
	public function IsGameOver():Boolean {
		if ( m_GameOver) return true;
		if ( IsGameRunning()) {
		//??
		}
		return false;
	}
	public function Tick(e:Event):void {
		if (IsGameOver()) {
			m_Level.Shutdown();
			m_Level = null;
			m_GameOver = false;
			ShowGameOver();
		}
		if(IsGameRunning())	UpdateGame(e);
	
    }
	protected function RenderGame(e:Event):void {
		m_BackBuffer.lock();
		m_BackBuffer.fillRect(m_BackBuffer.rect,0xFFFFFF);
		var cursor:IViewCursor= GameObjectManager.Instance.CreateCursor();
		while (cursor.current != null ) {
			cursor.current.Render(null);
			cursor.current.CopyToBackBuffer(m_BackBuffer);
			cursor.moveNext();
		}
		cursor = null;
		m_BackBuffer.unlock();
		m_Sprite.graphics.clear(); //if clear is not called, we get a memory leak
		m_Sprite.graphics.beginBitmapFill(m_BackBuffer,null,false,false);
		m_Sprite.graphics.drawRect(0, 0, m_BackBuffer.width, m_BackBuffer.height);
		m_Sprite.graphics.endFill();
		/*testsprite.graphics.clear(); //if clear is not called, we get a memory leak
		testsprite.graphics.beginBitmapFill(m_BackBuffer,null,false,false);
		testsprite.graphics.drawRect(0, 0, m_BackBuffer.width, m_BackBuffer.height);
		testsprite.graphics.endFill();*/
	}
	protected function UpdateGame(e:Event):void {
		MousePress();
		if (!IsGamePaused() ) {
			// Calculate the time since the last frame
			var thisFrame:Date = new Date();
			var _seconds:Number = (thisFrame.getTime() - m_LastFrame.getTime())/1000.0;
			m_LastFrame = thisFrame;
			UpdateMouseWorld();
			MouseDrag();
			
			//
			m_Level.Tick(_seconds);

			if (IsGameOver()) {
				m_GameOver = true;
			}
		}
		Input.update();
    }
	public function GetView():Group {
		return m_Sprite;
	}
	public function GetSoundMngr():SoundManager {
		return m_SoundManager;
	}
	protected var m_Sprite:Group = null;
	protected var m_Level:Level = null;
	protected var m_GamePaused:Boolean = false;
	protected var m_GameOver:Boolean = false;
	protected var m_LoopTimer:Timer = null;
	protected var m_input:Input;
	protected var m_SoundManager:SoundManager = null;
	// world mouse position
	static public var mouseXWorldPhys:Number;
	static public var mouseYWorldPhys:Number;
	static public var mouseXWorld:Number;
	static public var mouseYWorld:Number;
	static public var timeStep:Number = 1.0 / 40.0;		//??
	// double buffer
	private var m_BackBuffer:BitmapData;
	// colour to use to clear backbuffer with 
	private var m_ClearColor:uint = 0xFFFFFF;
	// static instance 
	//??protected static var instance:GameObjectManager = null;
	// the last frame time 
	protected var m_LastFrame:Date;

	}

}