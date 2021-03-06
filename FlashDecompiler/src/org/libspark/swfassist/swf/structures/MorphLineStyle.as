/*
 * Copyright(c) 2007 the Spark project.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

package org.libspark.swfassist.swf.structures
{
	public class MorphLineStyle
	{
		private var _startWidth:uint = 0;
		private var _endWidth:uint = 0;
		private var _startColor:RGBA = new RGBA();
		private var _endColor:RGBA = new RGBA();
		
		public function get startWidth():uint
		{
			return _startWidth;
		}
		
		public function set startWidth(value:uint):void
		{
			_startWidth = value;
		}
		
		public function get endWidth():uint
		{
			return _endWidth;
		}
		
		public function set endWidth(value:uint):void
		{
			_endWidth = value;
		}
		
		public function get startColor():RGBA
		{
			return _startColor;
		}
		
		public function set startColor(value:RGBA):void
		{
			_startColor = value;
		}
		
		public function get endColor():RGBA
		{
			return _endColor;
		}
		
		public function set endColor(value:RGBA):void
		{
			_endColor = value;
		}
	}
}