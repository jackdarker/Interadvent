package gfw.graphic 
{
	import flash.net.*;
	import flash.events.*;
	import flash.media.Video;
	import flash.utils.ByteArray;
	import gfw.Interface.IByteArrayAssetProvider;
	/**
	 * ...
	 * @author jk
	 */
	public class NetStreamLoader 
	{
		
		private var m_FLVAsset:IByteArrayAssetProvider;
		public function NetStreamLoader(FLVAsset:IByteArrayAssetProvider) 
		{
			m_FLVAsset = FLVAsset;
			
		}
		public function connect() {
			var nc:NetConnection = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS , onConnect);
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR , trace);
			nc.connect(null);
		}
		public var video:Video = new Video(640, 480);

	public function onMetaData(info:Object):void {
		video.width=info.width;
		video.height = info.height;
		ns.appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN)
		ns.appendBytes(m_FLVAsset.GetNextAsset());
	};
	public function onCuePoint(item:Object):void {
    trace("cuePoint");
    traceObject(item);
}
	var ns:NetStream;
	private function onConnect(e:NetStatusEvent):void {
		trace(e.info.code);
		switch (e.info.code) { 
			case 'NetConnection.Connect.Success':
			trace(e.target as NetConnection);
			ns = new NetStream(e.target as NetConnection);
			ns.addEventListener(NetStatusEvent.NET_STATUS, onConnect);
			ns.client = this;
			video.attachNetStream(ns);
			ns.play(null);
			ns.appendBytes(m_FLVAsset.GetNextAsset());
			break;
		case 'NetStream.Buffer.Empty':
			//ns.appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN)
			//ns.appendBytes(m_FLVAsset.GetNextAsset());
			
			break;
		default:
			break;
			
		}

	}
	function traceObject(obj:Object, indent:uint = 0):void 
{ 
    var indentString:String = ""; 
    var i:uint; 
    var prop:String; 
    var val:*; 
    for (i = 0; i < indent; i++) 
    { 
        indentString += "\t"; 
    } 
    for (prop in obj) 
    { 
        val = obj[prop]; 
        if (typeof(val) == "object") 
        { 
            trace(indentString + " " + prop + ": [Object]"); 
            traceObject(val, indent + 1); 
        } 
        else 
        { 
            trace(indentString + " " + prop + ": " + val); 
        } 
    } 
}
	}
}