package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class firstGame extends MovieClip
	{
		public var mcPlayer:MovieClip;
		private var leftKeyIsDown:Boolean;
		private var rightKeyIsDown:Boolean;
		
		private var aMissileArray:Array;
		private var aEnemyarray:Array;
		
		public var scoreTxt:TextField;
		public var ammoTxt:TextField;
		
		private var nScore:Number;
		private var nAmmo:Number;
		private var nLifes:Number;
		public function firstGame() 
		{
			aMissileArray = new Array;
			aEnemyarray = new Array;
			nScore = 0;
			nAmmo = 20;
			
			updateScoreText();
//			updateAmmoText();
		//	trace("first game loaded");
		//setup listeners to listen for when a key is pressed, and released
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		//setup a loop eventlistener
		stage.addEventListener(Event.ENTER_FRAME, gameLoop)
		var tEnemyTimer:Timer = new Timer(1000)
		
		tEnemyTimer.addEventListener(TimerEvent.TIMER, addEnemy)
		tEnemyTimer.start();
		}
		
		private function updateScoreText():void
		{
			scoreTxt.text = "Score: " + nScore;
		}
		
		
		//private function updateAmmoText(); void
		//{
		//	ammoTxt.text = "Ammo: " + nAmmo;
	//	}
		
		
		private function addEnemy(e:TimerEvent):void 
		{
			var newEnemy:mcEnemy = new mcEnemy();
			
			stage.addChild(newEnemy);
			aEnemyarray.push(newEnemy);
			trace(aEnemyarray.length)
		}
		
		private function gameLoop(e:Event):void 
		{
			playerControl();
			clampPlayerToSTage();
			checkMissilesOffScreen();
			ckeckEnemiesOffScreen();
			checkMissilesHitEnemy();
			
		}
		
		private function checkMissilesHitEnemy():void 
		{
			for (var i:int = 0; i < aEnemyarray.length; i++)
			{
				var currentMissile:mcMissile = aMissileArray[i];
				for (var j:int = 0; j < aEnemyarray.length; j++)
				{
					var currentEnemy:mcEnemy = aEnemyarray[j];
					
					if (currentMissile.hitTestObject(currentEnemy))
					{
						var newExposion:mcExplosion = new mcExplosion()
						stage.addChild(newExposion)
						newExposion.x = currentEnemy.x;
						newExposion.y = currentEnemy.y;
						currentMissile.destroyMissiles()
						aMissileArray.splice(i, 1);
						currentEnemy.destroyEnemy()
						aEnemyarray.splice(j, 1);
						//add 1 to score
						nScore++;
						updateScoreText();
					}
				}
				
				
			}
		}
		
		private function ckeckEnemiesOffScreen():void 
		{
			for (var i:int = 0; i < aEnemyarray.length; i++)
			{
				var currentEnemmy:mcEnemy = aEnemyarray[i];
			
				if (currentEnemmy.sDirection == "L" && currentEnemmy.x < -(currentEnemmy.width / 2)); 
				{
					aEnemyarray.splice(i, 1);
					currentEnemmy.destroyEnemy();
				} 
				if (currentEnemmy.sDirection == "R" && currentEnemmy.x > (stage.stageWidth + currentEnemmy.width / 2))
				{
					aEnemyarray.splice(i, 1);
					currentEnemmy.destroyEnemy();
				}
				
			}
		}
		
		private function checkMissilesOffScreen():void 
		{
			for (var i:int = 0; i < aMissileArray.length; i++)
			{
				var currentMissile:mcMissile = aMissileArray[i];
				if (currentMissile.y < 0 )
				{
					aMissileArray.splice(i, 1);
					currentMissile.destroyMissiles();
				}
			}
		}
		
		private function clampPlayerToSTage():void 
		{
			//if our player is to the left of the stage 
			//setup layer left of the stage 
			if (mcPlayer.x < mcPlayer.width/2)
			{
			mcPlayer.x = mcPlayer.width/2;
			}
			//if player is left to the stage set our player to the right of the stage
			if (mcPlayer.x > stage.stageWidth - (mcPlayer.width / 2))
			{
				mcPlayer.x = stage.stageWidth - (mcPlayer.width / 2); 
			}
		}
		
		private function playerControl():void 
		{
			
			// if left key = down move player to the left
			if (leftKeyIsDown == true)
			{
				mcPlayer.x -= 5;
			}
			//if right key = down move player right
			if (rightKeyIsDown)
			{ 
				mcPlayer.x += 5;
			}
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			
			//trace(e.keyCode)
			//test if left key is released
			if (e.keyCode == 37)
			{
				//left key is released
				leftKeyIsDown = false;
			}
			//test if right key is released
			if (e.keyCode == 39)
			{
				// right key is released
				rightKeyIsDown = false;
			}
			if (e.keyCode == 32)
			{
				if(nAmmo > 0) {
				//	nAmmo--:
				//	updateScoreText();
				fireMissile();
				}
			}
		}
		
		private function fireMissile():void 
		{
			var newMissile:mcMissile = new mcMissile();
			stage.addChild(newMissile);
			newMissile.x = mcPlayer.x;
			newMissile.y = mcPlayer.y;
			aMissileArray.push(newMissile);
			trace(aMissileArray.length)
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			//trace(e.keyCode)
			//test if left key is pressed
			if (e.keyCode == 37)
			{
				//left key is pressed
				leftKeyIsDown = true;
			}
			//test if right key is pressed
			if (e.keyCode == 39)
			{
				// right key is pressed
				rightKeyIsDown = true;
			}
		}
	}

}