//
//  MNTimer.m
//  TestPod
//
//  Created by xhl on 2021/5/5.
//

#import "MNTimer.h"

@interface MNTimer()
@property  (strong ,nonatomic) dispatch_source_t timer;
@end

@implementation MNTimer

static NSMutableDictionary *timers_;
static dispatch_semaphore_t semaphore_;

+ (void)initialize
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        timers_ =[NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+ (NSString *)exectTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async
{
   
    if ( !task || start < 0 || (interval <= 0 && repeats)) return nil;

    //队列
//    dispatch_queue_t queue = async ? dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL) : dispatch_get_main_queue();
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();

    //创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start *NSEC_PER_SEC),
                              interval * NSEC_PER_SEC,
                              0);
    
    //线程加锁
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    //定时器的唯一标识
    NSString *name = [NSString stringWithFormat:@"%@",@(timers_.count)];
    //存放到字典中
    timers_[name] = timer;
    //线程加锁
    dispatch_semaphore_signal(semaphore_);

    //执行回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    
    //启动定时器
    dispatch_resume(timer);
    return name;
}

+ (NSString *)exectTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async
{
    
    if (!target || !selector) return nil;
    return [self exectTask:^{
        if ([target respondsToSelector:selector]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//这里是会报警告的代码
            [target performSelector:selector];
#pragma clang diagnostic pop
        }

    } start:start interval:interval repeats:repeats async:async];
}


+ (void)cancelTask:(NSString *)name
{
    if (name.length == 0) return;
    dispatch_source_t timer = timers_[name];
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:name];
    }
    dispatch_semaphore_signal(semaphore_);
}




@end
