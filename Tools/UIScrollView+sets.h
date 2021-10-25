//
//  UIScrollView+sets.h
//  Pods
//
//  Created by xhl on 2021/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (sets)


/// 设置UIScrollView上面子view 点击滚动到中间
/// @param subView 点击的子view
- (void)scrollCenterWithTapSubView:(UIView *)subView;

@end

NS_ASSUME_NONNULL_END
