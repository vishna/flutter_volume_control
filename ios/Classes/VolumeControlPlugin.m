#import "VolumeControlPlugin.h"
#import "MediaPlayer/MPVolumeView.h"
//AVFoundation.AVFAudio.AVAudioSession
#import <AVFoundation/AVFoundation.h>

@implementation VolumeControlPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"volume_control"
            binaryMessenger:[registrar messenger]];
  VolumeControlPlugin* instance = [[VolumeControlPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSLog(@"method call");

  if ([@"dispose" isEqualToString:call.method]) {
      NSLog(@"VolumeControlPlugin dispose");

  }else if ([@"setVolume" isEqualToString:call.method]) {

      @autoreleasepool {
          @try {
              NSNumber *vol = call.arguments[@"vol"];
              float _vol = vol.floatValue;
              if (_vol>1)_vol=1;
              if (_vol<0)_vol=0;

              MPVolumeView *volumeView = [[MPVolumeView alloc] init];
              UISlider *volumeViewSlider = nil;
              
              for (UIView *view in volumeView.subviews) {
                  if ([view isKindOfClass:[UISlider class]]) {
                      volumeViewSlider = (UISlider *)view;
                      break;
                  }
              }
              
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  volumeViewSlider.value = _vol;
                  //NSLog(@"setting finished!");
              });

          } @catch (NSException *exception) {
              NSLog(@"%@", exception);
          }
          
      }

      
  }else if ([@"getVolume" isEqualToString:call.method]) {

     @autoreleasepool {
         @try {
             MPVolumeView *volumeView = [[MPVolumeView alloc] init];
             UISlider *volumeViewSlider = nil;
             
             for (UIView *view in volumeView.subviews) {
                 if ([view isKindOfClass:[UISlider class]]) {
                     volumeViewSlider = (UISlider *)view;
                     break;
                 }
             }
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 //NSLog(@"get val:%f",volumeViewSlider.value);
                 result([NSNumber numberWithFloat:volumeViewSlider.value]);
                 
             });

         } @catch (NSException *exception) {
             NSLog(@"%@", exception);
         }
         
     }

  } else {
    result(FlutterMethodNotImplemented);
  }
}


@end
