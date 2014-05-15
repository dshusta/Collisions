//
//  GravityLayer.m
//  Collisions
//
//  Created by pivotal on 5/15/14.
//  Copyright (c) 2014 Shusta. All rights reserved.
//

#import "GravityLayer.h"

@implementation GravityLayer
@dynamic gravityDirection;


- (id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"gravityDirection"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"gravityDirection"];
        animation.fromValue = [[self presentationLayer] valueForKey:@"gravityDirection"];
        animation.duration = 0.0;
        return animation;
    }
    
    return [super actionForKey:event];
}

- (id)initWithLayer:(GravityLayer *)layer {
    self = [super initWithLayer:layer];
    if (self
        && [layer isKindOfClass:[self class]]) {
        self.gravityDirection = layer.gravityDirection;
        self.gravityFeedbackDelegate = layer.gravityFeedbackDelegate;
    }
    
    return self;
}

+ (BOOL) needsDisplayForKey:(NSString *) key {
    if ([key isEqualToString:@"gravityDirection"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void)drawInContext:(CGContextRef)ctx {
    if ([self.gravityFeedbackDelegate respondsToSelector:@selector(didUpdateGravityDirection:)]) {
        [self.gravityFeedbackDelegate didUpdateGravityDirection:self.gravityDirection];
    }
    
    [super drawInContext:ctx];
}




@end
