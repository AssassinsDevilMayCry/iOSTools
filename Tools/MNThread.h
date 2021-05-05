//
//  MNThread.h
//  TestPod
//
//  Created by xhl on 2021/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNThread : NSObject

- (void)executeTask:(void(^)(void))task;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
