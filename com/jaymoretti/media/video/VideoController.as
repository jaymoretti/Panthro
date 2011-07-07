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
package com.jaymoretti.media.video
{
	import com.jaymoretti.core.debug.LogBook;
	import com.jaymoretti.core.events.VideoEvent;
	
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;


	public class VideoController extends Sprite
	{
		private var _autoPlay : Boolean;
		private var _client : Object;
		private var _connection : NetConnection;
		private var _duration : Number;
		private var _fileName : String;
		private var _stream : NetStream;
		private var _url : String;
		private var _video : Video;
		private var _videoStatus : String;
		private var _lastStatus : String = "";
		private var _soundMixer : SoundTransform;
		private var _dateTimeFormatter:DateTimeFormatter;

		/***************
		 *  Init Function
		 *  @param url video URL
		 *  @param fileName file name 
		 *  @param autoPlay 
		 */
		public function init(url : String, autoPlay : Boolean = true) : void
		{
			_autoPlay = autoPlay;
			
			_url = url;
			_dateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
			_connection = new NetConnection();
			_connection.client = this;
			_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_connection.connect(null);
		}

		private function connectStream() : void
		{
			_stream = new NetStream(_connection);
			_stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_stream.bufferTime = 5;
			_client = {};
			_stream.client = _client;
			_client.onMetaData = metaDataHandler;
			_video = new Video();
			_video.attachNetStream(_stream);
			
			_stream.bufferTime = .5;
			_stream.play(_url);
			_soundMixer = SoundMixer.soundTransform;

			_videoStatus = "playing";
			if (!_autoPlay)
				pauseVideo();

			addChild(_video);
		}

		/******
		 *  HANDLERS
		 */
		private function asyncErrorHandler(event : AsyncErrorEvent) : void
		{
			
			// ignore
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void
		{
			dispatchEvent(event);
		}

		/******
		 * on net status  
		 */
		private function netStatusHandler(event : NetStatusEvent) : void
		{
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Buffer.Full":
					if (_videoStatus == "playing")
					{
						dispatchEvent(new VideoEvent(VideoEvent.VIDEO_PLAYING));
					}
					break;
				case "NetStream.Buffer.Flush":
					break;
				case "NetStream.Buffer.Empty":
					if (_videoStatus == "playing")
					{
						if (_stream.time > _duration - 2)
						{
							dispatchEvent(new VideoEvent(VideoEvent.VIDEO_STOPPED));
							_videoStatus = "stopped";
						}
					}
					break;
				case "NetStream.Pause.Notify":
					break;
				case "NetStream.Unpause.Notify":
					break;
				case "NetStream.Play.Start":
					break;
				case "NetStream.Play.Stop":
					break;
				case "NetStream.Seek.Notify":
					break;
			}

			_lastStatus = event.info.code.toString();
		}

		private function metaDataHandler(object : Object) : void
		{
			_duration = object.duration;
			dispatchEvent(new VideoEvent(VideoEvent.LOAD_COMPLETE));
		}

		// Awful hack to fix Bandwidth Detetion.
		public function onBWDone() : void
		{
		}

		/*************
		 *  Video Control functions
		 */
		/***************
		 *  Change Video
		 *  @param url video URL
		 *  @param fileName file name 
		 *  @param autoPlay 
		 */
		public function changeVideo(url : String, fileName : String, autoPlay : Boolean = true) : void
		{
			destroy();
			_autoPlay = autoPlay;
			_fileName = fileName;
			_url = url;
			connectStream();
		}

		/**
		 * Seek To A position in the videio
		 * @param time - Desired time in seconds
		 */
		public function seekTo(time : Number) : void
		{
			_stream.pause();

			_stream.seek(time);

			if (_videoStatus == "playing")
				_stream.resume();
		}

		/**
		 * pause/resume
		 */
		public function pauseVideo() : void
		{
			_stream.pause();
			_videoStatus = "paused";
		}

		public function resumeVideo() : void
		{
			_stream.resume();
			_videoStatus = "playing";
		}

		/*********************
		 * SOUND CONTROLS
		 */
		/***********
		 *  Mute  
		 */
		public function mute() : void
		{
			volume = 0;
		}

		/***********
		 *  Unmute  
		 */
		public function unmute() : void
		{
			volume = 100;
		}

		/*********************
		 * Cleaning up the mess
		 */
		/**
		 * Destroys the current stream
		 */
		public function destroy() : void
		{
			_stream.close();
		}

		/****
		 * VIDEO PROPERTIES
		 */
		/****
		 * set height
		 */
		public function set videoHeight(h : Number) : void
		{
			_video.height = h;
		}

		/****
		 * set width
		 */
		public function set videoWidth(w : Number) : void
		{
			_video.width = w;
		}

		/****
		 * set volume
		 */
		public function set volume(vol : Number) : void
		{
			var transform : SoundTransform = new SoundTransform();
			transform.volume = vol / 100;

			if (_stream)
				_stream.soundTransform = transform;
		}

		/****
		 * get volume
		 */
		public function get volume() : Number
		{
			return _stream.soundTransform.volume;
		}

		/****
		 * get current playhead;
		 */
		public function get currentTime() : Number
		{
			if (_stream)
				return _stream.time;
			else
				return 0;
		}

		/****
		 * get current playhead in percents;
		 */
		public function get playPercentage() : Number
		{
			var percents : Number = Math.round((_stream.time / _duration) * 100);

			return percents;
		}

		/****
		 * get current load progress in percents;
		 */
		public function get progressPercentage() : Number
		{
			var percents : Number = Math.round((_stream.bytesLoaded / _stream.bytesTotal) * 100);

			return percents;
		}

		/****
		 * get video duration;
		 */
		public function get duration() : Number
		{
			return _duration;
		}
		/****
		 * get current formatted playhead time;
		 */
		public function get currentFormattedTime() : String
		{
			var ms:Number = Math.floor(_stream.time*1000);
			var minutes:Number = Math.floor((ms % (1000*60*60)) / (1000*60));
			var seconds:Number = Math.floor(((ms % (1000*60*60)) % (1000*60)) / 1000);
			var leadMin:String = "";
			var leadSec:String = "";
			
			if(minutes< 10)
				leadMin = "0";
			
			if(seconds< 10)
				leadSec = "0";
			
			return leadMin+minutes+":"+leadSec+seconds;
		}
		
		/****
		 * get current formatted playhead time;
		 */
		public function get currentFormattedTimeLeft() : String
		{
			var ms:Number = Math.floor((_duration - _stream.time)*1000);
			var minutes:Number = Math.floor((ms % (1000*60*60)) / (1000*60));
			var seconds:Number = Math.floor(((ms % (1000*60*60)) % (1000*60)) / 1000);
			var leadMin:String = "";
			var leadSec:String = "";
			
			if(minutes< 10)
				leadMin = "0";
			
			if(seconds< 10)
				leadSec = "0";
			
			return leadMin+minutes+":"+leadSec+seconds;
		}
	

		/****
		 * get video Status;
		 */
		public function get status() : String
		{
			return _videoStatus;
		}
	}
}