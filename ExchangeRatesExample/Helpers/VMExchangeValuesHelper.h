//
//  VMExchangeValuesHelper.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 18.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VMExchangeValuesType) {
    VMExchangeValuesTypeUSDtoRUR,
    VMExchangeValuesTypeRURtoUSD,
    VMExchangeValuesTypeEURtoRUR,
    VMExchangeValuesTypeRURtoEUR,
    VMExchangeValuesTypeUSDtoEUR,
    VMExchangeValuesTypeEURtoUSD,
};

@interface VMExchangeValuesHelper : NSObject

+ (NSString *)nameWithType:(VMExchangeValuesType)type;

@end
