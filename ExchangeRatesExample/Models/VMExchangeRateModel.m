//
//  VMExchangeRateModel.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 18.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "VMExchangeRateModel.h"

@implementation VMExchangeRateModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"fromCurrencyName" : @"base",
             @"date" : @"date",
             @"toCurrencyName" : @"rates",
             @"exchangeValue" : @"rates",
             };
}

+ (NSValueTransformer *)toCurrencyNameJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        if (![value isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        NSDictionary *rates = value;
        NSArray *values = [rates allKeys];
        *success = YES;
        return values.firstObject;
    }];
}

+ (NSValueTransformer *)exchangeValueJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        if (![value isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        NSDictionary *rates = value;
        NSArray *values = [rates allValues];
        *success = YES;
        return @([values.firstObject floatValue]);
    }];
}

@end
