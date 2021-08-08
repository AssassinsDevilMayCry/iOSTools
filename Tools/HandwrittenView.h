//
//  HandwrittenView.h
//  mn_tools
//
//  Created by beautiful on 2021/8/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HandwrittenView : UIView

// 线宽 默认1
@property (nonatomic, assign) CGFloat lineWidth;
// 线颜色 默认黑
@property (nonatomic, strong) UIColor *lineColor;
// 生成图片的缩放比例 默认1不缩放 范围0.1~1.0
@property (nonatomic, assign) CGFloat imageScale;
// 生成的图片
@property (nonatomic, strong) UIImage *signImage;

// 初始化视图之后调用 准备画图
- (void)startDraw;
// 重置
- (void)resetDraw;
// 保存成图片
- (void)saveDraw;


@end

NS_ASSUME_NONNULL_END
