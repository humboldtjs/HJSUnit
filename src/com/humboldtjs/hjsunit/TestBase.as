package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;

	public class TestBase extends EventDispatcher
	{
		protected var _name:String = "";
		protected var _assert:Assert;
		protected var _queueIndex:int;
		protected var _queueCount:int;
		
		protected function getName():String					{ return _name; }
		protected function setName(aName:String):void		{ _name = aName; }
		
		public function TestBase()
		{
			super();
		}
		
		protected function setAssert(assert:Assert):void
		{
			_assert = assert;
			
			if (_assert == null)
				_assert = new Assert();
			
			_assert.setName(getName());
		}
	}
}