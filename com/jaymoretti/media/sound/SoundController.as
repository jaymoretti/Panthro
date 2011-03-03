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
	import com.jaymoretti.core.config.Config;

	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	public class SoundController extends Sprite
	{
		public static const BUTTON_OVER : int = 0;
		public static const BUTTON_CLICK : int = 1;
		public static const INTRO_SOUND : int = 2;
		private static var _soundArray : Array = Config.SOUND_LIST;
		private static var _soundObjects : Array = [];
		private static var _soundChannel : SoundChannel = new SoundChannel();
		private static var _currentSound : Sound;
		private static var _pausePoint : Number;

		public static function init() : void
		{
			for (var i : int = 0; i != _soundArray.length; i++)
			{
				var sound : Sound = new Sound();
				var soundLoaderContext : SoundLoaderContext = new SoundLoaderContext();

				soundLoaderContext.checkPolicyFile = true;

				sound.load(new URLRequest("sounds/" + _soundArray[i]), soundLoaderContext);
				_soundObjects.push(sound);
			}
		}

		public static function play(which : int, volume : Number = 1) : void
		{
			_currentSound = _soundObjects[which];
			_soundChannel = _currentSound.play();
			var mod : SoundTransform = new SoundTransform();
			mod.volume = volume;
			_soundChannel.soundTransform = mod;
		}

		public static function pauseCurrentSound() : void
		{
			_pausePoint = _soundChannel.position;
			_soundChannel.stop();
		}

		public static function resumeCurrentSound() : void
		{
			_soundChannel = _currentSound.play(_pausePoint);
		}

		public static function killCurrentSound() : void
		{
			var mod : SoundTransform = new SoundTransform();
			mod.volume = 0;
			_soundChannel.stop();
			_soundChannel.soundTransform = mod;
			_soundChannel = new SoundChannel();
		}
	}
}
