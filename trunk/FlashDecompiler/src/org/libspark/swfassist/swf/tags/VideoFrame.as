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

package org.libspark.swfassist.swf.tags
{
	import flash.utils.ByteArray;
	
	public class VideoFrame extends AbstractTag
	{
		public function VideoFrame(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_VIDEO_FRAME);
		}
		
		private var _streamId:uint = 0;
		private var _frameNumber:uint = 0;
		private var _videoData:ByteArray = new ByteArray();
		
		public function get streamId():uint
		{
			return _streamId;
		}
		
		public function set streamId(value:uint):void
		{
			_streamId = value;
		}
		
		public function get frameNumber():uint
		{
			return _frameNumber;
		}
		
		public function set frameNumber(value:uint):void
		{
			_frameNumber = value;
		}
		
		public function get videoData():ByteArray
		{
			return _videoData;
		}
		
		public function set videoData(value:ByteArray):void
		{
			_videoData = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitVideoFrame(this);
		}
	}
}