package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;

	public class Test extends EventDispatcher implements ITestRunnable
	{
		protected var _name:String;
		protected var _method:Function;
		protected var _async:Boolean;
		
		protected var _assert:Assert;
		
		public function getName():String			{ return _name; }
		
		public function Test(aName:String, aMethod:Function, aAsync:Boolean = false)
		{
			super();
			
			_name = aName;
			_method = aMethod;
			_async = aAsync
		}
		
		public function run(assert:Assert):void
		{
			_assert = assert;
			
			if (_assert == null)
				_assert = new Assert();
			
			_assert.setName(getName());
			_assert.addEventListener(HJSEvent.COMPLETE, onTestComplete);
			
			_method();

			if (!_async)
				_assert.done();
		}
		
		protected function onTestComplete(aEvent:HJSEvent):void
		{
			_assert.removeEventListener(HJSEvent.COMPLETE, onTestComplete);
			dispatchEvent(new HJSEvent(HJSEvent.COMPLETE));
		}
	}
}