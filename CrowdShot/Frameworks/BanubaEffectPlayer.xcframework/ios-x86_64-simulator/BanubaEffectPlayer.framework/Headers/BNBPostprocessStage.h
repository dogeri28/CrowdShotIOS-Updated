// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from postprocess.djinni

#import <Foundation/Foundation.h>
@class BNBPostprocessStage;


/**
 * Can be used to add additional effects.
 *
 * After applying the changes the next states:
 *   - active texture,
 *   - binding texture,
 *   - depth test,
 *   - culling face,
 *   - blend mode.
 */
@interface BNBPostprocessStage : NSObject

/**
 * Create a postprocess stage by name. 
 * @param name name of postprocess stage you want to create.
 */
+ (nullable BNBPostprocessStage *)create:(nonnull NSString *)name;

@end
