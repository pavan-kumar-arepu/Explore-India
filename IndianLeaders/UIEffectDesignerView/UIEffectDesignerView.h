
// This is an ARC only Objective-C class, compatible with iOS5+ and OSX 10.7+

#import "QuartzCore/QuartzCore.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
@interface UIEffectDesignerView : UIView

#else

#import <AppKit/AppKit.h>
@interface UIEffectDesignerView : NSView
#endif

@property (strong, nonatomic) CAEmitterLayer* emitter;

-(instancetype)initWithFile:(NSString*)fileName;
+(instancetype)effectWithFile:(NSString*)fileName;

@end
