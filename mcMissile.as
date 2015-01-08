package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class mcMissile extends Sprite 
	{
		
		public function mcMissile() 
		{
			//setup eventlistener to see if missile is added to the stag.
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void 
		{
			addEventListener(Event.ENTER_FRAME, missileLoop)
		}
		
		private function missileLoop(e:Event):void 
		{
			
			this.y -= 10;
		}
		public function destroyMissiles():void
		{
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, missileLoop);
		}
	}	

}