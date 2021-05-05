//
//  MNTimer.h
//  TestPod
//
//  Created by xhl on 2021/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface MNTimer : NSObject

/// GCD定时器
/// @param task 执行任务block
/// @param start 开始时间
/// @param interval 间隔时间
/// @param repeats YES：重复   NO：不重复
/// @param async 是不是主线程执行
+ (NSString *)exectTask:(void (^)(void))task
            start:(NSTimeInterval)start
         interval:(NSTimeInterval)interval
          repeats:(BOOL)repeats
            async:(BOOL)async;


+ (NSString *)exectTask:(id)target
               selector:(SEL)selector
            start:(NSTimeInterval)start
         interval:(NSTimeInterval)interval
          repeats:(BOOL)repeats
            async:(BOOL)async;

///  取消任务
/// @param name 创建任务时返回的name
+ (void)cancelTask:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
