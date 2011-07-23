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
package com.jaymoretti.loading
{
	import com.jaymoretti.events.AssetLoadEvent;
	public class BatchAssetLoader
	{
		protected var _batchID:String;
		protected var _batch : Vector.<Object>;
		protected var _completedCallback : Function;
		protected var _errorCallback : Function;
		protected var _progress : Number;
		
		/*******
		 * Add an item for loading
		 * @param params An object containing the following properties.<br/>
		 * 		  Mandatory Parameters:<br/>
		 * 		  url String;<br/>
		 * 		  type String;<br/>
		 * 		  id String;
		 * 		  
		 * 		  Optional Parameters:<br/>
		 * 		  onStart Function;<br/>
		 * 		  onProgress Function;<br/>
		 * 		  onComplete Function;<br/>
		 * 		  onCompleteParams Array;<br/>
		 * 		  onError	 Function;<br/>
		 * 		  
		 * @example BatchAssetLoader.add({id: "image666", url:"http://www.jaymoretti.com/test.jpg", type:AssetTypes.IMAGE, onStart:onStartHandler, onProgress:onProgressHandler, onComplete:onCompleteHandler, onCompleteParams:[100, 100]});
		 * 		  
		 */
		 
 		public function add(params:Object) :void
 		{
 			if(!_batch)
 			{
 				_batch = new Vector.<Object>();
 			}
 			
 			var tempObject:Object;
 			
 			
 			
 		}
 		
 		/*******
		 * Remove item from the batch
		 * @param itemID String <br/>
		 *
		 * @example BatchAssetLoader.remove("image666");
		 * 		  
		 */
 		public function remove(itemID:String):void
 		{
 			
 		}
 		
 		/*******
		 * Starts the batch process
		 * @param params An object containing the following properties.<br/>
		 * 		  Optional Parameters:<br/>
		 * 		  id String;<br/>
		 * 		  onStart Function;<br/>
		 * 		  onProgress Function;<br/>
		 * 		  onComplete Function;<br/>
		 * 		  onCompleteParams Array;<br/>
		 * 		  onError	 Function;<br/>
		 * 		  
		 * @example BatchAssetLoader.load({id: "BatchProcess666", onStart:onStartHandler, onProgress:onProgressHandler, onComplete:onCompleteHandler, onCompleteParams:[true, 100, 2000,this.x], onError:onErrorHandler);
		 * 		  
		 */
		public function load(params:Object) : void
		{
			
		}
		
		/*******
		 * Kills this batch process
		 * 
		 */
		public function stopBatch():void
		{
					
		}
		
		/*******
		 * Sort the batch by priority 
		 * 
		 */
		protected function prioritySort():void
		{
			
		}
		
		
		protected function itemStart(event:AssetLoadEvent):void
		{
			
		}
		
		protected function itemError(event:AssetLoadEvent):void
		{
			
		}
		protected function itemCompleted(event:AssetLoadEvent):void
		{
			
		}
		
		protected function itemProgress(event:AssetLoadEvent):void
		{
			
		}
		
		protected function batchStart():void
		{
			
		}
		protected function batchCompleted():void
		{
			_completedCallback.call();
		}
		
		protected function batchErrors():void
		{
			_errorCallback.call();
		}
		
		protected function batchProgress():void
		{
			_progress = 0;
		}
		
		public function get progress():Number
		{
			return _progress;
		}
		
		public function destroyBatch():void
		{
			
		}
	}
}