package  gfw.core
{
	import mx.collections.*;
	import mx.core.*;
	/**
	 * ...
	 * @author jk
	 */
	public class GameObjectManager 
	{
		protected static var instance:GameObjectManager = null;
		static public function get Instance():GameObjectManager
		{
			if ( instance == null )
			instance = new GameObjectManager();
			return instance;
		}
		public function GameObjectManager() 	{
			if ( instance != null )
				throw new Error( "Only one Singleton instance should be instantiated" ); 
		}
		public function startup():void		{		
		}
		
		public function shutdown():void		{
			shutdownAll();
		}
		public function enterFrame():void	{
	    	removeDeletedBaseObjects();
	    	insertNewBaseObjects();
		}
		public function addBaseObject(baseObject:GameObject):void
		{
			newGObjects.addItem(baseObject);				
		}
		
		public function removeBaseObject(baseObject:GameObject):void
		{
			removedGObjects.addItem(baseObject);
		}
		
		protected function shutdownAll():void
		{
			// don't dispose objects twice
			for each (var baseObject:GameObject in GObjects)
			{
				var found:Boolean = false;
				for each (var removedObject:GameObject in removedGObjects)
				{
					if (removedObject == baseObject)
					{
						found = true;
						break;
					}
				}
				
				if (!found)
					baseObject.Shutdown();
			}
		}
		
		protected function insertNewBaseObjects():void
		{
			for each (var baseObject:GameObject in newGObjects)
			{
				for (var i:int = 0; i < GObjects.length; ++i)
				{
					var otherBaseObject:GameObject = GObjects.getItemAt(i) as GameObject;
					
					if (otherBaseObject.zOrder > baseObject.zOrder ||
						otherBaseObject.zOrder == -1)
						break;
				}

				GObjects.addItemAt(baseObject, i);
			}
			
			newGObjects.removeAll();
		}
		
		protected function removeDeletedBaseObjects():void
		{
			// insert the object acording to it's z position
			for each (var removedObject:GameObject in removedGObjects)
			{
				var i:int = 0;
				for (i = 0; i < GObjects.length; ++i)
				{
					if (GObjects.getItemAt(i) == removedObject)
					{
						GObjects.removeItemAt(i);
						break;
					}
				}
				
			}
			
			removedGObjects.removeAll();
		}
		public function CreateCursor():IViewCursor {
			return GObjects.createCursor();
		}
		protected var GObjects:ArrayCollection = new ArrayCollection();
		// a collection where new BaseObjects are placed, to avoid adding items 
		// to baseObjects while in the baseObjects collection while it is in a loop
		protected var newGObjects:ArrayCollection = new ArrayCollection();
		// a collection where removed BaseObjects are placed, to avoid removing items 
		// to baseObjects while in the baseObjects collection while it is in a loop
		protected var removedGObjects:ArrayCollection = new ArrayCollection();
	}

}