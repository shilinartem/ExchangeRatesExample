//
//  VMAPIAdapter.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const VMAPIAdapterErrorDomain;

typedef NS_ENUM(NSUInteger, VMAPIAdapterErrorCode) {
    VMAPIAdapterErrorCodeNone,
    VMAPIAdapterErrorCodeUndefined,
};

@interface VMAPIAdapter : NSObject

- (RACSignal *)todayRateWithParams:(NSDictionary *)params;
- (RACSignal *)yesterdayRateWithParams:(NSDictionary *)params;

@end
