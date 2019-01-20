package RiddleStrip 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import gfw.components.TextWindow;
	import gfw.core.ToggleButton;
	import mx.collections.*;
	import spark.utils.TextFlowUtil;
	import spark.components.RichText;
	import gfw.core.GameObject;
	import gfw.core.Game;
	import gfw.core.GameObjectManager
	import gfw.core.Button;
	import gfw.core.Level;
	import animation.MoveThis;
	import gfw.graphic.GraphicsResource;
	/**
	 * ...
	 * @author jk
	 * enthält alle Level-Objekte und -zustände
	 */
	public class RiddleStripLevel extends Level
	{
		
	public function RiddleStripLevel(Controller:Game) {
		super(Controller);
	}
	private function InitPic( gr:GraphicsResource):Picture {
		var Obj:Picture = new Picture();
		Obj.Startup();
		Obj.SetGraphic( gr);
		//m_Controller.GetView().addElement(Obj);
		GameObjectManager.Instance.addBaseObject(Obj);
		Obj.x = 200;
		return Obj;
	}
	override public function Startup():void {
		m_State = new GameState();
		m_Body = new Array();
		m_Body[GameState.LULEG] = InitPic( Resources.LULegGraphics);
		m_Body[GameState.LARM] = InitPic( Resources.LArmGraphics);
		m_Body[GameState.LARM2] = InitPic( Resources.LArm2Graphics);
		m_Body[GameState.LARMJACKET] = InitPic( Resources.LArmJacketGraphics);
		m_Body[GameState.NECK] = InitPic( Resources.NeckGraphics);
		m_Body[GameState.TAIL] = InitPic( Resources.TailGraphics);
		m_Body[GameState.CHEST]=InitPic( Resources.ChestGraphics);
		m_Body[GameState.SHEATH] = InitPic( Resources.SheathGraphics);
		m_Body[GameState.SHEATH2] = InitPic( Resources.Sheath2Graphics);
		m_Body[GameState.SHEATH3] = InitPic( Resources.Sheath3Graphics);
		m_Body[GameState.RLLEG] = InitPic( Resources.RLLegGraphics);
		m_Body[GameState.RLLEGWRIST] = InitPic( Resources.RLegWristGraphics);
		m_Body[GameState.SHOE] = InitPic( Resources.RLLegShoeGraphics);
		m_Body[GameState.BOOT] = InitPic( Resources.RLLegBootGraphics);
		m_Body[GameState.TAIL2] = InitPic( Resources.Tail2Graphics);
		m_Body[GameState.COCK2] = InitPic( Resources.Cock2Graphics);
		m_Body[GameState.COLLAR1] = InitPic( Resources.Collar1Graphics);
		m_Body[GameState.COLLAR2] = InitPic( Resources.Collar2Graphics);
		m_Body[GameState.COCKGEAR1] = InitPic( Resources.CockGear1Graphics);
		m_Body[GameState.NIPPLE1] = InitPic( Resources.Nipple1Graphics);
		m_Body[GameState.NIPPLE2] = InitPic( Resources.Nipple2Graphics);
		m_Body[GameState.CHESTBOND] = InitPic( Resources.ChestBondGraphics);
		m_Body[GameState.RULEG] = InitPic( Resources.RULegGraphics);
		m_Body[GameState.COCKGEAR3] = InitPic( Resources.CockGear3Graphics);
		m_Body[GameState.RULEGWRIST] = InitPic( Resources.RULegWristGraphics);
		m_Body[GameState.SPREADBAR] = InitPic( Resources.SpreadbarGraphics);
		m_Body[GameState.PANTYS] = InitPic( Resources.PantysGraphics);
		m_Body[GameState.BELLY2] = InitPic( Resources.Belly2Graphics);
		m_Body[GameState.PANTS] = InitPic( Resources.PantsGraphics);
		m_Body[GameState.SHIRT] = InitPic( Resources.ShirtGraphics);
		m_Body[GameState.CHESTJACKET] = InitPic( Resources.ChestJacketGraphics);
		m_Body[GameState.HEAD] = InitPic( Resources.HeadGraphics);
		
		m_Body[GameState.BLIND] = InitPic( Resources.BlindGraphics);
		m_Body[GameState.MUZZLE1] = InitPic( Resources.MuzzleGraphics);
		m_Body[GameState.MUZZLE2] = InitPic( Resources.Muzzle2Graphics);
		m_Body[GameState.RARM] = InitPic( Resources.RArmGraphics);
		m_Body[GameState.RARMJACKET] = InitPic( Resources.RArmJacketGraphics);
		m_Body[GameState.RARMWRIST2] = InitPic( Resources.RArmWrist2Graphics);
		m_Body[GameState.RARMWRIST] = InitPic( Resources.RArmWristGraphics);
		m_Body[GameState.PIERCING] = InitPic( Resources.PiercingGraphics);
		m_Body[GameState.SPOOGE] = InitPic( Resources.SpoogeGraphics);
		
		m_Text = new TextWindow();
		m_Text.x = 10;
		m_Text.y = 10;
		m_Text.height = 600;
		m_Text.width = 200;
		m_Controller.GetView().addElement(m_Text);
		
		var Bt:Button;
		var Bt1:Button;
		
		Bt= m_BtA = new Button();
		Bt.Startup();
		Bt.SetGraphic(CreateButtonGraphic(Resources.BtAGraphics));
		m_Controller.GetView().addElement(Bt);
		Bt.x = 10;
		Bt.y = m_Text.y + m_Text.height + 10; 
		GameObjectManager.Instance.addBaseObject(Bt);
		Bt.addEventListener(MouseEvent.CLICK, OnBtA);
		Bt.addEventListener(MouseEvent.ROLL_OVER, OnRollOver);
		Bt1 = Bt;
		
		Bt= m_BtB = new Button();
		Bt.Startup();
		Bt.SetGraphic(CreateButtonGraphic(Resources.BtBGraphics));
		m_Controller.GetView().addElement(Bt);
		Bt.x = Bt1.x + Bt1.width + 10;
		Bt.y = Bt1.y; 
		GameObjectManager.Instance.addBaseObject(Bt);
		Bt.addEventListener(MouseEvent.CLICK, OnBtA);
		Bt.addEventListener(MouseEvent.ROLL_OVER, OnRollOver);
		Bt1 = Bt;
		
		Bt= m_BtC = new Button();
		Bt.Startup();
		Bt.SetGraphic(CreateButtonGraphic(Resources.BtCGraphics));
		m_Controller.GetView().addElement(Bt);
		Bt.x = Bt1.x + Bt1.width + 10;
		Bt.y = Bt1.y; 
		GameObjectManager.Instance.addBaseObject(Bt);
		Bt.addEventListener(MouseEvent.CLICK, OnBtA);
		Bt.addEventListener(MouseEvent.ROLL_OVER, OnRollOver);
		Bt1 = Bt;
		
		Bt= m_BtD = new Button();
		Bt.Startup();
		Bt.SetGraphic(CreateButtonGraphic(Resources.BtDGraphics));
		m_Controller.GetView().addElement(Bt);
		Bt.x = Bt1.x + Bt1.width + 10;
		Bt.y = Bt1.y; 
		GameObjectManager.Instance.addBaseObject(Bt);
		Bt.addEventListener(MouseEvent.CLICK, OnBtA);
		Bt.addEventListener(MouseEvent.ROLL_OVER, OnRollOver);
		Bt1 = Bt;
		
		Bt= m_BtOK = new Button();
		Bt.Startup();
		Bt.SetGraphic(CreateButtonGraphic(Resources.BtOKGraphics));
		m_Controller.GetView().addElement(Bt);
		Bt.x = 10;
		Bt.y = Bt1.y + Bt1.width + 10; 
		GameObjectManager.Instance.addBaseObject(Bt);
		Bt.addEventListener(MouseEvent.CLICK, OnOK);
		Bt1 = Bt;	
		
		Bt= m_BtRestart = new Button();
		Bt.Startup();
		Bt.SetGraphic(CreateButtonGraphic(Resources.BtRestartGraphics));
		m_Controller.GetView().addElement(Bt);
		Bt.x = Bt1.x + Bt1.width +10;
		Bt.y =  Bt1.y;
		GameObjectManager.Instance.addBaseObject(Bt);
		Bt.addEventListener(MouseEvent.CLICK, OnRestart);
		Bt1 = Bt;
		
		{
			m_BtSelect = new Array();
			CreateSelectionBt(GameState.PANTS);
			CreateSelectionBt(GameState.PANTYS);
			CreateSelectionBt(GameState.BOOT);
			CreateSelectionBt(GameState.SHOE);
			CreateSelectionBt(GameState.CHESTJACKET);
			CreateSelectionBt(GameState.COLLAR1);
			CreateSelectionBt(GameState.COLLAR2);
			CreateSelectionBt(GameState.SHIRT);
			CreateSelectionBt(GameState.COCK2);
			CreateSelectionBt(GameState.COCKGEAR1);
			CreateSelectionBt(GameState.SHEATH3);
			CreateSelectionBt(GameState.COCKGEAR3);
			CreateSelectionBt(GameState.TAIL2);
			CreateSelectionBt(GameState.RARMWRIST);
			CreateSelectionBt(GameState.RARMWRIST2);
			CreateSelectionBt(GameState.RULEGWRIST);
			CreateSelectionBt(GameState.SPREADBAR);
			CreateSelectionBt(GameState.BELLY2);
			CreateSelectionBt(GameState.RLLEGWRIST);
			CreateSelectionBt(GameState.NIPPLE1);
			CreateSelectionBt(GameState.NIPPLE2);
			CreateSelectionBt(GameState.CHESTBOND);
			CreateSelectionBt(GameState.BLIND);
			CreateSelectionBt(GameState.MUZZLE1);
			CreateSelectionBt(GameState.MUZZLE2);
			CreateSelectionBt(GameState.PIERCING);
			CreateSelectionBt(GameState.SPOOGE);
		}
		
		Bt = null;
		Bt1 = null;
		
		UpdateVisibility();
		m_Controller.PauseGame(false);
	}
	private function CreateSelectionBt(Name:int):void {
		var Bt:Button = new ToggleButton();
		m_BtSelect[Name] = Bt;
		Bt.Startup();
		Bt.SetGraphic(CreateButtonGraphic(Resources.BtGraphics));
		m_Controller.GetView().addElement(Bt);
		Bt.Value = false;
		var gap:int = 30;
		var left:int = (m_Body[GameState.TAIL] as Picture).x+gap;
		var top:int = (m_Body[GameState.TAIL] as Picture).y;
		var right:int = left - 2 * gap + 600;
		switch (Name) {
			case GameState.BOOT:
				Bt.name = "Boots";
				Bt.x =  left;
				Bt.y =   top +600;
				break;
			case GameState.SHOE:
				Bt.name = "Shoes";
				Bt.x = left +gap;
				Bt.y =  top +600;
				break;
			case GameState.RLLEGWRIST:
				Bt.name = "Footcuffs";
				Bt.x = left +2*gap;
				Bt.y = top +600;
				break;
			case GameState.SPREADBAR:
				Bt.name = "Spreaderbar";
				Bt.x = left +3*gap;
				Bt.y = top +600;
				break;
			case GameState.BELLY2:
				Bt.name = "Bellychain";
				Bt.x = left +2*gap;
				Bt.y = top +550;
				break;
			case GameState.RULEGWRIST:
				Bt.name = "Ribbon";
				Bt.x = left +3*gap;
				Bt.y = top +550;
				break;
			case GameState.RARMWRIST:
				Bt.name = "Handcuffs";
				Bt.x = left +4*gap;
				Bt.y = top +550;
				break;
			case GameState.RARMWRIST2:
				Bt.name = "Handcuff-Bar";
				Bt.x = left +5*gap;
				Bt.y = top +550;
				break;
			case GameState.PANTS:
				Bt.name = "Pants";
				Bt.x = left;
				Bt.y =  top +500;
				break;
			case GameState.PANTYS:
				Bt.name = "Pantys";
				Bt.x = left +gap;
				Bt.y = top +500;
				break;
			case GameState.TAIL2:
				Bt.name = "Tail";
				Bt.x = left +2*gap;
				Bt.y = top +500;
				break;
				
			case GameState.COLLAR1:
				Bt.name = "Collar1";
				Bt.x = right;
				Bt.y = top +200;
				break;
			case GameState.COLLAR2:
				Bt.name = "Collar2";
				Bt.x = right - gap;
				Bt.y = top +200;
				break;
			case GameState.MUZZLE1:
				Bt.name = "Muzzle1";
				Bt.x = right - 2*gap;
				Bt.y = top +200;
				break;
			case GameState.MUZZLE2:
				Bt.name = "Muzzle2";
				Bt.x = right - 3*gap;
				Bt.y = top +200;
				break;
			case GameState.BLIND:
				Bt.name = "Blindfold";
				Bt.x = right - 4*gap;
				Bt.y = top +200;
				break;
			case GameState.CHESTJACKET:
				Bt.name = "Jacket";
				Bt.x = right  ;
				Bt.y = top +250;
				break;
			case GameState.SHIRT:
				Bt.name = "Shirt";
				Bt.x = right - gap;
				Bt.y = top +250;
				break;
			case GameState.NIPPLE1:
				Bt.name = "Nipples";
				Bt.x = right - 2*gap;
				Bt.y = top +250;
				break;
			case GameState.NIPPLE2:
				Bt.name = "Nipplechain";
				Bt.x = right - 3*gap;
				Bt.y = top +250;
				break;
			case GameState.CHESTBOND:
				Bt.name = "Leathercage";
				Bt.x = right - 4*gap;
				Bt.y = top +250;
				break;
			case GameState.COCK2:
				Bt.name = "Cock";
				Bt.x = right ;
				Bt.y = top +300;
				break;
			case GameState.SHEATH3:
				Bt.name = "Cockrings";
				Bt.x = right -gap ;
				Bt.y = top +300;
				break;
			case GameState.COCKGEAR1:
				Bt.name = "Cockgear";
				Bt.x = right -2*gap ;
				Bt.y = top +300;
				break;
			case GameState.COCKGEAR3:
				Bt.name = "Cockgear ext";
				Bt.x = right -3*gap ;
				Bt.y = top +300;
				break;
			case GameState.PIERCING:
				Bt.name = "Piercings";
				Bt.x = right -gap ;
				Bt.y = top +100;
				break;
			case GameState.SPOOGE:
				Bt.name = "Spooge";
				Bt.x = right -2*gap ;
				Bt.y = top +100;
				break;
			default:
				break;
		}
		
		GameObjectManager.Instance.addBaseObject(Bt);
		Bt.addEventListener(MouseEvent.ROLL_OVER, OnRollOver);
		Bt.addEventListener(MouseEvent.ROLL_OUT, OnRollOut);
		Bt.addEventListener(MouseEvent.CLICK, OnBtA);
		
	}
	private function CreateButtonGraphic(singleBitmap:GraphicsResource):GraphicsResource {
		var Gr:GraphicsResource = null; 
		var h:int = singleBitmap.drawRect.height;
		var w:int = singleBitmap.drawRect.width;
		var square:Shape = new Shape(); 
		
		var bitmap:BitmapData;
		bitmap = singleBitmap.bitmap.clone();
		bitmap.colorTransform(singleBitmap.bitmap.rect, new ColorTransform(1, 1, 1, 1, 100, 100, 100));
		square.graphics.beginBitmapFill(bitmap);
		square.graphics.drawRect(0, 0, w , h); 
		square.graphics.endFill();
		
		bitmap = singleBitmap.bitmap.clone();
		square.graphics.beginBitmapFill(bitmap);
		square.graphics.drawRect(w, 0, w , h); 
		square.graphics.endFill();
		
		bitmap = singleBitmap.bitmap.clone();
		bitmap.colorTransform(singleBitmap.bitmap.rect, new ColorTransform(1, 1, 1, 1, 0, 0, 100));
		square.graphics.beginBitmapFill(bitmap);
		square.graphics.drawRect(w*2, 0, w , h); 
		square.graphics.endFill();
		
		bitmap = singleBitmap.bitmap.clone();
		bitmap.colorTransform(singleBitmap.bitmap.rect, new ColorTransform(1, 1, 1, 1, 100, 0, 0));
		square.graphics.beginBitmapFill(bitmap);
		square.graphics.drawRect(w*3, 0, w , h); 
		square.graphics.endFill();
		
		Gr = new GraphicsResource(square,1,-1,new Rectangle(0,0,singleBitmap.drawRect.width,singleBitmap.drawRect.height));
		return Gr;
	}
	override public function Shutdown(): void {
		m_Controller.PauseGame(true);
		m_BtA = null;
		m_BtB = null;
		m_BtOK = null;
		m_BtC = null;
		m_BtD = null;
		m_Text= null;
		m_BtRestart = null;
		m_State = null;
		GameObjectManager.Instance.shutdown();
	}
	override public function Tick(dt:Number):void {
		var cursor:IViewCursor= GameObjectManager.Instance.CreateCursor();
		while (cursor.current != null ) {
			cursor.current.Tick(dt);
			cursor.moveNext();
		}
		cursor = null;
				
		/*for each(var Obj:GameObject in GameObjectManager.Instance.GObjects) {
			Obj.Tick(dt);
		}*/
		GameObjectManager.Instance.enterFrame();
	}
	public function UpdateVisibility():void {
		var Total:int = m_State.EnabledOption.length;
		for (var i:int = Total - 1; i >= 0; i-- ) {
			if (m_BtSelect[i] != null) {
				(m_BtSelect[i] as ToggleButton).visible = m_State.EnabledOption[i] > 0;//.Enable(m_State.m_EnabledOption[i]);
				(m_BtSelect[i] as ToggleButton).Value=m_State.m_Visible[i];
			}
		}
		//for ( i = Total - 1; i >= 0; i-- ) {
		var _pic:Picture;
		for ( i = 0; i<Total; i++ ) {
			if (m_Body[i] != null) {
				_pic = (m_Body[i] as Picture);
				_pic.visible = m_State.m_Visible[i];
				
			}
		}
		_pic = null;
		m_Text.SetText(m_State.GetUserMessage());
		switch (m_State.State) {
			case GameState.STATE_GREETINGS:
			//case GameState.STATE_GUESSING:
			case GameState.STATE_RIGHT:
			case GameState.STATE_WRONG:
			case GameState.STATE_STRIPPING:
			case GameState.STATE_UNSTRIPPING:
				m_BtRestart.Enable(true);
				m_BtOK.Enable(true);
				break;
			case GameState.STATE_YOULOOSE:
			case GameState.STATE_YOUWIN:
			case GameState.STATE_YOUWINSUPER:
				m_BtRestart.Enable(true);
				m_BtOK.Enable(false);
				break;
			default:
				m_BtRestart.Enable(false);
				m_BtOK.Enable(false);
				break;
		}
		var i:int = m_State.GetChoices();
		m_BtA.Enable(i>0);
		m_BtB.Enable(i>1);
		m_BtC.Enable(i>2);
		m_BtD.Enable(i>3);		
	}
	override public function IsLevelFinished():Boolean 	{
		return false;
	}
	private function UpdateScore():void {
	}
	public function OnRestart(e:Event):void {
		Shutdown();
		Startup();
	}
	public function OnOK(e:Event):void {
		m_State.OnOK();
		UpdateVisibility();
	}
	public function OnRollOver(e:Event):void {
		var i:int= m_BtSelect.indexOf(e.currentTarget);
		if (i >= 0) {
			m_Text.SetText((m_BtSelect[i] as Button).name);
		}
	}
	public function OnRollOut(e:Event):void {
		UpdateVisibility();
	}
	public function OnBtA(e:Event):void {
		var i:int = 0;
		if (e.currentTarget == m_BtA) {
			m_State.AnswerQuestion(0);
		}
		if (e.currentTarget == m_BtB) {
			m_State.AnswerQuestion(1);
		}
		if (e.currentTarget == m_BtC) {
			m_State.AnswerQuestion(2);
		}
		if (e.currentTarget == m_BtD) {
			m_State.AnswerQuestion(3);
		}
		i= m_BtSelect.indexOf(e.currentTarget);
		if (i >= 0) {
			m_State.ToggleVisible(i);
		}
		UpdateVisibility();
	}
	private var m_BtOK:Button = null;
	private var m_BtA:Button = null;
	private var m_BtB:Button = null;
	private var m_BtC:Button = null;
	private var m_BtD:Button = null;
	private var m_BtRestart:Button = null;
	
	private var m_BtSelect:Array = null;	//the buttons where you can selet what to strip
	private var m_Body:Array = null;
	
	private var m_State:GameState = null;
	private var m_Text:TextWindow = null;
	
	}
}