// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from renderer.djinni

#import "BNBFrameData.h"
#import <Foundation/Foundation.h>
@class BNBDebugRenderer;


/**
 * Renders debug views of all enabled features
 * Requires creation with active gl context for correct feature subrenderers' init
 */
@interface BNBDebugRenderer : NSObject

/** This method may return `null` when debug renderer is unavailable */
+ (nullable BNBDebugRenderer *)create;

/** this pixel density is relative to a real one! */
- (void)surfaceChanged:(int32_t)width
                height:(int32_t)height
         pixelDensityW:(float)pixelDensityW
         pixelDensityH:(float)pixelDensityH;

- (void)draw:(nullable BNBFrameData *)frameData;

@end
