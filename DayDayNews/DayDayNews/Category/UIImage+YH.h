//
//  UIImage+YH.h
//

#import <UIKit/UIKit.h>

@interface UIImage (YH)

/**
 *  @auther : <#name#>
 *  @brief :
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  @auther : tongwanhua
 *  @brief : 缩放图片
 */
- (UIImage *)fixOrietationWithScale:(CGFloat)scale;
//修改图片尺寸
-(UIImage *)imageWithImageSimple:( UIImage *)image scaledToSize:( CGSize )newSize;
@end
