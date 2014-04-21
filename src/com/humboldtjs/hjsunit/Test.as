package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;
	
	public class Test extends TestBase
	{
		protected var _testMethods:Vector.<TestMethod> = new Vector.<TestMethod>();
		
		public function Test()
		{
			super();
		}
		
		protected function addTestMethod(aTestMethod:TestMethod):void
		{
			_testMethods.push(aTestMethod);
		}
		
		protected function addAsyncTestMethod(aName:String, aMethod:Function):void
		{
			_testMethods.push(new TestMethod(aName, aMethod, true));
		}
		
		public function run(assert:Assert = null):void
		{
			setAssert(assert);
			
			_assert.title();
			
			_queueIndex = 0;
			_queueCount = _testMethods.length;
			
			doQueue();
		}
		
		protected function doQueue():void
		{
			_testMethods[_queueIndex].addEventListener(HJSEvent.COMPLETE, onQueueItemComplete);
			_testMethods[_queueIndex].run(_assert);
		}
		
		protected function onQueueItemComplete(aEvent:HJSEvent):void
		{
			_testMethods[_queueIndex].removeEventListener(HJSEvent.COMPLETE, onQueueItemComplete);

			_queueIndex++;
			
			if (_queueIndex < _queueCount) {
				doQueue();
			} else {
				dispatchEvent(new HJSEvent(HJSEvent.COMPLETE));
			}
		}
	}
}