//
//  YHVideoNavViewCell.m
//  DayDayNews
//
//  Created by 马卿 on 16/10/31.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHVideoNavViewCell.h"
@interface YHVideoNavViewCell()
@property (weak, nonatomic) IBOutlet UIButton *miracle;//奇葩
@property (weak, nonatomic) IBOutlet UIButton *cutepet;//萌宠
@property (weak, nonatomic) IBOutlet UIButton *funyGirl;//美女
@property (weak, nonatomic) IBOutlet UIButton *boutique;//精品


@end
@implementation YHVideoNavViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width/4;
    CGFloat btnH = 80;
    CGFloat imageEdageTopAndBottom = (btnH - 50)/2;
    CGFloat imageEdageLeftAndRight = (btnW - 40)/2;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.miracle.layer.borderWidth = 0.5;
    self.miracle.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cutepet.layer.borderWidth = 0.5;
    self.cutepet.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.funyGirl.layer.borderWidth = 0.5;
    self.funyGirl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.boutique.layer.borderWidth = 0.5;
    self.boutique.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.miracle.imageEdgeInsets = UIEdgeInsetsMake(-imageEdageTopAndBottom, imageEdageLeftAndRight, imageEdageTopAndBottom, imageEdageLeftAndRight);
    self.cutepet.imageEdgeInsets = UIEdgeInsetsMake(-imageEdageTopAndBottom, imageEdageLeftAndRight, imageEdageTopAndBottom, imageEdageLeftAndRight);
    self.funyGirl.imageEdgeInsets = UIEdgeInsetsMake(-imageEdageTopAndBottom, imageEdageLeftAndRight, imageEdageTopAndBottom, imageEdageLeftAndRight);
    self.boutique.imageEdgeInsets = UIEdgeInsetsMake(-imageEdageTopAndBottom, imageEdageLeftAndRight, imageEdageTopAndBottom, imageEdageLeftAndRight);
}

#pragma mark ---Action Event
- (IBAction)miracleClicked {
}
- (IBAction)cutepetClicked {
}
- (IBAction)funyGirlClicked {
}
- (IBAction)boutiqueClicked {
}
@end
