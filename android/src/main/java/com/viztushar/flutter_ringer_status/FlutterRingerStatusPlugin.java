package com.viztushar.flutter_ringer_status;

import android.annotation.TargetApi;
import android.content.Context;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.os.Build;
import android.os.Vibrator;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static android.content.Context.VIBRATOR_SERVICE;

/** FlutterRingerStatusPlugin */
public class FlutterRingerStatusPlugin implements MethodCallHandler {
  /** Plugin registration. */

  private static Ringtone ringtone;
  AudioManager manager;
  Vibrator myVib;

  private  FlutterRingerStatusPlugin(Registrar registrar){
    ringtone = RingtoneManager.getRingtone(registrar.context().getApplicationContext(), RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE));
    ringtone.setStreamType(AudioManager.STREAM_ALARM);
    this.manager = (AudioManager)registrar.context().getSystemService(Context.AUDIO_SERVICE);
    myVib = (Vibrator) registrar.context().getSystemService(VIBRATOR_SERVICE);

  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_ringer_status");
    channel.setMethodCallHandler(new FlutterRingerStatusPlugin(registrar));

  }

  @TargetApi(Build.VERSION_CODES.LOLLIPOP)
  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getRingerstatus")) {

      switch (manager.getRingerMode()){
        case AudioManager.RINGER_MODE_NORMAL:
          ringtone.setStreamType(AudioManager.RINGER_MODE_NORMAL);
          result.success("Normal");
          break;
        case AudioManager.RINGER_MODE_SILENT:
          ringtone.setStreamType(AudioManager.RINGER_MODE_SILENT);
          result.success("Silent");
          break;
        case AudioManager.RINGER_MODE_VIBRATE:
          ringtone.setStreamType(AudioManager.RINGER_MODE_VIBRATE);
          result.success("Vibrate");
          break;
      }
    } else if(call.method.equals("play")){
      switch (manager.getRingerMode()){
        case AudioManager.RINGER_MODE_NORMAL:
          AudioAttributes aa = new AudioAttributes.Builder()
                  .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                  .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                  .build();
          ringtone.setAudioAttributes(aa);
          ringtone.play();
          break;
        case AudioManager.RINGER_MODE_SILENT:
          break;
        case AudioManager.RINGER_MODE_VIBRATE:
          AudioAttributes aaa = new AudioAttributes.Builder()
                  .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                  .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                  .build();
          long[] vb = {500,250,250,500,250,250,500};
          myVib.vibrate(vb,1,aaa);
          break;
      }
      //manager.setStreamVolume(AudioManager.STREAM_RING,0,0);

    } else if(call.method.equals("stop")){
      myVib.cancel();
      ringtone.stop();
    }
    else {
      result.notImplemented();
    }
	result.success("done");
  }
}
