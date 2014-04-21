package com.humboldtjs.hjsunit
{
	import com.humboldtjs.display.DisplayObject;
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;
	import com.humboldtjs.system.Logger;
	
	import dom.window;
	
	public class UITestRunner extends TestRunnerBase
	{
		protected var _ui:DisplayObject;
		protected var _html:String;
		
		public function getUI():DisplayObject			{ return _ui; }
		
		public function UITestRunner()
		{
			super();

			_ui = new DisplayObject();
		}
		
		override protected function clear():void
		{
			_html = "";
			updateHtml();
		}
		
		protected function updateHtml():void
		{
			_ui.getHtmlElement().innerHTML = _html;
		}

		override protected function passed(aName:String, aDetail:String):void
		{
			_html += "<div style=\"color:green\">Passed - " + aName + " - " + aDetail + "</div>";
			updateHtml();
		}
		
		override protected function failed(aName:String, aDetail:String):void
		{
			_html += "<div style=\"color:red\">Failed - " + aName + " - " + aDetail + "</div>";
			updateHtml();
		}
		
		override protected function suiteTitle(aName:String):void
		{
			_html += "<h1>Running test-suite: " + aName + "</h1>";
			updateHtml();
		}
		
		override protected function testTitle(aName:String):void
		{
			_html += "<h2>Running test: " + aName + "</h2>";
			updateHtml();
		}
		
		override protected function suiteComplete():void
		{
			_html += "<div><br/><b><i>Suite Passed: " + _testsPassed + " Failed: " + _testsFailed + " Total: " + _testsCount + "</i></b></div>";
			updateHtml();
		}
		
		override protected function testComplete():void
		{
			_html += "<div><br/><i>Test Passed: " + _testsPassed + " Failed: " + _testsFailed + " Total: " + _testsCount + "</i></div>";
			updateHtml();
		}
	}
}