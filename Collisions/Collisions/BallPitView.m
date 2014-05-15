//
//  BallPitView.m
//  Collisions
//
//  Created by pivotal on 5/14/14.
//  Copyright (c) 2014 Shusta. All rights reserved.
//

#import "BallPitView.h"

@interface BallPitView ()<UICollisionBehaviorDelegate>
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UICollisionBehavior *collisions;
@property (nonatomic, strong) UIView *square;
@property (nonatomic, strong) UIView *boundary;
@end

@implementation BallPitView

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];

    self.square = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 100, .size.width = 100, .size.height = 100}];
    self.square.backgroundColor = [UIColor grayColor];
    self.square.transform = CGAffineTransformMakeRotation(M_PI / 6);
    [self addSubview:self.square];

    self.boundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 101, .origin.y = 230, .size.width = 11, .size.height = 20}];
    self.boundary.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.boundary];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    self.collisions = [[UICollisionBehavior alloc] initWithItems:@[self.square]];
    self.collisions.translatesReferenceBoundsIntoBoundary = YES;
    self.collisions.collisionDelegate = self;

    UIView *otherBoundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 160, .origin.y = 470, .size.width = 20, .size.height = 20}];
    otherBoundary.backgroundColor = [UIColor greenColor];
    [self addSubview:otherBoundary];

    UIView *anotherBoundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 100, .origin.y = 400, .size.width = 5, .size.height = 50}];
    anotherBoundary.backgroundColor = [UIColor magentaColor];
    [self addSubview:anotherBoundary];

    UIView *yetAnotherBoundary = [[UIView alloc] initWithFrame:(CGRect){.origin.x = 270, .origin.y = 370, .size.width = 5, .size.height = 50}];
    yetAnotherBoundary.backgroundColor = [UIColor purpleColor];
    [self addSubview:yetAnotherBoundary];

    [self.collisions addBoundaryWithIdentifier:@"boundaryPath"
                                       forPath:[UIBezierPath bezierPathWithRect:self.boundary.frame]];
    [self.collisions addBoundaryWithIdentifier:@"other boundary path"
                                       forPath:[UIBezierPath bezierPathWithRect:otherBoundary.frame]];
    [self.collisions addBoundaryWithIdentifier:@"another boundary path"
                                       forPath:[UIBezierPath bezierPathWithRect:anotherBoundary.frame]];
    [self.collisions addBoundaryWithIdentifier:@"yet another boundary path"
                                       forPath:[UIBezierPath bezierPathWithRect:yetAnotherBoundary.frame]];
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
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square]];

    [self.animator addBehavior:self.gravity];
}

#pragma mark - <UICollisionBehaviorDelegate>

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(NSString *)identifier atPoint:(CGPoint)p {
    if ([identifier isEqual:@"other boundary path"]
        && self.gravity.action == NULL) {
        __block NSInteger count = 0;
        __weak BallPitView *weakSelf = self;
        self.gravity.action = ^{
            if (count % 1 == 0) {
                UIView *newSquare = [[UIView alloc] initWithFrame:weakSelf.square.bounds];
                newSquare.center = weakSelf.square.center;
                newSquare.transform = weakSelf.square.transform;
                newSquare.backgroundColor = [UIColor clearColor];
                newSquare.layer.borderColor = [[UIColor redColor] CGColor];
                newSquare.layer.borderWidth = 0.5;
                [weakSelf addSubview:newSquare];
            }

            ++count;
        };

    }


}

@end
