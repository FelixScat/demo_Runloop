//
//  ViewController.m
//  demo
//
//  Created by FelixPlus on 2019/8/28.
//  Copyright © 2019 Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *t;

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, strong) NSPort *port;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _t = [NSTimer timerWithTimeInterval:1.0f repeats:true block:^(NSTimer * _Nonnull timer) {
        
//        NSLog(@"Timer Triggered");
    }];
    [[NSRunLoop currentRunLoop] addTimer:_t forMode:NSRunLoopCommonModes];
    
    [self performSelectorInBackground:@selector(someBussiness) withObject:nil];
    
    [self.thread start];
}

- (void)someBussiness {
    
//    [self performSelector:@selector(bussinessFinished) withObject:nil afterDelay:0.0f inModes:@[NSDefaultRunLoopMode]];
    NSLog(@"Some Bussiness");
}

- (void)bussinessFinished {
    
}

- (void)selfThread {
    
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addPort:self.port forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(someBussiness) onThread:self.thread withObject:nil waitUntilDone:false];
}

#pragma mark - Getter

- (NSThread *)thread {
    if (!_thread) {
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(selfThread) object:nil];
    }
    return _thread;
}

- (NSPort *)port {
    if (!_port) {
        _port = [NSPort port];
    }
    return _port;
}


@end
