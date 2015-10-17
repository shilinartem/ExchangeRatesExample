//
//  VMAPI.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface VMAPI : NSObject

- (RACSignal *)getPath:(NSString *)path withParams:(NSDictionary *)params;
- (RACSignal *)postPath:(NSString *)path withParams:(NSDictionary *)params;

@end
