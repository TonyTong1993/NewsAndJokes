//
//  YHCollectionViewCell.m
//  DayDayNews
//
//  Created by 马卿 on 16/9/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHCollectionViewCell.h"
#import "YHPhoto.h"
#import "UIImageView+WebCache.h"
@interface YHCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation YHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-(void)setPhoto:(YHPhoto *)photo{
    _photo = photo;
    [_imageView    sd_setImageWithURL:
     [NSURL URLWithString:photo.small_url]
                     placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    _title.text = photo.title;
    [_title sizeToFit];
}
@end
