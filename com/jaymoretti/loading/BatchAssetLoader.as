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
	import flash.utils.setTimeout;
	import com.jaymoretti.events.AssetLoadEvent;
	import com.jaymoretti.events.BatchAssetLoadEvent;
	import com.jaymoretti.utils.vector.VectorUtils;

	public class BatchAssetLoader
	{
		public static const SIMULTANEOUS_LOADERS : uint = 3;
		protected var _batchID : String;
		protected var _batchPos : uint = 0;
		protected var _completedCallback : Function;
		protected var _errorCallback : Function;
		protected var _startCallback : Function;
		protected var _progressCallback : Function;
		protected var _progress : Number;
		protected var _batch : Vector.<AssetLoaderItem>;
		protected var _currentlyLoading : Vector.<AssetLoaderItem>;
		private var _batchSize : Number = 0;
		private var _loadedBytes : Number = 0;
		private var _id : String;
		private var _completedParams : Array;

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
		public function add(params : Object) : void
		{
			if (!_batch)
			{
				_batch = new Vector.<AssetLoaderItem>();
			}

			var item : AssetLoaderItem = new AssetLoaderItem();

			item.params = params;
			item.start = itemStart;
			item.progress = itemProgress;
			item.complete = itemCompleted;
			item.error = itemError;
			item.isLoading = false;
			
			_batch.push(item);
		}

		/*******
		 * Remove item from the batch
		 * @param itemID String <br/>
		 *
		 * @example BatchAssetLoader.remove("image666");
		 * 		  
		 */
		public function remove(itemID : String) : void
		{
			// TODO: implement remove item;
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
		public function load(params : Object) : void
		{
			if (params)
			{
				if (params.id)
					_id = params.id;

				if (params.onStart)
					_startCallback = params.onStart;

				if (params.onProgress)
					_progressCallback = params.onProgress;

				if (params.onComplete)
					_completedCallback = params.onComplete;

				if (params.onCompleteParams)
					_completedParams = params.onCompleteParams;

				if (params.onError)
					_errorCallback = params.onError;
			}

			
			prioritySort();
			_currentlyLoading = new Vector.<AssetLoaderItem>();
			
			setTimeout(startBatch, 1000);	
		}

		private function startBatch() : void
		{
			for(var i:uint = 0;i!=BatchAssetLoader.SIMULTANEOUS_LOADERS;i++)
				loadNext();
		}

		private function getBatchSize() : Number
		{
			_batchSize = 0;
			for each (var item : AssetLoaderItem in _batch)
			{
				_batchSize += item.size;
			}
			
			return _batchSize;
		}

		private function loadNext() : void
		{
			
			if (_batchPos < _batch.length)
			{
				if (_currentlyLoading.length < BatchAssetLoader.SIMULTANEOUS_LOADERS)
				{
					var currentItem : AssetLoaderItem = _batch[_batchPos];
					if (!currentItem.isLoading)
					{
						_currentlyLoading.push(currentItem);
						AssetLoader.loadAsset({url:currentItem.url, type:currentItem.type, onStart:currentItem.start, onProgress:currentItem.progress, onComplete:currentItem.complete, onCompleteParams:currentItem.onCompleteParams, onError:currentItem.error}, currentItem.id);
						currentItem.isLoading = true;
						_batchPos++;
					}
				}
			}
		}

		/*******
		 * Kills this batch process
		 * 
		 */
		public function stopBatch() : void
		{
		}

		/*******
		 * Sort the batch by priority 
		 * 
		 */
		protected function prioritySort() : void
		{
			// TODO: implement priority sorting;
		}

		protected function itemStart(event : AssetLoadEvent) : void
		{
			var item : AssetLoaderItem = _batch[VectorUtils.getFirstIndexOf(event.id, "id", Vector.<*>(_batch))];
			if (item.onStart)
				item.onStart.call(event);
		}

		protected function itemError(event : AssetLoadEvent) : void
		{
			var item : AssetLoaderItem = _batch[VectorUtils.getFirstIndexOf(event.id, "id", Vector.<*>(_batch))];
			if (item.onError)
				item.onError.call(event);
		}

		protected function itemCompleted(event : AssetLoadEvent) : void
		{
			if (VectorUtils.searchVector(event.id, "id", Vector.<*>(_currentlyLoading)))
				_currentlyLoading = Vector.<AssetLoaderItem>(VectorUtils.removeFromVector(_currentlyLoading[VectorUtils.getFirstIndexOf(event.id, "id", Vector.<*>(_currentlyLoading))], Vector.<*>(_currentlyLoading)));


			
			var item : AssetLoaderItem = _batch[VectorUtils.getFirstIndexOf(event.id, "id", Vector.<*>(_batch))];
			item.content = event.content;
			
			if (item.onComplete)
				item.onComplete.call(event);

			if (_batchPos != _batch.length)
				loadNext();
			else
				batchCompleted();
		}

		protected function itemProgress(event : AssetLoadEvent) : void
		{
			var item : AssetLoaderItem = _batch[VectorUtils.getFirstIndexOf(event.id, "id", Vector.<*>(_batch))];
			item.loadProgress = event.percentage;
			item.loadedBytes = event.bytesLoaded;
			
			if (item.onProgress)
				item.onProgress.call(event);

			batchProgress();
		}

		protected function batchStart() : void
		{
			if (_batchPos > 0)
			{
				if (_startCallback != null)
				{
					var startCallback : Function = _startCallback;
					var startEvent : BatchAssetLoadEvent = new BatchAssetLoadEvent(BatchAssetLoadEvent.LOAD_START);
					startEvent.batchID = _id;
					startCallback(startEvent);
				}
			}
		}

		protected function batchCompleted() : void
		{
			var event : BatchAssetLoadEvent = new BatchAssetLoadEvent(BatchAssetLoadEvent.LOAD_COMPLETE);
			event.batchID = _id;
			event.content = _batch;

			if (_completedCallback!=null)
			{
				var completeCallback : Function = _completedCallback;
				if (_completedParams)
					completeCallback(event, _completedParams);
				else
					completeCallback(event);
			}
		}

		protected function batchErrors() : void
		{
			if (_errorCallback != null)
				_errorCallback.call();
		}

		protected function batchProgress() : void
		{
			_progress = 0;
			_loadedBytes = 0;
			for each (var item : AssetLoaderItem in _batch)
			{
				_loadedBytes += item.loadedBytes;
			}

			_progress = (_loadedBytes / getBatchSize())*100;

			if (_progressCallback != null)
			{
				var progressCallback : Function = _progressCallback;

				var progressEvent : BatchAssetLoadEvent = new BatchAssetLoadEvent(BatchAssetLoadEvent.LOAD_PROGRESS);
				progressEvent.batchID = _id;
				progressEvent.bytesLoaded = _loadedBytes;
				progressEvent.bytesTotal = _batchSize;
				progressEvent.percentage = _progress * 100;
				progressEvent.roundPercentage = Math.round(progressEvent.percentage);
				progressCallback(progressEvent);

				
			}
		}

		public function get progress() : Number
		{
			return _progress;
		}

		public function destroyBatch() : void
		{
			_batch = new Vector.<AssetLoaderItem>();
		}
	}
}