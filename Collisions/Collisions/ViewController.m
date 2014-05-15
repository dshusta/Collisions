//
//  ViewController.m
//  Collisions
//
//  Created by pivotal on 5/14/14.
//  Copyright (c) 2014 Shusta. All rights reserved.
//

#import "ViewController.h"
#import "BallPitView.h"

@interface ViewController ()


@property (nonatomic, strong) BallPitView *ballPitView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBallPit];

}

- (void)addBallPit {
    self.ballPitView = [[BallPitView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.ballPitView];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(turnOnGravity:)];
    [self.ballPitView addGestureRecognizer:tapGestureRecognizer];
}

- (void)turnOnGravity:(UITapGestureRecognizer *)sender {
    [self.ballPitView startGravity];
    [self.ballPitView removeGestureRecognizer:sender];

    UITapGestureRecognizer *resetTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(resetBallPit:)];
    [self.ballPitView addGestureRecognizer:resetTapGestureRecognizer];
}

- (void)resetBallPit:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.ballPitView removeFromSuperview];
    [self addBallPit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
