/*
 * Pulled from Tracey profiler PR
 * @see https://github.com/HaxeFoundation/haxe/pull/11772
 */

package cpp.vm.tracy;

#if (!HXCPP_TRACY)
#error "This class cannot be used without -D HXCPP_TRACY"
#end
enum abstract PlotFormatType(cpp.UInt8) from cpp.UInt8 to cpp.UInt8
{
  var Number = 0;
  var Memory = 1;
  var Percentage = 2;
}

@:include('hx/TelemetryTracy.h')
extern class Native_TracyProfiler
{
  /**
    Mark a frame. Call this at the end of each frame loop.
  **/
  @:native('::__hxcpp_tracy_framemark')
  public static function frameMark():Void;

  /**
    Mark a named frame. Allows creating multiple frame sets for different timing categories.
    Each unique name creates a separate frame set in the Tracy timeline.
  **/
  @:native('::__hxcpp_tracy_framemark_named')
  public static function frameMarkNamed(_name:String):Void;

  /**
    Mark the start of a discontinuous frame. Use for periodic work with gaps.
    Must be paired with frameMarkEnd() using the same name.
  **/
  @:native('::__hxcpp_tracy_framemark_start')
  public static function frameMarkStart(_name:String):Void;

  /**
    Mark the end of a discontinuous frame. Use for periodic work with gaps.
    Must be paired with frameMarkStart() using the same name.
  **/
  @:native('::__hxcpp_tracy_framemark_end')
  public static function frameMarkEnd(_name:String):Void;

  /**
    Print a message into Tracy's log.
  **/
  @:native('::__hxcpp_tracy_message')
  public static function message(_msg:String, ?_color:Int = 0x000000):Void;

  /**
    Tracy can collect additional information about the profiled application,
    which will be available in the trace description.
    This can include data such as the source repository revision,
    the application’s environment (dev/prod), etc.
  **/
  @:native('::__hxcpp_tracy_message_app_info')
  public static function messageAppInfo(_info:String):Void;

  /**
    Plot a named value to tracy. This will generate a graph in the profiler for you.
  **/
  @:native('::__hxcpp_tracy_plot')
  public static function plot(_name:String, _val:cpp.Float32):Void;

  /**
    Configure how values are plotted and displayed.
  **/
  @:native('::__hxcpp_tracy_plot_config')
  public static function plotConfig(_name:String, _format:PlotFormatType, ?_step:Bool = false, ?_fill:Bool = false, ?_color:Int = 0x000000):Void;

  /**
    Set a name for the current thread this function is called in. Supply an optional groupHint so threads become grouped in Tracy's UI.
  **/
  @:native('::__hxcpp_tracy_set_thread_name_and_group')
  public static function setThreadName(_name:String, ?_groupHint:Int = 1):Void;

  /**
    Create a custom named scoped zone in your code.
  **/
  @:native('HXCPP_TRACY_ZONE')
  public static function zoneScoped(_name:String):Void;

  /**
    Create a custom named scoped zone with extra text in your code.
  **/
  @:native('HXCPP_TRACY_ZONE_TEXT')
  public static function zoneScopedText(_name:String, _text:String):Void;

  /**
    Enable or disable the zones created automatically for Haxe function calls on the calling thread.
    Manual zones are unaffected. Returns the previous setting so it can be restored.
  **/
  @:native('::__hxcpp_tracy_set_function_zones')
  public static function setFunctionZones(_enabled:Bool):Bool;

  /**
    Get the current automatic function zone depth on the calling thread.
  **/
  @:native('::__hxcpp_tracy_get_zone_count')
  public static function getZoneCount():Int;

  /**
    Whether a Tracy profiler is currently connected.
  **/
  @:native('::__hxcpp_tracy_is_connected')
  public static function isConnected():Bool;

  /**
    Set the text of the current zone on the calling thread.
  **/
  @:native('::__hxcpp_tracy_zone_text')
  public static function zoneText(_text:String):Void;

  /**
    Set the name of the current zone on the calling thread.
  **/
  @:native('::__hxcpp_tracy_zone_name')
  public static function zoneName(_name:String):Void;

  /**
    Set the color of the current zone on the calling thread.
  **/
  @:native('::__hxcpp_tracy_zone_color')
  public static function zoneColor(_color:Int):Void;

  /**
    Attach a numeric value to the current zone on the calling thread.
  **/
  @:native('::__hxcpp_tracy_zone_value')
  public static function zoneValue(_value:cpp.Int64):Void;
}

#if (scriptable || cppia)
class Cppia_TracyProfiler
{
  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.frameMark)
  public static function frameMark() Native_TracyProfiler.frameMark();

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.frameMarkNamed)
  public static function frameMarkNamed(_name:String) Native_TracyProfiler.frameMarkNamed(_name);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.frameMarkStart)
  public static function frameMarkStart(_name:String) Native_TracyProfiler.frameMarkStart(_name);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.frameMarkEnd)
  public static function frameMarkEnd(_name:String) Native_TracyProfiler.frameMarkEnd(_name);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.message)
  public static function message(_msg:String, ?_color:Int = 0x000000) Native_TracyProfiler.message(_msg, _color);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.messageAppInfo)
  public static function messageAppInfo(_info:String) Native_TracyProfiler.messageAppInfo(_info);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.plot)
  public static function plot(_name:String, _val:Float) Native_TracyProfiler.plot(_name, _val);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.plotConfig)
  public static function plotConfig(_name:String, _format:PlotFormatType, ?_step:Bool = false, ?_fill:Bool = false,
      ?_color:Int = 0x000000) Native_TracyProfiler.plotConfig(_name, _format, _step, _fill, _color);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.setThreadName)
  public static function setThreadName(_name:String, ?_groupHint:Int = 1) Native_TracyProfiler.setThreadName(_name, _groupHint);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.zoneScoped)
  public static function zoneScoped(_name:String) Native_TracyProfiler.zoneScoped(_name);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.zoneScopedText)
  public static function zoneScopedText(_name:String, _text:String) Native_TracyProfiler.zoneScopedText(_name, _text);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.setFunctionZones)
  public static function setFunctionZones(_enabled:Bool):Bool return Native_TracyProfiler.setFunctionZones(_enabled);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.getZoneCount)
  public static function getZoneCount():Int return Native_TracyProfiler.getZoneCount();

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.isConnected)
  public static function isConnected():Bool return Native_TracyProfiler.isConnected();

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.zoneText)
  public static function zoneText(_text:String) Native_TracyProfiler.zoneText(_text);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.zoneName)
  public static function zoneName(_name:String) Native_TracyProfiler.zoneName(_name);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.zoneColor)
  public static function zoneColor(_color:Int) Native_TracyProfiler.zoneColor(_color);

  @:inheritDoc(cpp.vm.tracy.Native_TracyProfiler.zoneValue)
  public static function zoneValue(_value:cpp.Int64) Native_TracyProfiler.zoneValue(_value);
}

typedef TracyProfiler = Cppia_TracyProfiler;
#else
typedef TracyProfiler = Native_TracyProfiler;
#end