//
//  MNThread.m
//  TestPod
//
//  Created by xhl on 2021/4/19.
//

#import "MNThread.h"

//@interface TestThread : NSThread
//
//@end
//@implementation TestThread
//- (void)dealloc
//{
//    NSLog(@"%s",__func__);
//}
//@end


@interface MNThread ()
@property  (strong ,nonatomic) NSThread *thread;
@property  (assign ,nonatomic,getter=isStoped) BOOL stoped;
@end


@implementation MNThread

#pragma mark - Piblic Methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        if (@available(iOS 10.0, *)) {
            self.thread = [[NSThread alloc] initWithBlock:^{
                [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
                
                while (weakSelf  && !weakSelf.isStoped) {
                    [[NSRunLoop currentRunLoop]  runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                }
            }];
        } else {
            // Fallback on earlier versions
        }
        [self.thread start];
        
    }
    return self;
}

- (void)executeTask:(void(^)(void))task
{
    if (!self.thread || !task) return;

    [self performSelector:@selector(__executeTask:)
                 onThread:self.thread
               withObject:task
            waitUntilDone:NO];//是否阻塞线程
}

- (void)stop
{
    if (!self.thread) return;

    [self performSelector:@selector(__stop)
                 onThread:self.thread
               withObject:nil
            waitUntilDone:YES];
}

#pragma mark - private Methods

- (void)__stop
{
    self.stoped =  YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__executeTask:(void(^)(void))task
{
    task();
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self stop];
}
@end
