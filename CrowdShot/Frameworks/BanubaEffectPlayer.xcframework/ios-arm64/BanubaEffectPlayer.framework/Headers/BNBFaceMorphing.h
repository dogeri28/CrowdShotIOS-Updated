// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from scene.djinni

#import "BNBMorphingType.h"
#import <Foundation/Foundation.h>
@class BNBMesh;


@interface BNBFaceMorphing : NSObject

- (void)setMorphingType:(BNBMorphingType)type;

- (BNBMorphingType)getMorphingType;

- (void)setWarpMesh:(nullable BNBMesh *)mesh;

- (nullable BNBMesh *)getWarpMesh;

- (void)setFaceWeight:(float)value;

- (float)getFaceWeight;

- (void)setNoseWeight:(float)value;

- (float)getNoseWeight;

- (void)setEyesWeight:(float)value;

- (float)getEyesWeight;

@end
