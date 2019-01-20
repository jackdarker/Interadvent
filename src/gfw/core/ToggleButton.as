package gfw.core 
{
	/**
	 * ...
	 * @author jk
	 */
	public class ToggleButton  extends Button
	{
		
		public function ToggleButton()
		{
			super();
		}
		override public function set Value(flag:Boolean):void {
			m_Value = flag;
			if (m_Enabled) {
				m_CurrentFrame = m_Value ? 3 : 1;
			}
			Invalidate();
		}
	}

}