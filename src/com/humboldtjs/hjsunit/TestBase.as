package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;

	public class TestBase extends EventDispatcher implements ITestRunnable
	{
		protected var _name:String = "";
		protected var _assert:Assert;
		protected var _queueIndex:int;
		protected var _queueCount:int;
		
		protected var _setup:ITestRunnable;
		protected var _teardown:ITestRunnable;
		
		protected var _tests:Vector.<ITestRunnable> = new Vector.<ITestRunnable>();
		
		protected function getName():String					{ return _name; }
		protected function setName(aName:String):void		{ _name = aName; }
		
		protected function setSetupAsync(value:Boolean):void	{ _setup = new Test("Setup", setup, value); }
		protected function setTeardownAsync(value:Boolean):void	{ _teardown = new Test("Teardown", teardown, value); }
		
		public function TestBase()
		{
			super();
			
			setSetupAsync(false);
			setTeardownAsync(false);
		}
		
		protected function setup():void
		{
			//
		}
		
		protected function teardown():void
		{
			//
		}
		
		protected function setAssert(assert:Assert):void
		{
			_assert = assert;
			
			if (_assert == null)
				_assert = new Assert();
			
			_assert.setName(getName());
		}
		
		protected function prepareRun():void
		{
			//
		}
		
		public function run(assert:Assert):void
		{
			setAssert(assert);
			
			prepareRun();
			
			_queueIndex = -1;
			_queueCount = _tests.length;
			
			doQueue();
		}

		protected function doQueue():void
		{
			var theTest:ITestRunnable = _queueIndex == -1 ? _setup : (_queueIndex == _queueCount ? _teardown : _tests[_queueIndex]);
			
			theTest.addEventListener(HJSEvent.COMPLETE, onQueueItemComplete);
			theTest.run(_assert);
		}
		
		protected function onQueueItemComplete(aEvent:HJSEvent):void
		{
			aEvent.getCurrentTarget().removeEventListener(HJSEvent.COMPLETE, onQueueItemComplete);
			
			_queueIndex++;
			
			if (_queueIndex <= _queueCount) {
				doQueue();
			} else {
				dispatchEvent(new HJSEvent(HJSEvent.COMPLETE));
			}
		}
	}
}