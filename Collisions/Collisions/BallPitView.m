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

    self.square = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 80, .origin.y = 80, .size.width = 100, .size.height = 100}];
    self.square.backgroundColor = [UIColor lightGrayColor];
    self.square.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self addSubview:self.square];
    
    self.smallSquare = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 20, .origin.y = 390, .size.width = 20, .size.height = 20 }];
    self.smallSquare.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.smallSquare];
    
    self.mediumSquare = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 290, .origin.y = 200, .size.width = 30, .size.height = 30 }];
    self.mediumSquare.backgroundColor = [UIColor blackColor];
    [self addSubview:self.mediumSquare];

    self.boundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 110, .origin.y = 230, .size.width = 11, .size.height = 20}];
    self.boundary.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.boundary];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];

    UIView *otherBoundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 160, .origin.y = 470, .size.width = 20, .size.height = 20}];
    otherBoundary.backgroundColor = [UIColor greenColor];
    [self addSubview:otherBoundary];

    UIView *anotherBoundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 50, .origin.y = 400, .size.width = 5, .size.height = 50}];
    anotherBoundary.backgroundColor = [UIColor magentaColor];
    [self addSubview:anotherBoundary];

    UIView *yetAnotherBoundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 270, .origin.y = 370, .size.width = 5, .size.height = 50}];
    yetAnotherBoundary.backgroundColor = [UIColor purpleColor];
    [self addSubview:yetAnotherBoundary];
    
    UIView *moreBoundaries = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 200, .origin.y = 40, .size.width = 15, .size.height = 15}];
    moreBoundaries.backgroundColor = [UIColor redColor];
    [self addSubview:moreBoundaries];
    
    UIView *largeBoundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 100, .origin.y = 300, .size.width = 150, .size.height = 100}];
    largeBoundary.backgroundColor = [UIColor blueColor];
    [self addSubview:largeBoundary];

    self.collisions = [[UICollisionBehavior alloc] initWithItems:@[self.square, self.smallSquare, self.mediumSquare,
                                                                   self.boundary, otherBoundary, anotherBoundary, yetAnotherBoundary, moreBoundaries, largeBoundary]];
    self.collisions.translatesReferenceBoundsIntoBoundary = YES;
//
//    [self.collisions addBoundaryWithIdentifier:@"boundaryPath"
//                                       forPath:[UIBezierPath bezierPathWithRect:self.boundary.frame]];
//    [self.collisions addBoundaryWithIdentifier:@"other boundary path"
//                                       forPath:[UIBezierPath bezierPathWithRect:otherBoundary.frame]];
//    [self.collisions addBoundaryWithIdentifier:@"another boundary path"
//                                       forPath:[UIBezierPath bezierPathWithRect:anotherBoundary.frame]];
//    [self.collisions addBoundaryWithIdentifier:@"yet another boundary path"
//                                       forPath:[UIBezierPath bezierPathWithRect:yetAnotherBoundary.frame]];
//    [self.collisions addBoundaryWithIdentifier:@"more boundary path"
//                                       forPath:[UIBezierPath bezierPathWithRect:moreBoundaries.frame]];
    [self.animator addBehavior:self.collisions];
    

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
