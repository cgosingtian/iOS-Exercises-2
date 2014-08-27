//
//  KLBBattleViewController.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#import "KLBBattleViewController.h"
#import "KLBShipView.h"
#import "KLBPlayerShipView.h"
#import "KLBPlayerController.h"
#import "KLBTurretController.h"
#import "KLBConstants.h"

CGFloat const KLB_TOUCH_BOTTOM_BUFFER_PERCENTAGE = 0.22;
CGFloat const KLB_MINIMUM_PRESS_DURATION = 0.05;
CGFloat const KLB_ALLOWABLE_MOVEMENT = 600.0;

@interface KLBBattleViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) BOOL hasMovedTouch;
@property (nonatomic) CGPoint touchedLocation;
@property (retain, nonatomic) KLBPlayerController<KLBShipControlProtocol> *playerController;
@property (retain, nonatomic) UILongPressGestureRecognizer *longPressRecognizer;
@property (retain, nonatomic) UIPanGestureRecognizer *panRecognizer;
@property (retain, nonatomic) NSTimer *longPressTimer;
@property (retain, nonatomic) CMMotionManager *motionManager;

@property (retain, nonatomic) IBOutlet KLBPlayerShipView *playerShipView;

@end

@implementation KLBBattleViewController

#pragma mark - Dealloc
- (void) dealloc {
    _longPressRecognizer.delegate = nil;
    _panRecognizer.delegate = nil;
    
    [_playerController release];
    [_playerShipView release];
    [_longPressRecognizer release];
    [_panRecognizer release];
    
    _playerController = nil;
    _playerShipView = nil;
    _longPressRecognizer = nil;
    _panRecognizer = nil;
    
    [_scorePlaceholderLabel release];
    [_scoreActualLabel release];
    [_motionManager release];
    _motionManager = nil;
    
    [super dealloc];
}

#pragma mark - Initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hasMovedTouch = NO;
        
        _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(handleLongPress:)];
        _longPressRecognizer.delegate = self;
        _longPressRecognizer.minimumPressDuration = KLB_MINIMUM_PRESS_DURATION;
        _longPressRecognizer.allowableMovement = KLB_ALLOWABLE_MOVEMENT;
        [self.view addGestureRecognizer:_longPressRecognizer];
        
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(handlePan:)];
        _panRecognizer.delegate = self;
        [self.view addGestureRecognizer:_panRecognizer];
        
        _scorePlaceholderLabel.font = [UIFont fontWithName:KLB_DEFAULT_FONT
                                                      size:KLB_FONT_SIZE_STANDARD];
        _scoreActualLabel.font = [UIFont fontWithName:KLB_DEFAULT_FONT
                                                 size:KLB_FONT_SIZE_STANDARD];
    }
    return self;
}

#pragma mark - Touch Controls
- (void) handleLongPress:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateCancelled ||
        sender.state == UIGestureRecognizerStateFailed ||
        sender.state == UIGestureRecognizerStateEnded) {

        [_longPressTimer invalidate];
        _longPressTimer = nil;
        _playerController.isMoving = NO;
    }
    else {
        if (sender.state == UIGestureRecognizerStateBegan) {
            CGPoint touchLocation = [sender locationInView:self.view];
        
            _touchedLocation = touchLocation;
            
            _playerController.isMoving = true;
            //move left or right
            if (_touchedLocation.x >= self.view.frame.size.width/2) {
                _longPressTimer = [NSTimer scheduledTimerWithTimeInterval:KLB_ANIMATION_INTERVAL
                                                                   target:_playerController
                                                                 selector:@selector(shipWillMoveRight)
                                                                 userInfo:nil
                                                                  repeats:YES];
            }
            else {
                _longPressTimer = [NSTimer scheduledTimerWithTimeInterval:KLB_ANIMATION_INTERVAL
                                                                   target:_playerController
                                                                 selector:@selector(shipWillMoveLeft)
                                                                 userInfo:nil
                                                                  repeats:YES];
            }
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [_playerController shipWillLaunchBomb];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == _panRecognizer) {
        CGPoint velocity = [_panRecognizer velocityInView:self.view];
        return fabs(velocity.y) > fabs(velocity.x);
    }
    else return YES;
}

#pragma mark - View States
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat x = (screenWidth / 2.0) - (_playerShipView.frame.size.width / 2.0);
    CGFloat y = screenHeight - (screenHeight * KLB_TOUCH_BOTTOM_BUFFER_PERCENTAGE);
    CGPoint c = CGPointMake(x, y);
    
    _playerController = [[KLBPlayerController alloc] initWithShipView:_playerShipView coordinates:c];
    
    //load player turrets
    NSMutableDictionary *turretDict = [_playerController playerShip].turrets;
    for (NSString *key in turretDict) {
        KLBTurretController *tc = [[[KLBTurretController alloc] initWithTurret:[turretDict objectForKey:key] owner:[_playerController playerShip]] autorelease];
        [tc activateTurret];
    }
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = KLB_MOTION_UPDATE_INTERVAL;
    self.motionManager.gyroUpdateInterval = KLB_MOTION_UPDATE_INTERVAL;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^
     (CMAccelerometerData *accelerometerData, NSError *error)
     {
         //implement bomb message call here
         //implement method to delegate bomb firing below
         
         if(error){
             NSLog(@"%@", error);
         }
     }];
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Controller Overrides
- (BOOL)shouldAutorotate
{
    return NO;
}
@end
