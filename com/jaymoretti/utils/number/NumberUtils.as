package com.jaymoretti.utils.number
{
	/**
	 * @author jmoretti
	 */
	public class NumberUtils
	{
		public static function zeroPad (number : int, width : int) : String
		{
			var ret : String = "" + number;
			while ( ret.length < width )
				ret = "0" + ret;
			return ret;
		}
	}
}
