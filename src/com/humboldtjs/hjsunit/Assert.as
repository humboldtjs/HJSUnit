package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;

	public class Assert extends EventDispatcher
	{
		protected var _name:String = "";
		
		public function getName():String				{ return _name; }
		public function setName(value:String):void		{ _name = value; }
		
		public function Assert()
		{
			super();
		}
		
		public function equals(aExpected:*, aActual:*):void
		{
			if (aExpected == aActual)
				success("expected:<"+aExpected+"> | was:<"+aActual+">");
			else
				failure("expected:<"+aExpected+"> | was:<"+aActual+">");
		}
		
		public function notEquals(aExpected:*, aActual:*):void
		{
			if (aExpected != aActual)
				success("expected:<"+aExpected+"> | was:<"+aActual+">");
			else
				failure("expected:<"+aExpected+"> | was:<"+aActual+">");
		}
		
		public function strictlyEquals(aExpected:*, aActual:*):void
		{
			if (aExpected === aActual)
				success("expected:<"+aExpected+"> | was:<"+aActual+">");
			else
				failure("expected:<"+aExpected+"> | was:<"+aActual+">");
		}
		
		public function strictlyNotEquals(aExpected:*, aActual:*):void
		{
			if (aExpected !== aActual)
				success("expected:<"+aExpected+"> | was:<"+aActual+">");
			else
				failure("expected:<"+aExpected+"> | was:<"+aActual+">");
		}
		
		public function isTrue(value:Boolean):void
		{
			if (value === true)
				success("expected:true | was:"+value);
			else
				failure("expected:true | was:"+value);
		}
		
		public function isFalse(value:Boolean):void
		{
			if (value === false)
				success("expected:true | was:"+value);
			else
				failure("expected:false | was:"+value);
		}
		
		public function isNull(value:*):void
		{
			if (value === null)
				success("expected:null but was:<"+value+">");
			else
				failure("expected:null but was:<"+value+">");
		}
		
		public function isNotNull(value:*):void
		{
			if (value === null)
				success("expected:null but was:<"+value+">");
			else
				failure("expected:!null but was:<"+value+">");
		}
		
		protected function success(aDetail:String):void
		{
			dispatchEvent(new TestMessageEvent(TestMessageEvent.TEST_PASSED, getName(), aDetail));
		}
		
		protected function failure(aDetail:String):void
		{
			dispatchEvent(new TestMessageEvent(TestMessageEvent.TEST_FAILED, getName(), aDetail));
		}
		
		public function title(aSuite:Boolean = false):void
		{
			dispatchEvent(new TestMessageEvent(aSuite ? TestMessageEvent.TEST_SUITE_TITLE : TestMessageEvent.TEST_TITLE, getName(), ""));
		}
		
		public function message(aMessage:String):void
		{
			dispatchEvent(new TestMessageEvent(TestMessageEvent.TEST_MESSAGE, getName(), aMessage));
		}
		
		public function done():void
		{
			dispatchEvent(new HJSEvent(HJSEvent.COMPLETE));
		}
	}
}