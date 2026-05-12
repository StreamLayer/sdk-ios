#import <TargetConditionals.h>
#if TARGET_OS_WATCH || TARGET_OS_IOS
#warning "StreamLayerTVOS does not support the watchOS or iOS platform"
#endif
