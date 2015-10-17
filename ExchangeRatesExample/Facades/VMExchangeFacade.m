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

NSString *const VMExchangeFacadeErrorDomain = @"VMExchangeFacadeErrorDomain";

@interface VMExchangeFacade ()
@property (nonatomic, strong) VMAPIAdapter *apiAdapter;
@end

@implementation VMExchangeFacade
objection_register_singleton(VMExchangeFacade)
objection_requires(@"apiAdapter");

- (RACSignal *)todayRateWithType:(VMExchangeFacadeMonetaryCurrencyType)type {
    return [[self.apiAdapter todayRateWithParams:[VMExchangeFacade p_configureParamsWithType:type]] catch:^RACSignal *(NSError *error) {
        return [VMExchangeFacade p_handleError:error];
    }];
}

- (RACSignal *)yesterdayRateWithType:(VMExchangeFacadeMonetaryCurrencyType)type {
    return [[self.apiAdapter yesterdayRateWithParams:[VMExchangeFacade p_configureParamsWithType:type]] catch:^RACSignal *(NSError *error) {
        return [VMExchangeFacade p_handleError:error];
    }];
}

#pragma mark - Private

+ (RACSignal *)p_handleError:(NSError *)error {
    return [RACSignal error:[NSError errorWithDomain:VMExchangeFacadeErrorDomain code:VMExchangeFacadeErrorCodeUndefined userInfo:nil]];
}

+ (NSDictionary *)p_configureParamsWithType:(VMExchangeFacadeMonetaryCurrencyType)type {
    NSMutableDictionary *params = @{}.mutableCopy;
    switch (type) {
        case VMExchangeFacadeMonetaryCurrencyTypeNone:
            break;
        case VMExchangeFacadeMonetaryCurrencyTypeUSDtoRUR:
            params[@"base"] = @"USD";
            params[@"symbols"] = @"RUB";
            break;
        case VMExchangeFacadeMonetaryCurrencyTypeRURtoUSD:
            params[@"base"] = @"RUB";
            params[@"symbols"] = @"USD";
            break;
        case VMExchangeFacadeMonetaryCurrencyTypeEURtoRUR:
            params[@"base"] = @"EUR";
            params[@"symbols"] = @"RUB";
            break;
        case VMExchangeFacadeMonetaryCurrencyTypeRURtoEUR:
            params[@"base"] = @"RUB";
            params[@"symbols"] = @"EUR";
            break;
        case VMExchangeFacadeMonetaryCurrencyTypeUSDtoEUR:
            params[@"base"] = @"USD";
            params[@"symbols"] = @"EUR";
            break;
        case VMExchangeFacadeMonetaryCurrencyTypeEURtoUSD:
            params[@"base"] = @"EUR";
            params[@"symbols"] = @"USD";
            break;
    }
    
    return params.copy;
}

@end
