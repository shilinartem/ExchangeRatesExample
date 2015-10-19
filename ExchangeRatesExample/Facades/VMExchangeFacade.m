//
//  VMExchangeFacade.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Objection/Objection.h>
#import "VMExchangeFacade.h"
#import "VMAPIAdapter.h"
#import "VMExchangeRateModel.h"

NSString *const VMExchangeFacadeErrorDomain = @"VMExchangeFacadeErrorDomain";

@interface VMExchangeFacade ()
@property (nonatomic, strong) VMAPIAdapter *apiAdapter;
@end

@implementation VMExchangeFacade
objection_register_singleton(VMExchangeFacade)

objection_requires(@"apiAdapter");

- (RACSignal *)todayRateWithType:(VMExchangeValuesType)type {
    return [[[self.apiAdapter todayRateWithParams:[VMExchangeFacade p_configureParamsWithType:type]] flattenMap:^RACStream *(NSDictionary *model) {
        NSError *error = nil;
        VMExchangeRateModel *rate = [MTLJSONAdapter modelOfClass:[VMExchangeRateModel class] fromJSONDictionary:model error:&error];
        
        return [RACSignal return:rate];
    }] catch:^RACSignal *(NSError *error) {
        return [VMExchangeFacade p_handleError:error];
    }];
}

- (RACSignal *)yesterdayRateWithType:(VMExchangeValuesType)type {
    return [[[self.apiAdapter yesterdayRateWithParams:[VMExchangeFacade p_configureParamsWithType:type]] flattenMap:^RACStream *(NSDictionary *model) {
        return [RACSignal return:[MTLJSONAdapter modelOfClass:[VMExchangeRateModel class] fromJSONDictionary:model error:nil]];
    }] catch:^RACSignal *(NSError *error) {
        return [VMExchangeFacade p_handleError:error];
    }];
}

#pragma mark - Private

+ (RACSignal *)p_handleError:(NSError *)error {
    return [RACSignal error:[NSError errorWithDomain:VMExchangeFacadeErrorDomain code:VMExchangeFacadeErrorCodeUndefined userInfo:nil]];
}

+ (NSDictionary *)p_configureParamsWithType:(VMExchangeValuesType)type {
    NSMutableDictionary *params = @{}.mutableCopy;

    switch (type) {
        case VMExchangeValuesTypeUSDtoRUR:
            params[@"base"] = @"USD";
            params[@"symbols"] = @"RUB";
            break;
        case VMExchangeValuesTypeRURtoUSD:
            params[@"base"] = @"RUB";
            params[@"symbols"] = @"USD";
            break;
        case VMExchangeValuesTypeEURtoRUR:
            params[@"base"] = @"EUR";
            params[@"symbols"] = @"RUB";
            break;
        case VMExchangeValuesTypeRURtoEUR:
            params[@"base"] = @"RUB";
            params[@"symbols"] = @"EUR";
            break;
        case VMExchangeValuesTypeUSDtoEUR:
            params[@"base"] = @"USD";
            params[@"symbols"] = @"EUR";
            break;
        case VMExchangeValuesTypeEURtoUSD:
            params[@"base"] = @"EUR";
            params[@"symbols"] = @"USD";
            break;
    }

    return params.copy;
}

@end
