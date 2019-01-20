package RiddleStrip 
{
	import Anim1.Anim1Game;
	/**
	 * ...
	 * @author jk
	 */
	public class GameState 
	{
		public static const STATE_STARTING:int = 100;
		public static const STATE_GREETINGS:int = 110;
		public static const STATE_QUESTIONING:int = 120;	//select question
		public static const STATE_GUESSING:int = 130;		//wait fur user input
		public static const STATE_RIGHT:int = 140;			//tell user answer ok
		public static const STATE_WRONG:int = 150;			//tell user answer nok
		public static const STATE_STRIPSELECT:int = 160;	//wait for user selection
		public static const STATE_STRIPPING:int = 170;		//
		public static const STATE_UNSTRIPPING:int = 175;	//undo last strip
		public static const STATE_YOULOOSE:int = 180;		//no more questions left and not enough passed
		public static const STATE_YOUWIN:int = 190;			//no more questions left and enough ok
		public static const STATE_YOUWINSUPER:int = 200;			//no more questions left and all ok
		
		public static const LULEG:int = 1;
		public static const LARM:int = 2;
		public static const LARM2:int = 3;
		public static const LARMJACKET:int = 4;
		public static const NECK:int = 5;
		public static const TAIL:int = 6;
		public static const CHEST:int = 7;
		public static const SHEATH:int = 8;
		public static const SHEATH2:int = 9;
		public static const SHEATH3:int = 10;
		public static const RLLEG:int = 11;
		public static const RLLEGWRIST:int = 12;
		public static const SHOE:int = 13;
		public static const BOOT:int = 14;
		public static const TAIL2:int = 15;
		public static const COCK2:int = 16;
		public static const COLLAR1:int = 17;
		public static const COLLAR2:int = 18;
		public static const COCKGEAR1:int = 19;
		public static const NIPPLE1:int = 20;
		public static const NIPPLE2:int = 21;
		public static const CHESTBOND:int = 22;
		public static const RULEG:int = 23;
		public static const COCKGEAR3:int = 24;
		public static const RULEGWRIST:int =25
		public static const SPREADBAR:int =26
		public static const PANTYS:int = 27;
		public static const BELLY2:int = 28;
		public static const PANTS:int = 64;
		public static const SHIRT:int = 65;
		public static const CHESTJACKET:int = 66;
		public static const HEAD:int = 67;
		
		
		
		public static const BLIND:int = 68;
		public static const MUZZLE1:int = 69;
		public static const MUZZLE2:int = 70;
		public static const RARM:int = 71;
		public static const RARMJACKET:int = 72;
		public static const RARMWRIST2:int = 73;
		public static const RARMWRIST:int = 74;
		public static const PIERCING:int = 80;
		public static const SPOOGE:int = 81;
		
		private static const CountRiddlesForPass:int = 3;
		
		public function GameState() 
		{
			m_EnabledOption = new Array();
			m_Visible = new Array();
			Reset();
		}
		public function Reset():void {
			m_Riddles = new Riddles();
			m_UsedOption = new Array(0);
			m_State = STATE_GREETINGS;
			//reset selection and visibility
			for (var i:int = 0; i < 100; i++ ) {
				m_EnabledOption[i] = int(0);
				m_Visible[i] = false;
			}
			//define what should be initially visible
			m_Visible[CHEST] = true;
			m_Visible[CHESTJACKET] = true;
			m_Visible[HEAD] = true;
			m_Visible[TAIL] = true;
			m_Visible[PANTS] = true;
			m_Visible[PANTYS] = true;
			m_Visible[SHIRT] = true;
			m_Visible[RARM] = true;
			m_Visible[RARMJACKET] = true;
			m_Visible[LARMJACKET] = true;
			m_Visible[LARM] = true;
			m_Visible[SHOE] = true;
			m_Visible[LULEG] = true;
			m_Visible[RLLEG] = true;
			m_Visible[RULEG] = true;
			m_Visible[NECK] = true;
			m_Visible[SHEATH] = true;

		}
		public function GetUserMessage():String {
			var text:String = "";
			switch (m_State) {
				case STATE_GREETINGS:
					text= "Hi there. I was strooling around and thought you could need some tutoring for your exam." +
					"Lets see if you already know enough or if you should take a look at your books again." +
					"For every question you answer correctly, I will show you a liitle bit." +
					"For every wrong answer, I will show you a little less." +
					"Try to get at least "+CountRiddlesForPass.toString()+" correct answers."
					"There is only a limited number of question. So you should try to answer all of them correctly if you wanna see more." +
					"And...read carefully!"
					break;
				case STATE_QUESTIONING:
				case STATE_GUESSING:
					text = m_Riddles.GetRiddleText();
					break;
				case STATE_RIGHT:
					text = "Hey yeah, thats right. " + 
					"You solved "+m_Riddles.GetRiddlesSolved().toString()+" and have "+m_Riddles.GetRiddlesLeft().toString()+" to go.";
					break;
				case STATE_WRONG:
					text = "I'm sorry, but thats wrong";
					"You solved "+m_Riddles.GetRiddlesSolved().toString()+" and have "+m_Riddles.GetRiddlesLeft().toString()+" to go.";
					break;
				case STATE_YOUWIN:
					text = "Congratulations, you answered the minimum number of questions correctly.";
					break;
				case STATE_YOUWINSUPER:
					text = "Congratulations, you answered all questions correctly. Well, maybe I could give you a little bit of an extra tease.";
					break;
				case STATE_YOULOOSE:
					text = "Well I think we will stop here. You should really try learning a liitle bit more. You only got " + 
					m_Riddles.GetRiddlesSolved().toString() +  "right out of " +(m_Riddles.GetRiddlesSolved() + m_Riddles.GetRiddlesFailed()).toString();
					break;
				case STATE_UNSTRIPPING:
					text = "Just wait a second...";
					break;
				case STATE_STRIPSELECT:
					text = "So...what would you like me to do?";
					break;
				default:
					break;
			}
			return text;
		}
		public function GetChoices():int {
			switch (m_State) {
				case STATE_QUESTIONING:
				case STATE_GUESSING:
					return m_Riddles.GetPossibleChoices();
					break;
				default: 
					return 0;
					break;
			}
		}
		public function OnOK():void {
			switch (m_State) {
				case STATE_STARTING:
					m_State = STATE_GREETINGS;
					break;
				case STATE_GREETINGS:
					m_State = STATE_QUESTIONING;
					break;
				//STATE_GUESSING leads to RIGHT or WRONG
				case STATE_RIGHT:
					//unlock
					if(m_Riddles.GetRiddlesLeft()>0) {
						m_State = STATE_STRIPSELECT;
					} else {
						if (m_Progress >= CountRiddlesForPass) m_State = STATE_YOUWIN;
						else m_State = STATE_YOULOOSE;
						if (m_Progress>=(m_Riddles.GetRiddlesSolved()+m_Riddles.GetRiddlesFailed())) m_State = STATE_YOUWINSUPER;	//??
					}
					break;
				case STATE_WRONG:
					//undo unlock
					m_State = STATE_UNSTRIPPING;
					if (m_UsedOption.length > 0) {
						ToggleVisible(m_UsedOption.pop());
					}
					break;
				case STATE_STRIPSELECT:
					m_State = STATE_STRIPPING;
					break;
				//STATE_STRIPSELECT leads to STRIPPING
				case STATE_STRIPPING:
					m_State = STATE_QUESTIONING;
					break;
				case STATE_UNSTRIPPING:
					if(m_Riddles.GetRiddlesLeft()>0) {
						m_State = STATE_QUESTIONING;
					} else {
						if (m_Progress >= CountRiddlesForPass) m_State = STATE_YOUWIN;
						else m_State = STATE_YOULOOSE;
						if (m_Progress>=(m_Riddles.GetRiddlesSolved()+m_Riddles.GetRiddlesFailed())) m_State = STATE_YOUWINSUPER;	//??
					}
					break;
				case STATE_YOULOOSE:
					m_State = STATE_YOULOOSE;
					break;
				default:
					break;
			}
			if (m_State == STATE_QUESTIONING) {
				m_Riddles.GetNextRiddle();
				m_State = STATE_GUESSING;
			}
		}
		public function AnswerQuestion(flag:int):void {
			if (m_Riddles.GuessAnswer(flag)) {
				m_State = STATE_RIGHT;
				m_Progress++;
			} else {
				m_State = STATE_WRONG;
				m_Progress = Math.max(m_Progress-1, 0);
				return;
			}
			UpdateEnabledOptions();
		}
		public function UpdateEnabledOptions():void {
			//disable/enable Options
			var enable:Boolean = false;
			for (var i:int = 0; i < m_EnabledOption.length; i++ ) {
				m_Progress = 200;//??
				switch (i) {
					case CHESTJACKET:
						enable = m_Progress >= 1;
						break;
					case SHOE:
						enable = m_Progress >= 1;
						break;
					case SHIRT:
						enable = m_Progress >= 2;
						break;
					case PANTS:
						enable = m_Progress >= 2;
						break;
					case PANTYS:
						enable = m_Progress >= 3;
						break;
					case TAIL2:
						enable = m_Progress >= 4;
						break;
					case COLLAR1:
						enable = m_Progress >= 4;
						break;
					case COLLAR2:
						enable = m_Progress >= 6;
						break;
					case RARMWRIST:
						enable = m_Progress >= 4;
						break;
					case RARMWRIST2:
						enable = m_Progress >= 4;
						break;
					case COCK2:
						enable = (m_Progress >= 5) && !m_Visible[TAIL2] && !m_Visible[PANTS] && !m_Visible[PANTYS];
						break;
					default:
						enable = false;
						break;
				}
				m_EnabledOption[i] = 1;// enable ? 1 : 0;
			}
		}
		public function ToggleVisible(index:int):void {
			var value:Boolean = !(m_Visible[index] as Boolean);
			m_Visible[index] = value;
			switch (index) {
				case LARMJACKET:
				case RARMJACKET:
				case CHESTJACKET:
					m_Visible[LARMJACKET] = value;
					m_Visible[RARMJACKET] = value;
					break;
				case COLLAR1:
					m_Visible[COLLAR2] = false;
					break;
				case COLLAR2:
					m_Visible[COLLAR1] = false;
					break;
				case COCK2:
					m_Visible[SHEATH] = !value;
					m_Visible[SHEATH2] = value;
					m_Visible[COCKGEAR1] = value && m_Visible[COCKGEAR1];
					m_Visible[COCKGEAR3] = value && m_Visible[COCKGEAR3];
					break;
				case COCKGEAR1:
					m_Visible[COCKGEAR3] = value && m_Visible[COCKGEAR3];
					break;
				case COCKGEAR3:
					break;
				case PANTYS:
				case PANTS:
					m_Visible[COCKGEAR1] = value && m_Visible[COCKGEAR1];
					m_Visible[COCKGEAR3] = value && m_Visible[COCKGEAR3];
					m_Visible[COCK2] = value && m_Visible[COCK2];
					m_Visible[TAIL2] = (!m_Visible[PANTYS] || m_Visible[TAIL2]) && !m_Visible[PANTS];
					m_Visible[TAIL] = !m_Visible[TAIL2];
					break;
				case TAIL2:
					m_Visible[TAIL2] = value;
					m_Visible[TAIL] = !m_Visible[TAIL2];
					break;
				case RARMWRIST2:
					m_Visible[LARM] = !value && m_Visible[LARM];
					m_Visible[LARM2]= !value && m_Visible[LARM2];
					break;
				default:
					break;
			}
			
			if (m_State == STATE_STRIPSELECT) {
				m_UsedOption.push(index);
				for (var i:int = 0; i < m_EnabledOption.length; i++ ) {
					m_EnabledOption[i] = 0;	//user should not be able to select more than one item after one answer
				}
				m_State = STATE_QUESTIONING;
				OnOK();
			}
			UpdateEnabledOptions();
		}
		public function get State():int {
			return m_State;
		}
		public function get EnabledOption():Array {
			var value:Array = new Array(m_EnabledOption.length);
			for (var i:int = value.length - 1; i >= 0  ; i-- ) {
				value[i] = (m_State == STATE_STRIPSELECT ||	m_State == STATE_YOUWIN ||	m_State == STATE_YOUWINSUPER) ? m_EnabledOption[i]:0;
			}
			return value;
		}
		private var m_EnabledOption:Array = new Array();
		private var m_UsedOption:Array = null;
		public var m_Visible:Array = new Array();
		private var m_State:int = 0;
		private var m_Riddles:Riddles = null;
		private var m_Progress:int = 0;
	}

}