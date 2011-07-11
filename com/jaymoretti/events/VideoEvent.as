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
package com.jaymoretti.core.events
{
	import flash.events.Event;

	public class VideoEvent extends Event
	{
		public static const LOAD_ERROR:String = "VideoLoadError";
		public static const LOAD_COMPLETE:String = "VideoReady";
		public static const VIDEO_PLAYING:String = "VideoPlaying";
		public static const VIDEO_PAUSED:String = "VideoPaused";
		public static const VIDEO_STOPPED:String = "VideoStopped";
		public static const VIDEO_REWIND:String = "VideoRewind";
		public static const VIDEO_SEEK : String = "VideoSeek";
		
		public function VideoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new VideoEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("VideoEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}