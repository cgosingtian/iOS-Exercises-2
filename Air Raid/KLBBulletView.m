//
//  KLBBulletView.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBulletView.h"
#import "KLBBullet.h"
#import "KLBConstants.h"

// Image filenames
NSString *const KLB_BULLET_DEFAULT_FILENAME = @"bullet_default.png";
NSString *const KLB_BULLET_DEFAULT_FILENAME2 = @"bullet_default2.png";
NSString *const KLB_BULLET_MACHINEGUN_FILENAME = @"bullet_machinegun.png";
NSString *const KLB_BULLET_MACHINEGUN_FILENAME2 = @"bullet_machinegun2.png";
NSString *const KLB_BULLET_CANNON_FILENAME = @"bullet_cannon.png";
NSString *const KLB_BULLET_CANNON_FILENAME2 = @"bullet_cannon2.png";

// Animation values
CGFloat const KLB_FADE_IN_DURATION = 0.1;
CGFloat const KLB_FADE_IN_MAX_ALPHA = 1.0;
CGFloat const KLB_BULLET_SWITCH_ANIMATION_DURATION = 0.5;

@implementation KLBBulletView

#pragma mark - Dealloc
- (void)dealloc {
    [_bullet release];
    _bullet = nil;
    [super dealloc];
}

#pragma mark - Initializers
- (instancetype)initWithBullet:(KLBBullet *)bullet {
    self = [super init];
    if (self) {
        CGFloat x = KLB_ZERO_F;
        CGFloat y = KLB_ZERO_F;
        _bullet = bullet;
        UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_DEFAULT_FILENAME];
        self.image = bulletImage;
        
        switch (bullet.bulletType) {
            case btMachineGun: {
                UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_MACHINEGUN_FILENAME];
                self.image = bulletImage;
            }
                break;
            case btCannon: {
                UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_CANNON_FILENAME];
                self.image = bulletImage;
            }
                break;
            case btDefaultBulletType:
                break;
            default:
                break;
        }
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);

        // add self to active view
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *topView = window.rootViewController.view;
        [topView addSubview:self];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CGFloat x = KLB_ZERO_F;
        CGFloat y = KLB_ZERO_F;
        UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_DEFAULT_FILENAME];
        self.image = bulletImage;
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);
        
        // add self to active view
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *topView = window.rootViewController.view;
        [topView addSubview:self];
    }
    return self;
}

#pragma mark - View Movement
- (void)updateCoordinatesX:(CGFloat) x Y:(CGFloat) y {
    [self setFrame:CGRectMake(x, y, self.image.size.width, self.image.size.height)];
}

#pragma mark - View Image
- (void)changeBulletImage:(BulletTypes)bulletType {
    switch (bulletType) {
        case btMachineGun: {
            UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_MACHINEGUN_FILENAME];
            self.image = bulletImage;
        }
            break;
        case btCannon: {
            UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_CANNON_FILENAME];
            self.image = bulletImage;
        }
            break;
        case btDefaultBulletType: {
            UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_DEFAULT_FILENAME];
            self.image = bulletImage;
        }
            break;
        default: {
            UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_DEFAULT_FILENAME];
            self.image = bulletImage;
        }
    }
}

#pragma mark - Animation
- (void)animateFadeIn {
    [self setAlpha:0.0];
    [UIView
     animateKeyframesWithDuration:KLB_FADE_IN_DURATION
     delay:KLB_ZERO_F
     options:0
     animations:^() {
        [UIView
         addKeyframeWithRelativeStartTime:KLB_ZERO_F
         relativeDuration:KLB_ONE_F
         animations:^() {
            [self setAlpha:KLB_FADE_IN_MAX_ALPHA];
        }];
    }
     completion:^(BOOL finished) {
        if (finished) {
            [self animateBulletEffects];
        }
    }];
}

- (void)animateBulletEffects {
    [UIView
     animateKeyframesWithDuration:KLB_BULLET_SWITCH_ANIMATION_DURATION
     delay:KLB_ZERO_F
     options:UIViewKeyframeAnimationOptionRepeat
     animations:^() {
        [UIView
         addKeyframeWithRelativeStartTime:KLB_ZERO_F
         relativeDuration:KLB_ONE_F
         animations:^() {
            if (_bullet) {
                switch (_bullet.bulletType) {
                    case btMachineGun: {
                        UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_MACHINEGUN_FILENAME2];
                        self.image = bulletImage;
                    }
                        break;
                    case btCannon: {
                        UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_CANNON_FILENAME2];
                        self.image = bulletImage;
                    }
                        break;
                    case btDefaultBulletType: {
                        UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_DEFAULT_FILENAME2];
                        self.image = bulletImage;
                    }
                        break;
                    default: {
                        UIImage *bulletImage = [UIImage imageNamed:KLB_BULLET_DEFAULT_FILENAME2];
                        self.image = bulletImage;
                    }
                }
            }
        }];
    } completion:nil];
}

@end
