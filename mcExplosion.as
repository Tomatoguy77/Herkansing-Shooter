package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class mcExplosion extends MovieClip 
	{
		
		public function mcExplosion() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void 
		{
			addEventListener(Event.ENTER_FRAME, explosionLoop);
		}
		
		private function explosionLoop(e:Event):void 
		{
			if (this.currentFrame == this.totalFrames)
			{
				parent.removeChild(this)
				removeEventListener(Event.ADDED_TO_STAGE, explosionLoop)
			}
			
		}
		
		
	}

}