//
//  VMAPIAdapter.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Objection/Objection.h>
#import "VMAPIAdapter.h"
#import "VMAPI.h"

NSString *const VMAPIAdapterErrorDomain = @"VMAPIAdapterErrorDomain";

static NSInteger const VMBNumberSecondsDay = 86400;

@interface VMAPIAdapter ()
@property (nonatomic, strong) VMAPI *api;
@end

@implementation VMAPIAdapter
objection_register_singleton(VMAPIAdapter)
objection_requires(@"api")

- (RACSignal *)todayRateWithParams:(NSDictionary *)params {
    return [[self.api getPath:@"latest" withParams:params] catch:^RACSignal *(NSError *error) {
        return [VMAPIAdapter p_handleError:error];
    }];
}

- (RACSignal *)yesterdayRateWithParams:(NSDictionary *)params {
    return [[self.api getPath:[VMAPIAdapter yesterdayDate] withParams:params] catch:^RACSignal *(NSError *error) {
        return [VMAPIAdapter p_handleError:error];
    }];
}

#pragma mark - Private

+ (RACSignal *)p_handleError:(NSError *)error {
    return [RACSignal error:[NSError errorWithDomain:VMAPIAdapterErrorDomain code:VMAPIAdapterErrorCodeUndefined userInfo:nil]];
}

+ (NSString *)yesterdayDate {
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-VMBNumberSecondsDay];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *yesterdayFormatter = [formatter stringFromDate:yesterdayDate];
    return yesterdayFormatter;
}

@end
