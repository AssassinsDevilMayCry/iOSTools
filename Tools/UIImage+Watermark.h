//
//  UIImage+Watermark.h
//  mn_tools
//
//  Created by xhl on 2021/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    WaterImageLocationTopLeft = 0,//左上角
    WaterImageLocationTopCenter,//上面中间
    WaterImageLocationTopRight,//右上角
    WaterImageLocationCenterLeft,//左边中间
    WaterImageLocationCenter,//中心
    WaterImageLocationCenterRight,//右边中间
    WaterImageLocationBottomLeft,//左下角
    WaterImageLocationBottomCenter,//下面中心
    WaterImageLocationBottomRight,//右下角
} WaterImageLocation;


@interface UIImage (Watermark)


/// 同步获取网络图，第一次加载新的，后面取本地缓存
/// @param url 图片的url
- (UIImage *)syncImageWithUrl:(NSString *)url;


/// 给图片加水印
/// @param waterImage 水印图片(可以是图片，也可以是url)
/// @param location 水印位置 默认左上角
/// @param waterSize 水印相对应原图的比例 0～1之间
- (UIImage *)addWatermarkWithWaterImageSource:(id)waterImageSource
                                     location:(WaterImageLocation)location
                                    waterSize:(float)waterSize;

@end

NS_ASSUME_NONNULL_END
