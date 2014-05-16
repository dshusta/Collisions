//
//  BallPitView.m
//  Collisions
//
//  Created by pivotal on 5/14/14.
//  Copyright (c) 2014 Shusta. All rights reserved.
//

#import "BallPitView.h"
#import <QuartzCore/QuartzCore.h>
#import "GravityLayer.h"

@interface BallPitView ()<GravityLayerDelegate>
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UICollisionBehavior *collisions;
@property (nonatomic, strong) UIView *square;
@property (nonatomic, strong) UIView *smallSquare;
@property (nonatomic, strong) UIView *mediumSquare;
@property (nonatomic, strong) UIView *boundary;
@property (nonatomic, readwrite) CGPoint gravityPoint;
@end

@implementation BallPitView

@dynamic gravityPoint;

+ (Class)layerClass {
    return [GravityLayer class];
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];

    NSInteger sideCount = 4;
    NSInteger size = 20;
    NSInteger count = 0;
    NSInteger inset = 100;
    for (NSInteger i = inset; i < inset + sideCount * size; i += size) {
        for (NSInteger j = inset; j < inset + sideCount * size; j += size) {
            UIView *particle = [[UIView alloc] initWithFrame:(CGRect){.origin.x = j, .origin.y = i, .size.height = size, .size.width = size}];
            particle.backgroundColor = count % 2 ? [UIColor blackColor] : [UIColor darkGrayColor];
            ++count;
            [self addSubview:particle];
        }
    }

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    self.collisions = [[UICollisionBehavior alloc] initWithItems:self.subviews];
    self.collisions.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collisions];
    
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.subviews];
    elasticityBehavior.elasticity = 0.7f;
    [self.animator addBehavior:elasticityBehavior];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)startGravity {
    self.gravity = [[UIGravityBehavior alloc] initWithItems:self.subviews];

    NSNumber *minValue = @-5.0;
    NSNumber *maxValue = @5.0;
    
    UIInterpolatingMotionEffect *xMotion = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"gravityDirection.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xMotion.minimumRelativeValue = minValue;
    xMotion.maximumRelativeValue = maxValue;
    
    UIInterpolatingMotionEffect *yMotion = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"gravityDirection.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yMotion.minimumRelativeValue = minValue;
    yMotion.maximumRelativeValue = maxValue;

    UIMotionEffectGroup *motionGroup = [[UIMotionEffectGroup alloc] init];
    motionGroup.motionEffects = @[xMotion, yMotion];
    [self addMotionEffect:motionGroup];
    
    [(GravityLayer *)self.layer setGravityFeedbackDelegate:self];
    [self.animator addBehavior:self.gravity];
}

#pragma mark - <GravityLayerDelegate>

- (void)didUpdateGravityDirection:(CGPoint)gravityDirection {
    CGVector vector = {
        .dx = gravityDirection.x,
        .dy = gravityDirection.y
    };
    
    self.gravity.gravityDirection = vector;
}

@end
