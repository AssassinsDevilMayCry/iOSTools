//
//  UIScrollView+sets.m
//  Pods
//
//  Created by xhl on 2021/10/18.
//

#import "UIScrollView+sets.h"

@implementation UIScrollView (sets)
- (void)scrollCenterWithTapSubView:(UIView *)subView{
    CGFloat offsetX = subView.center.x - self.bounds.size.width/2;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxRight = self.contentSize.width - self.bounds.size.width;
    if (offsetX > maxRight) {
        offsetX = maxRight;
    }
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];

}
@end
