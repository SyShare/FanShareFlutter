package plugin;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import syshare.com.flutterapp.VideoPlayActivity;

/**
 * Author by Administrator , Date on 2018/12/18.
 * PS: Not easy to write code, please indicate.
 */
public class FlutterPluginAct implements MethodChannel.MethodCallHandler {


    public static final String CHANNEL = "com.syshare.act/plugin";
    static MethodChannel channel;

    private Activity activity;


    private FlutterPluginAct(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginAct instance = new FlutterPluginAct(registrar.activity());
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall call, final MethodChannel.Result result) {

        if (call.method.equals("actVideo")) {
            String videoUrl = call.argument(VideoPlayActivity.EXTRA_URL);
            String thump = call.argument(VideoPlayActivity.EXTRA_THUMB);
            VideoPlayActivity.open(activity, videoUrl,null,thump);
            result.success("success");
        } else {
            result.notImplemented();
        }
    }
}
