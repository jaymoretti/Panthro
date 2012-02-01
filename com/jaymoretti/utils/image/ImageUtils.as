/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Feb 16, 2011 - Jay Moretti <jrmoretti@gmail.com>
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
 
 /*****************
  * 
  *  @author Makc http://makc3d.wordpress.com/
  */
 
package com.jaymoretti.utils.image
{

	import flash.geom.Point;
	import flash.utils.Endian;
	import flash.utils.IDataInput;

	public class ImageUtils {
		/**
		 * Returns dimensions of image in data, or null if data is of unknown format.
		 */
		public static function GetImageDimensions (data:IDataInput):Point {
			data.endian = Endian.BIG_ENDIAN;
			var byte:uint = data.readUnsignedByte ();
			switch (byte) {
				case 0x47: return GetGIFDimensions (data);
				case 0x89: return GetPNGDimensions (data);
				case 0xFF: return GetJPGDimensions (data);
			}
			return null;
		}

		/**
		 * @author makc
		 */
		private static function GetGIFDimensions (data:IDataInput):Point {
			const SIGNATURE_BYTES:Array = [0x47, 0x49, 0x46, 0x38];
			if (data.bytesAvailable < SIGNATURE_BYTES.length -1 +6) return null;
			// read signature
			for (var i:uint = +1; i < SIGNATURE_BYTES.length; i++) {
				if (data.readUnsignedByte() != SIGNATURE_BYTES [i]) {
					// not a GIF file
					return null;
				}
			}
			// skip version word ("7a" or "9a")
			data.readShort ();
			// read width and height, but GIFs are in little-endian order
			return new Point (
				data.readUnsignedByte () + 256 * data.readUnsignedByte (), // width
				data.readUnsignedByte () + 256 * data.readUnsignedByte ()  // height
			);
		}

		/**
		 * @author Christophe Herreman
		 * @see http://www.herrodius.com/blog/265
		 */
		private static function GetPNGDimensions (data:IDataInput):Point {
			const SIGNATURE_BYTES:Array = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
			const CHUNK_TYPE_SIZE:uint = 4;
			if (data.bytesAvailable < SIGNATURE_BYTES.length -1 +4 +CHUNK_TYPE_SIZE +8) return null;
			// read signature
			for (var i:uint = +1; i < SIGNATURE_BYTES.length; i++) {
				if (data.readUnsignedByte() != SIGNATURE_BYTES [i]) {
					// not a PNG file
					return null;
				}
			}
			// read header
			
			return new Point (
				data.readUnsignedInt (), // width
				data.readUnsignedInt ()  // height
			);
		}

		/**
		 * @author Geoffrey McRae
		 * @see http://www.anttikupila.com/flash/getting-jpg-dimensions-with-as3-without-loading-the-entire-file/
		 */
		private static function GetJPGDimensions (data:IDataInput):Point {
			if (data.bytesAvailable < 3) return null;
			var marker:uint, length:uint;
			if (data.readUnsignedByte () != 0xD8) {
				// JPEG should start from 0xFFD8
				return null;
			}
			// this simply finds 1st SOF0 marker
			// (will fail if JPG has thumbnails)
			marker = data.readUnsignedShort ();
			while (data.bytesAvailable > 10) { // SOF0 has at least 11 bytes
				length = data.readUnsignedShort () - 2;

				if (marker == 0xFFC0) {
					// SOF0 found, skip precision byte
					data.readUnsignedByte ();
					// height comes 1st, then width
					var height:uint = data.readUnsignedShort ();
					return new Point (data.readUnsignedShort (), height);
				}

				while (length-- > 0) data.readByte ();
				marker = data.readUnsignedShort ();
			}

			return null;
		}
	}
}