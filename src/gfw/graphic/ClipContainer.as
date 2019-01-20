package gfw.graphic 
{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.MovieClip
	/**
	 * ...
	 * @author jk
	 */
	//only works for kpg,gif,png ?
	public class ClipContainer 
	{
		

  private var m_loader:Loader    = new Loader();
  public  var m_clip  :MovieClip = null;
  
  public var m_loading_count:int = 1;
  
  public function ClipContainer(asset:Class) 
  {
    m_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, done);
    m_loader.loadBytes(new asset);
    
  }
  
  private function done(e:Event):void
  {
    m_clip = MovieClip(m_loader.content);
    m_loading_count--;
  }
}

}