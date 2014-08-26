//
//  KLBBulletView.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBulletView.h"
#import "KLBBullet.h"

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
        float x = 0.0;
        float y = 0.0;
        _bullet = bullet;
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
        self.image = bulletImage;
        
        switch (bullet.bulletType) {
            case btMachineGun:
            {
                UIImage *bulletImage = [UIImage imageNamed:@"bullet_machinegun.png"];
                self.image = bulletImage;
            }
                break;
            case btCannon:
            {
                UIImage *bulletImage = [UIImage imageNamed:@"bullet_cannon.png"];
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
        float x = 0.0;
        float y = 0.0;
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
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
    //[self setNeedsDisplay];
}

#pragma mark - View Image
- (void)changeBulletImage:(BulletTypes)bulletType {
    switch (bulletType) {
        case btMachineGun:
        {
            UIImage *bulletImage = [UIImage imageNamed:@"bullet_machinegun.png"];
            self.image = bulletImage;
        }
            break;
        case btCannon: {
            UIImage *bulletImage = [UIImage imageNamed:@"bullet_cannon.png"];
            self.image = bulletImage;
        }
            break;
        case btDefaultBulletType: {
            UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
            self.image = bulletImage;
        }
            break;
        default: {
            UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
            self.image = bulletImage;
        }
    }
}

#pragma mark - Animation
- (void)animateFadeIn {
    [self setAlpha:0.0];
    [UIView animateKeyframesWithDuration:0.1 delay:0.0 options:0
    animations:^()
    {
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^()
         {
             [self setAlpha:1.0];
         }];
    }
    completion:^(BOOL finished)
    {
        if (finished) {
            [self animateBulletEffects];
        }
    }];
}

- (void)animateBulletEffects {
    [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat animations:^(){
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^(){
            if (_bullet) {
                switch (_bullet.bulletType) {
                    case btMachineGun:
                    {
                        UIImage *bulletImage = [UIImage imageNamed:@"bullet_machinegun2.png"];
                        self.image = bulletImage;
                    }
                        break;
                    case btCannon: {
                        UIImage *bulletImage = [UIImage imageNamed:@"bullet_cannon2.png"];
                        self.image = bulletImage;
                    }
                        break;
                    case btDefaultBulletType: {
                        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default2.png"];
                        self.image = bulletImage;
                    }
                        break;
                    default: {
                        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default2.png"];
                        self.image = bulletImage;
                    }
                }
            }
        }];
    } completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
