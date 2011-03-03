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
	
	public class SoundEvent extends Event
	{
		public static const LOAD_ERROR:String = "SoundLoadError";
		public static const LOAD_COMPLETE:String = "SoundLoadComplete";
		public static const SOUND_PLAYING:String = "SoundPlaying";
		public static const SOUND_PAUSED:String = "SoundPaused";
		public static const SOUND_STOPPED:String = "SoundStopped";
		public static const SOUND_REWIND:String = "SoundRewind";
		public static const SOUND_SEEK:String = "SoundSeek";
		
		public function SoundEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new SoundEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("SoundEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}