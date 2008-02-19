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
	public class SetTabIndex extends AbstractTag
	{
		public function SetTabIndex(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_SET_TAB_INDEX);
		}
		
		private var _depth:uint = 0;
		private var _tabIndex:uint = 0;
		
		public function get depth():uint
		{
			return _depth;
		}
		
		public function set depth(value:uint):void
		{
			_depth = value;
		}
		
		public function get tabIndex():uint
		{
			return _tabIndex;
		}
		
		public function set tabIndex(value:uint):void
		{
			_tabIndex = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitSetTabIndex(this);
		}
	}
}