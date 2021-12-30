//
//  NKOViewController.m
//  NKOActivityIndicatorView
//
//  Created by Carlos Vidal Pallin on 06/08/2015.
//  Copyright (c) 2015 Carlos Vidal Pallin. All rights reserved.
//

#import "NKOExampleController.h"
#import "NKOActivityIndicatorView.h"

typedef NS_ENUM(NSUInteger, LYExampleControllerColor) {
    LYExampleControllerColorBlack = 0,
    LYExampleControllerColorGray,
    LYExampleControllerColorBlue,
    LYExampleControllerColorRed
};

@interface NKOExampleController ()

@property (nonatomic, strong) IBOutlet NKOActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *activityIndicatorWidthConstraint;

@property (nonatomic, assign) CGFloat indicatorInitialWidth;

@end

@implementation NKOExampleController

#pragma mark - Class life cycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_onAppBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indicatorInitialWidth = self.activityIndicatorWidthConstraint.constant;
}

#pragma mark - Private methods

- (void)_updateActivityIndicatorSizeWithScale:(CGFloat)scale {
    CGFloat width = self.indicatorInitialWidth * scale;
    self.activityIndicatorWidthConstraint.constant = width;
    [self.view updateConstraintsIfNeeded];
}

- (void)_onAppBecomeActiveNotification:(NSNotification*)notification {
    if (self.activityIndicatorView.isAnimating == NO) {
        [self.activityIndicatorView startAnimating];
    }
}

#pragma mark - IBActions

- (IBAction)_changedColorSegmentedControl:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case LYExampleControllerColorBlack:
            self.activityIndicatorView.color = [UIColor blackColor];
            break;
        case LYExampleControllerColorGray:
            self.activityIndicatorView.color = [UIColor darkGrayColor];
            break;
        case LYExampleControllerColorBlue:
            self.activityIndicatorView.color = [UIColor blueColor];
            break;
        case LYExampleControllerColorRed:
            self.activityIndicatorView.color = [UIColor redColor];
            break;
    }
}

- (IBAction)_tappedFollowMeButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/carlostify"] options:nil completionHandler:nil];
}

- (IBAction)_tappedBorderStepper:(UIStepper *)sender {
    self.activityIndicatorView.lineWidth = sender.value;
}

- (IBAction)_tappedSizeStepper:(UIStepper *)sender {
    CGFloat scale = sender.value * 0.01f;
    [self _updateActivityIndicatorSizeWithScale:scale];
}

@end
