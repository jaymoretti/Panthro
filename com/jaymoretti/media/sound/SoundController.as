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
package com.jaymoretti.media.sound
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	public class SoundController extends Sprite
	{
		public static var FOOTER_PRESS : int            = 0;
		public static var LOOPINTRO : int               = 1;
		public static var LOOP600 : int                 = 2;
		public static var LOOP750 : int                 = 3;
		private static var _soundArray : Array          = ["click.mp3", "intro.mp3", "600.mp3", "750.mp3"];
		private static var _soundObjects : Array        = [];

		private static var _soundChannel : SoundChannel = new SoundChannel ();
		private static var _currentSound : Sound;
		private static var _pausePoint : Number;
		private static var _loopSoundChannel : SoundChannel;
		private static var _loopPausePoint : Number;
		private static var _loopSound : Sound;
		private static var _loopPlaying : Boolean;
		private static var _mute : Boolean = false;
		
		public static function init () : void
		{
			for (var i : int = 0; i != _soundArray.length; i++)
			{
				var sound : Sound                           = new Sound ();
				var soundLoaderContext : SoundLoaderContext = new SoundLoaderContext ();
				soundLoaderContext.checkPolicyFile = true;

				sound.load (new URLRequest (_soundArray[i]), soundLoaderContext);
				_soundObjects.push (sound);
			}
		}

		public static function play (which : int, volume : Number = 1) : void
		{
			if(!mute)
			{
				_currentSound = _soundObjects[which];
				_soundChannel = _currentSound.play ();
				var mod : SoundTransform = new SoundTransform ();
				mod.volume = volume;
				_soundChannel.soundTransform = mod;
			}
		}

		public static function loop (which : int, volume : Number = 1) : void
		{
			
			if (_loopPlaying)
			{
				killLoop ();
			}
			if(!mute)
			{
				_loopSound = _soundObjects[which];
				_loopSoundChannel = _loopSound.play (0, 999999);
				var mod : SoundTransform = new SoundTransform ();
				mod.volume = volume;
				_loopSoundChannel.soundTransform = mod;
				_loopPlaying = true;
			}
		}

		public static function stopLoop () : void
		{
			_loopPlaying = false;
			_loopPausePoint = _loopSoundChannel.position;
			_loopSoundChannel.stop ();

		}
		public static function resumeLoop () : void
		{
			if(!mute)
			{
				_loopPlaying = true;
				_loopSoundChannel = _loopSound.play (_loopPausePoint, 999999);
			}
		}

		public static function pauseCurrentSound () : void
		{
			_pausePoint = _soundChannel.position;
			_soundChannel.stop ();
		}

		public static function resumeCurrentSound () : void
		{
			_soundChannel = _currentSound.play (_pausePoint);
		}

		public static function killCurrentSound () : void
		{
			_loopPlaying = false;
			var mod : SoundTransform = new SoundTransform ();
			mod.volume = 0;
			_soundChannel.stop ();
			_soundChannel.soundTransform = mod;
			_soundChannel = new SoundChannel ();
		}

		public static function killLoop () : void
		{
			var mod : SoundTransform = new SoundTransform ();
			mod.volume = 0;
			_loopSoundChannel.stop ();
			_loopSoundChannel.soundTransform = mod;
			_loopSoundChannel = new SoundChannel ();
		}

		public static function get loopPlaying () : Boolean
		{
			return _loopPlaying;
		}

		public static function get mute():Boolean
		{
			return _mute;
		}

		public static function set mute(value:Boolean):void
		{
			_mute = value;
		}

	}
}
