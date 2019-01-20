package gfw.sound 
{
	import flash.media.*;
	/**
	 * ...
	 * @author jk
	 */
	public class SoundManager 
	{
		protected static var instance:SoundManager = null;
		static public function get Instance():SoundManager
		{
			if ( instance == null )
			instance = new SoundManager();
			return instance;
		}
		public function SoundManager() 	{
			if ( instance != null )
				throw new Error( "Only one Singleton instance should be instantiated" ); 
				
			tempSoundTransform = new SoundTransform();
			muteSoundTransform = new SoundTransform();
		}
		public function AddSound(Name:String, MySound:Sound):void {
			m_Sounds[Name] = MySound;
		}
		public function PlaySound(Name:String, isSoundTrack:Boolean=false,loops:int=1,offset:Number=0,volume:Number=1.0):void {
			tempSoundTransform.volume = volume;
			tempSound = m_Sounds[Name];
			if (isSoundTrack) {
				if (m_SoundTrackChannel != null) {
					m_SoundTrackChannel.stop();
				}
				m_SoundTrackChannel = tempSound.play(offset, loops);
				m_SoundTrackChannel.soundTransform = tempSoundTransform;
			} else {
				m_SoundChannels[Name] = tempSound.play(offset, loops);
				m_SoundChannels[Name].soundTransform = tempSoundTransform;
			}
		}
		public function StopSound(Name:String):void {
			m_SoundChannels[Name].stop();
		}
		public function StopSoundTrack():void {
			m_SoundTrackChannel.stop();
		}
		/*public function SoundLoaded(Name:String):Boolean {
			var result:Boolean = false;
			result = m_Sounds[Name] != null;
			return result;
		}
		public function SoundTrackLoaded(Name:String):Boolean {
			var result:Boolean = false;
			result = m_SoundTrackChannel[Name] != null;
			return result;
		}*/
		private var m_Sounds:Array = new Array(0);
		private var m_SoundChannels:Array = new Array(0);
		private var m_SoundTrackChannel:SoundChannel=null;
		private var m_SoundMute:Boolean = false;
		private var tempSoundTransform:SoundTransform;
		private var muteSoundTransform:SoundTransform;
		private var tempSound:Sound;
		
	}

}