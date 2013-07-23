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
		
		/*******
		 * Creates a sinple textField.
		 * @param params An object containing the following properties.<br/>
		 * 		  Mandatory Parameters:<br/>
		 * 		  text String;<br/>
		 * 		  properties Object;<br/>
		 * 		  
		 * 		  Object Parameters:<br/>
		 * 		  size Number; 
		 * 		  color uint;
		 * 		  x Number; 
		 * 		  y Number; 
		 * 		  fontName String; 
		 * 		  antiAliasType String; 
		 * 		  maxWidth Number;
		 * 		  maxHeight Number; 
		 * 		  editable Boolean; 
		 * 		  bold Boolean;
		 *
		 * @example TextFieldFactory.createTextField("This is a Text", {size: 20, color: 0xbeda77, fontName: "Helvetica", editable:true, bold:true}); 
		 * 		  
		 */
		public static function createTextField(text : String, properties:Object) : TextField
		{
			return createTF(false, text, properties);
		}
		
 		/*******
		 * Creates a sinple textField.
		 * @param params An object containing the following properties.<br/>
		 * 		  Mandatory Parameter s:<br/>
		 * 		  text String;<br/>
		 * 		  properties Object;<br/>
		 * 		  
		 * 		  Object Parameters:<br/>
		 * 		  size Number; 
		 * 		  color uint;
		 * 		  x Number; 
		 * 		  y Number; 
		 * 		  fontName String; 
		 * 		  antiAliasType String; 
		 * 		  maxWidth Number;
		 * 		  maxHeight Number; 
		 * 		  editable Boolean; 
		 * 		  bold Boolean;
		 *
		 * @example TextFieldFactory.createHTMLTextField("This is an HTMLText", {size: 20, color: 0xbeda77, fontName: "Helvetica", editable:true, bold:true}); 
		 * 		  
		 */
		public static function createHTMLTextField(text : String, properties:Object) : TextField
		{
			return createTF(true, text, properties);
		}
 
		private static function createTF(html : Boolean, text : String, properties:Object) : TextField
		{
			var _textFormater : TextFormat = new TextFormat;
			_textFormater = new TextFormat();
			
			if(!properties.fontName)
				properties.fontName = "Tahoma";
				
			_textFormater.font = properties.fontName;
			
			if(!properties.fontSize)
				properties.fontSize= 12;
				
			_textFormater.size = properties.fontSize;
			
			
			if (properties.bold)
			{
				_textFormater.bold = true;
			}
			
			if(!properties.color)
				properties.color = 0x666;
			
			_textFormater.color = properties.color;
 
			var tf : TextField = new TextField();
			tf.defaultTextFormat = _textFormater;
			
			if (properties.editable)
			{
				tf.type = TextFieldType.INPUT;
			}
		
			tf.multiline = true;
			tf.embedFonts = true;
			
			if(!properties.antiAliasType)
				properties.antiAliasType = AntiAliasType.ADVANCED;
				
			tf.antiAliasType = properties.antiAliasType;
 

			if (properties.antiAliasType == AntiAliasType.ADVANCED)
			{
				tf.sharpness = 0;
			}
			
			if ( properties.lineHeight )
				_textFormater.leading = properties.lineHeight;
				
			tf.width = 100;
			tf.height = 100;
			
			if(!properties.maxWidth)
				properties.maxWidth = 0;
			
			if (properties.maxWidth != 0)
			{
				tf.wordWrap = true;
				tf.width = properties.maxWidth;
			}
			
			if(!properties.maxHeight)
				properties.maxHeight = 0;
			
			if (properties.maxHeight != 0)
			{
				tf.wordWrap = true;
				tf.height = properties.maxHeight;
			}
			
			if (html = true)
				tf.htmlText = text;
			else
				tf.text = text;
 
 			if(!properties.x)
 				properties.x = 0;
 				
 			if(!properties.y)
 				properties.y = 0;
 
			tf.x = properties.x;
			tf.y = properties.y;
			
			tf.autoSize = TextFieldAutoSize.LEFT;
			
			tf.selectable = false;
 
			return tf;
		}
	}
}