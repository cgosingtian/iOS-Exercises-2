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

static float const touchBottomBufferVerticalPercentage = 0.35;

@interface KLBBattleViewController ()

@property (nonatomic) bool touchMoved;
@property (nonatomic) CGPoint touchedLocation;
@property (nonatomic) KLBPlayerController<KLBShipControlProtocol> *playerControllerDelegate;

@property (retain, nonatomic) IBOutlet KLBPlayerShipView *playerShipView;

@end

@implementation KLBBattleViewController

@synthesize touchMoved = _touchMoved,
            touchedLocation = _touchedLocation,
            playerShipView = _playerShipView,
            playerControllerDelegate = _playerControllerDelegate;

#pragma mark - Initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _touchMoved = false;
    }
    return self;
}

#pragma mark - Touch Controls
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    CGPoint previousLocation = [touch previousLocationInView:self.view];
    float moveSensitivity = 10.0;
    
//    NSLog(@"previous %f - current %f", previousLocation.y, touchLocation.y);
    
    if ((touchLocation.y + moveSensitivity) < previousLocation.y) {
        _touchMoved = true;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    _touchedLocation = touchLocation;
    
    if (_touchMoved) {
        //throw bomb
        [_playerControllerDelegate shipWillLaunchBomb];
        NSLog(@"bvc BOMB");
        _touchMoved = false;
    }
    else {
        //move left or right
        if (_touchedLocation.x >= self.view.frame.size.width/2) {
            [_playerControllerDelegate shipWillMoveRight];
            NSLog(@"bvc RIGHT");
        }
        else {
            [_playerControllerDelegate shipWillMoveLeft];
            NSLog(@"bvc LEFT");
        }
    }
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
}


#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_playerShipView release];
    [super dealloc];
}
@end
