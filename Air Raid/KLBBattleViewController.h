//
//  KLBBattleViewController.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const KLB_TOUCH_BOTTOM_BUFFER_PERCENTAGE;
extern CGFloat const KLB_MINIMUM_PRESS_DURATION;
extern CGFloat const KLB_ALLOWABLE_MOVEMENT;

@interface KLBBattleViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *scorePlaceholderLabel;
@property (retain, nonatomic) IBOutlet UILabel *scoreActualLabel;

@end
