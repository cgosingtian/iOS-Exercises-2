//
//  KLBBattleViewController.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBattleViewController.h"
#import "KLBShipView.h"
#import "KLBPlayerShipView.h"
#import "KLBPlayerController.h"
#import "KLBTurretController.h"

#import "KLBEnemyShipController.h" // debug

static float const touchBottomBufferVerticalPercentage = 0.35;

@interface KLBBattleViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) bool touchMoved;
@property (nonatomic) CGPoint touchedLocation;
@property (nonatomic,retain) KLBPlayerController<KLBShipControlProtocol> *playerControllerDelegate;
@property (nonatomic,retain) UILongPressGestureRecognizer *longPressRecognizer;
@property (nonatomic,retain) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic,retain) NSTimer *longPressTimer;

@property (retain, nonatomic) IBOutlet KLBPlayerShipView *playerShipView;

@end

@implementation KLBBattleViewController

@synthesize touchMoved = _touchMoved,
            touchedLocation = _touchedLocation,
            playerShipView = _playerShipView,
            playerControllerDelegate = _playerControllerDelegate,
            longPressRecognizer = _longPressRecognizer,
            panRecognizer = _panRecognizer;

#pragma mark - Dealloc
- (void) dealloc {
    _longPressRecognizer.delegate = nil;
    _panRecognizer.delegate = nil;
    
    [_playerControllerDelegate release];
    [_playerShipView release];
    [_longPressRecognizer release];
    [_panRecognizer release];
    
    _playerControllerDelegate = nil;
    _playerShipView = nil;
    _longPressRecognizer = nil;
    _panRecognizer = nil;
    
    [_scorePlaceholderLabel release];
    [_scoreActualLabel release];
    [super dealloc];
}

#pragma mark - Initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _touchMoved = false;
        
//        _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                                 action:@selector(handleLongPress:)];
//        _longPressRecognizer.delegate = self;
//        _longPressRecognizer.minimumPressDuration = 0.05;
//        _longPressRecognizer.allowableMovement = 600.0;
//        [self.view addGestureRecognizer:_longPressRecognizer];
//        
//        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
//                                                                 action:@selector(handlePan:)];
//        _panRecognizer.delegate = self;
//        [self.view addGestureRecognizer:_panRecognizer];
        
        _scorePlaceholderLabel.font = [UIFont fontWithName:@"OCR A Std" size:15.0];
        _scoreActualLabel.font = [UIFont fontWithName:@"OCR A Std" size:15.0];
    }
    return self;
}

#pragma mark - Touch Controls
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    KLBEnemyShipController *enemyShipController = [[KLBEnemyShipController alloc] initWithShipView:nil coordinates:touchLocation];
    [enemyShipController activateAI];
}
//- (void) handleLongPress:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateCancelled ||
//        sender.state == UIGestureRecognizerStateFailed ||
//        sender.state == UIGestureRecognizerStateEnded) {
//
//        [_longPressTimer invalidate];
//        _longPressTimer = nil;
//        _playerControllerDelegate.isMoving = false;
//    }
//    else {
//        if (sender.state == UIGestureRecognizerStateBegan) {
//            CGPoint touchLocation = [sender locationInView:self.view];
//        
//            _touchedLocation = touchLocation;
//            
//            _playerControllerDelegate.isMoving = true;
//            //move left or right
//            if (_touchedLocation.x >= self.view.frame.size.width/2) {
//                _longPressTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
//                                                                   target:_playerControllerDelegate
//                                                                 selector:@selector(shipWillMoveRight)
//                                                                 userInfo:nil
//                                                                  repeats:YES];
//            }
//            else {
//                _longPressTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
//                                                                   target:_playerControllerDelegate
//                                                                 selector:@selector(shipWillMoveLeft)
//                                                                 userInfo:nil
//                                                                  repeats:YES];
//            }
//        }
//    }
//}
//
//- (void)handlePan:(UIPanGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        [_playerControllerDelegate shipWillLaunchBomb];
//    }
//}

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
    
    CGFloat x = (self.view.frame.size.width / 2.0) - (_playerShipView.frame.size.width/2.0);
    CGFloat y = self.view.frame.size.height - (self.view.frame.size.height * touchBottomBufferVerticalPercentage);
    CGPoint c = CGPointMake(x, y);
    
    _playerControllerDelegate = [[KLBPlayerController alloc] initWithShipView:_playerShipView coordinates:c];
    
    //load player turrets
    NSMutableDictionary *turretDict = [_playerControllerDelegate playerShip].turrets;
    for (NSString *key in turretDict) {
        KLBTurretController *tc = [[[KLBTurretController alloc] initWithTurret:[turretDict objectForKey:key] owner:[_playerControllerDelegate playerShip]] autorelease];
        [tc activateTurret];
    }
    
    
}


#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
