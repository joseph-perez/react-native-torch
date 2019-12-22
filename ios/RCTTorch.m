//
//  RCTTorch.m
//  Cubicphuse
//
//  Created by Ludo van den Boom on 06/04/2017.
//  Copyright © 2017 Cubicphuse. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "RCTTorch.h"

@implementation RCTTorch

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(switchState:(BOOL *)newState requestedBrightness:(nonnull NSNumber *)requestedBrightness)
{
    if ([AVCaptureDevice class]) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]){
            [device lockForConfiguration:nil];

            if (newState) {
                float brightnessLevel = AVCaptureMaxAvailableTorchLevel;
                
                if (requestedBrightness != nil) {
                    float requestedBrightnessLevel = [requestedBrightness floatValue];
                    
                    if (requestedBrightnessLevel > 0.0 && requestedBrightnessLevel < 1.0) {
                        brightnessLevel = requestedBrightnessLevel;
                    }
                }

                [device setTorchModeOnWithLevel:brightnessLevel error: nil];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
            }

            [device unlockForConfiguration];
        }
    }
}

@end
