/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Jan 26, 2011 - Jay Moretti <jrmoretti@gmail.com>
 * 
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 * 
 *			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 * 
 *  0. You just DO WHAT THE FUCK YOU WANT TO. 
 *******************************************************************************/
package com.jaymoretti.utils.stage
{
	import com.jaymoretti.core.events.StageEvent;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	
	public class StageUtil
	{
		
		private static var _stage:Stage;

		public static function init(stageObject:Stage):void
		{
			_stage = stageObject;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		/** 
		* Align Object to Stage  
		*  
		*  
		* 
		* @param target:Object; Object to be aligned
		* @param position:String; StageAlign constants or "CENTER";
		* @return void 
		*/  
		
		public static function alignObjectToStage(target:DisplayObject, position:String):void
		{			
			switch (position) {
				case "TOP_LEFT":
					move(target, 0, 0);		
					break;
				case "TOP":
					move(target, ((_stage.stageWidth/2) - (target.width/2)), 0);					
					break;  
				case "TOP_RIGHT":
					move(target, _stage.stageWidth - target.width, 0);
					break;
				case "LEFT":
					move(target, 0, (_stage.stageHeight/2) - (target.height/2));
					break;
				case "RIGHT":
					move(target, _stage.stageWidth - target.width, (_stage.stageHeight/2) - (target.height/2));
					break;
				case "BOTTOM_LEFT":
					move(target, 0, _stage.stageHeight - target.height);
					break;
				case "BOTTOM":
					move(target, ((_stage.stageWidth/2) - (target.width/2)), _stage.stageHeight - target.height);
					break;
				case "BOTTOM_RIGHT":
					move(target, _stage.stageWidth - target.width, _stage.stageHeight - target.height);
					break;
				case "CENTER":
					move(target, (_stage.stageWidth/2) - (target.width/2), (_stage.stageHeight/2) - (target.height/2));
					break;
				default:
					move(target, 0, 0);
					break;
			}
		}
		
		public static function fitObjectToStage(target:DisplayObject, mode:String):void
		{
			var ratio:Number;
			var originalHeight:Number = target.height;
			var originalWidth:Number = target.width;
			
			switch (mode) {
				case "FIT":
					target.width = _stage.stageWidth;
					ratio = (originalHeight * target.width) / originalWidth;
					target.height = ratio;
					break;
				case "STRETCH":
					target.width = _stage.stageWidth;
					target.height = _stage.stageHeight;					
					break;  
				case "FILL":
					target.height = _stage.stageHeight;
					ratio = (originalWidth * target.height) / originalHeight;
					target.width = ratio;
					break;
				case "TILE":
					if(getQualifiedClassName(Sprite(target).getChildAt(0)) != "br.jrmoretti.ui.media::VideoPlayer")
					{
						
						var temp:Sprite = new Sprite();	
						temp.graphics.beginBitmapFill(Bitmap(Sprite(target).getChildAt(0)).bitmapData, null, true, true);
						temp.graphics.drawRect(0, 0, _stage.stageWidth, _stage.stageHeight);
						temp.graphics.endFill();
						
						Sprite(target).graphics.clear();
						Sprite(target).addChild(temp);	
					}
					
					break;
				case "CENTER":
					break;
			}

		}
		
		public static function move(target:DisplayObject, x:Number, y:Number):void
		{
			target.x = x;
			target.y = y;
			//Tweener.addTween(target, {x: x, y:y, time: .5});
		}
		
		private static function resizeHandler(event:Event):void
		{
			_stage.dispatchEvent(new StageEvent(StageEvent.RESIZE));
		}
		
		public static function get stage():Stage
		{
			return _stage;
		}
	}
}