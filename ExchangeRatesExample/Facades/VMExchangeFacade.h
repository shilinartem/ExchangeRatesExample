//
//  VMExchangeFacade.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMExchangeValuesHelper.h"

@class RACSignal;

extern NSString *const VMExchangeFacadeErrorDomain;

typedef NS_ENUM(NSUInteger, VMExchangeFacadeErrorCode) {
    VMExchangeFacadeErrorCodeNone,
    VMExchangeFacadeErrorCodeUndefined,
};

@interface VMExchangeFacade : NSObject

- (RACSignal *)todayRateWithType:(VMExchangeValuesType)type;
- (RACSignal *)yesterdayRateWithType:(VMExchangeValuesType)type;

@end
