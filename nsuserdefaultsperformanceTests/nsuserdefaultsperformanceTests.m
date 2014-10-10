//
//  nsuserdefaultsperformanceTests.m
//  nsuserdefaultsperformanceTests
//
//  Created by Brady Archambo on 10/9/14.
//  Copyright (c) 2014 Brady Archambo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface nsuserdefaultsperformanceTests : XCTestCase

@property (nonatomic) NSInteger count;
@property (nonatomic) NSMutableDictionary *cache;

@end

@implementation nsuserdefaultsperformanceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.cache = [NSMutableDictionary dictionary];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

- (void)testPerformance {
    
    NSInteger iterations = 1000;
    
    [NSUserDefaults resetStandardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self resetDefaults];
    
    uint64_t t_1 = dispatch_benchmark(1, ^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < iterations; i++) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", i] forKey:@"asdf"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    });
    NSLog(@"NSUserDefaultswith synch Avg. Runtime: %llu ns", t_1);
    
    
    
    
    [NSUserDefaults resetStandardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self resetDefaults];
    
    uint64_t t_0 = dispatch_benchmark(1, ^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < iterations; i++) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", i] forKey:@"asdf"];
        }
    });
    NSLog(@"NSUserDefaults SetObject Avg. Runtime: %llu ns", t_0);
    
    
    
    
    [NSUserDefaults resetStandardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self resetDefaults];
    
    for (int i = 0; i < 100; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:[self randomStringWithLength:10000] forKey:[NSString stringWithFormat:@"%i", arc4random()]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    uint64_t t_2 = dispatch_benchmark(1, ^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < iterations; i++) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", i] forKey:@"asdf"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    });
    NSLog(@"NSUserDefaults pop synch Avg. Runtime: %llu ns", t_2);

    
    
    [NSUserDefaults resetStandardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self resetDefaults];
    
    
    for (int i = 0; i < 100; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:[self randomStringWithLength:10000] forKey:[NSString stringWithFormat:@"%i", arc4random()]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    uint64_t t_3 = dispatch_benchmark(1, ^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < iterations; i++) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", i] forKey:@"asdf"];
        }
    });
    NSLog(@"NSUserDefaults pop bject Avg. Runtime: %llu ns", t_3);
    
    
    
    
    [NSUserDefaults resetStandardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self resetDefaults];
    
    for (int i = 0; i < 1000; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:[self randomStringWithLength:10000] forKey:[NSString stringWithFormat:@"%i", arc4random()]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    uint64_t t_5 = dispatch_benchmark(1, ^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < iterations; i++) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", i] forKey:@"asdf"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    });
    NSLog(@"NSUserDefaults pop synch Avg. Runtime: %llu ns", t_5);
    
    
    
    [NSUserDefaults resetStandardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self resetDefaults];
    
    
    for (int i = 0; i < 1000; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:[self randomStringWithLength:10000] forKey:[NSString stringWithFormat:@"%i", arc4random()]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    uint64_t t_6 = dispatch_benchmark(1, ^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < iterations; i++) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", i] forKey:@"asdf"];
        }
    });
    NSLog(@"NSUserDefaults pop bject Avg. Runtime: %llu ns", t_6);
    
    
    
    
    uint64_t t_4 = dispatch_benchmark(1, ^{
        // Put the code you want to measure the time of here.
        NSString *test = nil;
        for (int i = 0; i < iterations; i++) {
            test = [NSString stringWithFormat:@"%i", i];
            [self.cache setObject:test forKey:@"asdf"];
        }
    });
    NSLog(@"NSDictionary SetObject   Avg. Runtime: %llu ns", t_4);
}

-(void) resetDefaults {
    NSDictionary *defaultsDict = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (NSString *key in [defaultsDict allKeys])
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}

@end
