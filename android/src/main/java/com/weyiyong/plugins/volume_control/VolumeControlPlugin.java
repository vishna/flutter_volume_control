package com.weyiyong.plugins.volume_control;

import android.content.Context;
import android.media.AudioManager;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** VolumeControlPlugin */
public class VolumeControlPlugin implements FlutterPlugin, MethodCallHandler {
  AudioManager audioManager;
  static Context context;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "volume_control");
    context = flutterPluginBinding.getApplicationContext();
    channel.setMethodCallHandler(new VolumeControlPlugin());
  }

  public void init(){
    if (audioManager!=null)return;
    //System.out.println("init...:"+context);
    audioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);

  }
  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "volume_control");
    channel.setMethodCallHandler(new VolumeControlPlugin());
    context = registrar.context();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("dispose")) {
    }else if (call.method.equals("getVolume")) {
      init();
      if (audioManager==null){
        //System.out.println("audioManager is null");
        return;
      }

      int max = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
      int volume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
      result.success(((double)volume)/max);

    }else if (call.method.equals("setVolume")) {
      init();
      if (audioManager==null){
        //System.out.println("audioManager is null");
        return;
      }
      double vol = (double)((Map)call.arguments).get("vol");
      //System.out.println("setting:"+vol);

      int max = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
      //System.out.println("Volume max:"+max);

      audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, (int)(vol*max),0);
      int volume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
      //System.out.println("current vol:"+volume);

    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
