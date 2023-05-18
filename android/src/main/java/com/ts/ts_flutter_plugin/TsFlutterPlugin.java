package com.ts.ts_flutter_plugin;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mdsoftware.trackingsystemsdk.Constants;
import com.mdsoftware.trackingsystemsdk.TSAnalyticsSDK;
import com.mdsoftware.trackingsystemsdk.TSConfOption;
import com.mdsoftware.trackingsystemsdk.TSUser;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class TsFlutterPlugin implements FlutterPlugin, MethodCallHandler {

    private String TAG = "TsFlutterPlugin";

    private Context context;

    private MethodChannel channel;

    private boolean init = false;

    private boolean debug = false;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ts_flutter_plugin");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "initSDK":
                Log.d(TAG, "初始化参数:" + call.arguments);
                initSDK(call.arguments, result);
                break;
            case "setUserInfo":
                Log.d(TAG, "用户属性:" + call.arguments);
                setUserInfo(call.arguments, result);
                break;
            case "event":
                Log.d(TAG, "打点参数:" + call.arguments);
                event(call.arguments, result);
                break;
            case "eventViewPage":
                Log.d(TAG, "页面属性:" + call.arguments);
                eventViewScreen(call.arguments, result);
                break;
            case "eventViewPageStop":
                Log.d(TAG, "页面停止");
                eventViewScreenStop(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * 初始化sdk
     */
    private void initSDK(Object object, MethodChannel.Result result) {
        try {
            JSONObject jsonObject = new JSONObject((String) object);
            String appKey = jsonObject.getString("appKey");
            debug = jsonObject.getBoolean("debug");
            String tsApp = jsonObject.getString("tsApp");
            String tsExt = jsonObject.getString("tsExt");
            String serverUrl = jsonObject.getString("serverUrl");
            boolean autoTrack = jsonObject.getBoolean("autoTrack");

            TSConfOption confOption = new TSConfOption(context, appKey, tsExt, tsApp, debug);
            confOption.setServerUrl(serverUrl);
            TSAnalyticsSDK.startWithConfigOptions(confOption);
            result.success(true);
            init = true;
        } catch (JSONException e) {
            e.printStackTrace();
            result.success(false);
        }
    }

    /**
     * 设置用户属性
     */
    void setUserInfo(Object object, MethodChannel.Result result) {
        try {
            JSONObject jsonObject = new JSONObject((String) object);
            String guid = jsonObject.getString("guid");
            String real_name = jsonObject.getString("real_name");
            String nick_name = jsonObject.getString("nick_name");
            String age = jsonObject.getString("age");
            String birthday = jsonObject.getString("birthday");
            String gender = jsonObject.getString("gender");
            String account = jsonObject.getString("account");
            String country = jsonObject.getString("country");
            String province = jsonObject.getString("province");
            String city = jsonObject.getString("city");
            TSUser user = new TSUser();
            user.setGuid(guid);
            user.setReal_name(real_name);
            user.setNick_name(nick_name);
            user.setAge(age);
            user.setBirthday(birthday);
            user.setGender(gender);
            user.setAccount(account);
            user.setCountry(country);
            user.setProvince(province);
            user.setCity(city);
            TSAnalyticsSDK.setUserInfo(user);
            result.success(true);
        } catch (JSONException e) {
            e.printStackTrace();
            result.success(false);
        }
    }

    /**
     * 打点
     */
    @SuppressWarnings("unchecked")
    void event(Object object, MethodChannel.Result result) {
        try {
            List<Object> list = (List<Object>) object;
            String eventName = (String) list.get(0);
            Map<String, Object> eventParam = (Map<String, Object>) list.get(1);

            try {
                JSONObject eventInfo = new JSONObject();
                eventInfo.put("eventName", eventName);
                eventInfo.put("eventParam", new JSONObject(eventParam));
                TSAnalyticsSDK.event(eventInfo);
            } catch (Exception e) {
                e.printStackTrace();
            }
            result.success(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.success(false);
        }
    }

    /**
     * 打开页面
     */
    void eventViewScreen(Object object, MethodChannel.Result result) {
        if (!init) {
            return;
        }
        try {
            JSONObject jsonObject = new JSONObject((String) object);
            String viewName = jsonObject.getString("viewName");
            String arguments = jsonObject.getString("arguments");

            Constants.PAGE_URL = arguments;
            Constants.PAGE_QUERY = arguments;
            Constants.SESSION_ID = UUID.randomUUID().toString();
            Constants.setCurrentPath(viewName);
            Constants.setPageTitle(viewName);
            Constants.START_SESSION_TIME = System.currentTimeMillis() + "";
            TSAnalyticsSDK.setPageView();
            TSConfOption option = TSAnalyticsSDK.sharedInstance().getOption();
            boolean enableSession = option.getEnableSession();
            if (enableSession) {
                TSAnalyticsSDK.setStartSession();
            }
            result.success(true);
        } catch (JSONException e) {
            e.printStackTrace();
            result.success(false);
        }
    }

    /**
     * 页面停止
     */
    void eventViewScreenStop(MethodChannel.Result result) {
        if (!init) {
            return;
        }
        Constants.END_SESSION_TIME = System.currentTimeMillis() + "";
        TSConfOption option = TSAnalyticsSDK.sharedInstance().getOption();
        boolean enableSession = option.getEnableSession();
        if (enableSession) {
            TSAnalyticsSDK.setEndSession();
        }
        Constants.setPageQuery("");
        Constants.setPrevSessionId(Constants.getSessionId());
        Constants.setPrevPath(Constants.getCurrentPath());
        result.success(true);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
