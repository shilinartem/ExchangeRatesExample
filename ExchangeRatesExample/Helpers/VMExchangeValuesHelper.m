//
//  VMExchangeValuesHelper.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 18.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "VMExchangeValuesHelper.h"

@implementation VMExchangeValuesHelper

+ (NSString *)nameWithType:(VMExchangeValuesType)type {
    switch (type) {
        case VMExchangeValuesTypeUSDtoRUR:
            return @"USD → RUR";
        case VMExchangeValuesTypeRURtoUSD:
            return @"RUR → USD";
        case VMExchangeValuesTypeEURtoRUR:
            return @"EUR → RUR";
        case VMExchangeValuesTypeRURtoEUR:
            return @"RUR → EUR";
        case VMExchangeValuesTypeUSDtoEUR:
            return @"USD → EUR";
        case VMExchangeValuesTypeEURtoUSD:
            return @"EUR → USD";
    }
    return @"";
}

@end
