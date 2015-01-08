package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class mcEnemy extends MovieClip 
	{
		public var sDirection:String;
		private var nSpeed:Number;
		public function mcEnemy() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void 
		{
			var nEnemies:Number = 3;
			var nRandom:Number = randomNumber(1, nEnemies);
			this.gotoAndStop(nRandom);
			setupStartPosition();
		}
		
		private function setupStartPosition():void 
		{
			nSpeed = randomNumber(5, 10);
			var nLeftOrRight:Number = randomNumber(1, 2);
			if (nLeftOrRight == 1)
			{
				this.x = 0 - (this.width / 2); 
				sDirection = "R";
			} else
			{
				this.x = stage.stageWidth + (this.width / 2); 
				sDirection = "L";
			}
			var nMinAlt:Number = (stage.stageHeight / 2);
			var nMaxAlt:Number = (this.height / 2);
			this.y = randomNumber(nMaxAlt, nMinAlt);
			startMoving();
			
		}
		
		private function startMoving():void 
		{
			addEventListener(Event.ENTER_FRAME, enemyLoop)
		}
		
		private function enemyLoop(e:Event):void 
		{
			if (sDirection == "r")
			{
				this.x += nSpeed; 
			} else 
			{
				this.x -= nSpeed;
			}
		}
		public function destroyEnemy():void
		{
			parent.removeChild(this)
			removeEventListener(Event.ENTER_FRAME, enemyLoop);
		}
		function randomNumber(low:Number=0, high:Number=1):Number
		{
		  return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
	}

}