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
package com.jaymoretti.utils.text.TextField
{
	import flash.text.TextFieldType;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TextFieldFactory
	{
		public static function createTextField(text : String, size : Number, color : uint, x : Number, y : Number, fontName : String = "Tahoma", antiAliasType : String = AntiAliasType.NORMAL, maxWidth : Number = 0, maxHeight : Number = 0, editable : Boolean = false, bold : Boolean = false) : TextField
		{
			return createTF(false, text, size, color, x, y, fontName, antiAliasType, maxWidth, maxHeight, editable);
		}

		public static function createHTMLTextField(text : String, size : Number, color : uint, x : Number, y : Number, fontName : String = "Tahoma", antiAliasType : String = AntiAliasType.NORMAL, maxWidth : Number = 0, maxHeight : Number = 0, editable : Boolean = false, bold : Boolean = false) : TextField
		{
			return createTF(true, text, size, color, x, y, fontName, antiAliasType, maxWidth, maxHeight, editable);
		}

		private static function createTF(html : Boolean, text : String, size : Number, color : uint, x : Number, y : Number, fontName : String = "Tahoma", antiAliasType : String = AntiAliasType.NORMAL, maxWidth : Number = 0, maxHeight : Number = 0, editable : Boolean = false, bold : Boolean = false) : TextField
		{
			var _textFormater : TextFormat = new TextFormat;
			_textFormater = new TextFormat();
			_textFormater.font = fontName;
			_textFormater.size = size;
			if (bold)
			{
				_textFormater.bold = true;
			}
			_textFormater.color = color;

			var tf : TextField = new TextField();
			tf.defaultTextFormat = _textFormater;
			if (editable == true)
			{
				tf.type = TextFieldType.INPUT;
			}
			else
			{
				tf.autoSize = TextFieldAutoSize.LEFT;
			}
			tf.multiline = true;
			tf.embedFonts = true;
			tf.antiAliasType = antiAliasType;

			if (antiAliasType == AntiAliasType.ADVANCED)
			{
				tf.sharpness = 0;
			}
			if (maxWidth != 0)
			{
				tf.wordWrap = true;
				tf.width = maxWidth;
			}
			if (maxHeight != 0)
			{
				tf.wordWrap = true;
				tf.height = maxHeight;
			}
			if (html = true)
				tf.htmlText = text;
			else
				tf.text = text;

			tf.x = x;
			tf.y = y;
			tf.selectable = false;

			return tf;
		}
	}
}