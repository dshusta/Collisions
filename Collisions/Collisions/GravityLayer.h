//
//  GravityLayer.h
//  Collisions
//
//  Created by pivotal on 5/15/14.
//  Copyright (c) 2014 Shusta. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@protocol GravityLayerDelegate;

@interface GravityLayer : CALayer

@property (nonatomic, assign) CGPoint gravityDirection;
@property (nonatomic, weak) id<GravityLayerDelegate> gravityFeedbackDelegate;

@end


@protocol GravityLayerDelegate <NSObject>
@optional
- (void)didUpdateGravityDirection:(CGPoint)gravityDirection;

@end