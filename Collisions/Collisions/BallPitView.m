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

    NSInteger sideCount = 7;
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
//    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square, self.smallSquare, self.mediumSquare]];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:self.subviews];

//    __block NSInteger count = 0;
//    __weak BallPitView *weakSelf = self;
//    NSInteger numberOfSquares = 200;
//    NSMutableArray *arrayOfSquares = [[NSMutableArray alloc] initWithCapacity:numberOfSquares];
//    NSMutableArray *arrayOfSmallSquares = [[NSMutableArray alloc] initWithCapacity:numberOfSquares];
//    self.gravity.action = ^{
//        if (count % 1 == 0) {
//            UIView *newSquare = [[UIView alloc] initWithFrame:weakSelf.square.bounds];
//            newSquare.center = weakSelf.square.center;
//            newSquare.transform = weakSelf.square.transform;
//            newSquare.backgroundColor = [UIColor clearColor];
//            newSquare.layer.borderColor = [[UIColor redColor] CGColor];
//            newSquare.layer.borderWidth = 0.5;
//            [weakSelf addSubview:newSquare];
//            [arrayOfSquares addObject:newSquare];
//
//            newSquare = [[UIView alloc] initWithFrame:weakSelf.smallSquare.bounds];
//            newSquare.center = weakSelf.smallSquare.center;
//            newSquare.transform = weakSelf.smallSquare.transform;
//            newSquare.backgroundColor = [UIColor clearColor];
//            newSquare.layer.borderColor = [[UIColor blueColor] CGColor];
//            newSquare.layer.borderWidth = 0.5;
//            [weakSelf addSubview:newSquare];
//            [arrayOfSmallSquares addObject:newSquare];
//            
//            if (arrayOfSquares.count > numberOfSquares - 1) {
//                UIView *square = arrayOfSquares[0];
//                [square removeFromSuperview];
//                [arrayOfSquares removeObjectAtIndex:0];
//            }
//            
//            if (arrayOfSmallSquares.count > numberOfSquares - 1) {
//                UIView *square = arrayOfSmallSquares[0];
//                [square removeFromSuperview];
//                [arrayOfSmallSquares removeObjectAtIndex:0];
//            }
//
//        }
//        
//        ++count;
//    };

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
