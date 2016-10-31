//
//  YHVideoViewCell.m
//  DayDayNews
//
//  Created by 马卿 on 16/10/31.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHVideoViewCell.h"
#import "YHVideoModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "UIImage+YH.h"
@interface YHVideoViewCell()
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIImageView *preView;
@property (nonatomic,retain) UIButton *duration;
@property (nonatomic,retain) UIButton *times;
@property (nonatomic,retain) UILabel *updateLabel;
@end
@implementation YHVideoViewCell
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UIImageView *)preView{
    if (!_preView) {
        _preView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.preView];
    }
    return _preView;
}
-(UIButton *)duration{
    if (!_duration) {
        _duration = [[UIButton alloc] init];
        _duration.titleLabel.font = [UIFont systemFontOfSize:12];
        _duration.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_duration];
    }
    return _duration;
}
-(UIButton *)times{
    if (!_times) {
        _times = [[UIButton alloc] init];
        _times.titleLabel.font = [UIFont systemFontOfSize:12];
        _times.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_times];
    }
    return _times;
}
-(void)initView{
    self.titleLabel = [[UILabel alloc] init];
    self.preView = [[UIImageView alloc] init];
    self.duration = [[UIButton alloc] init];
    self.times = [[UIButton alloc] init];
    self.updateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    self.duration.titleLabel.font = [UIFont systemFontOfSize:10];
    self.duration.titleLabel.textColor = [UIColor whiteColor];
    self.times.titleLabel.font = [UIFont systemFontOfSize:10];
    self.times.titleLabel.textColor = [UIColor whiteColor];
    self.updateLabel.font = [UIFont systemFontOfSize:0];
    self.updateLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.preView];
    [self.contentView addSubview:self.duration];
    [self.contentView addSubview:self.times];
    [self.contentView addSubview:self.updateLabel];
    [self.contentView setAutoresizesSubviews:false];
}
-(void)setModel:(YHVideoModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.updateLabel.text = model.ptime;
    NSURL *coverURL = [NSURL URLWithString:model.cover];
    [self.preView sd_setImageWithURL:coverURL placeholderImage: [UIImage imageNamed:@"videoplaceholder"]];
    int miniute = (int)model.length/60;
    int second = model.length%60;
    NSString *duration = [NSString stringWithFormat:@"%2d:%2d",miniute,second];
    NSString *playCount = [NSString stringWithFormat:@"%lu",model.playCount];
    //NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //dateFormat.dateFormat = @"yyyy-mm-dd hh:mm:ss";
    //NSDate *date = [dateFormat dateFromString:model.ptime];
    
    [self.duration setTitle:duration forState:UIControlStateNormal];
    [self.times setTitle:playCount forState:UIControlStateNormal];
    UIImage *durationImage = [UIImage imageNamed:@"play"];
    durationImage = [durationImage fixOrietationWithScale:0.4];
    UIImage *timesImage = [UIImage imageNamed:@"play"];
    timesImage = [timesImage fixOrietationWithScale:0.4];
    [self.duration setImage:durationImage forState:UIControlStateNormal];
    [self.times setImage:timesImage forState:UIControlStateNormal];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.height.equalTo(@40);
    }];
    [_preView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.height.equalTo(@160);
    }];
    [_duration mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.preView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
        make.height.equalTo(@26);
    }];
    [_times mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.preView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.duration.mas_right).offset(10);
        make.height.equalTo(@26);
    }];
    
}
@end
