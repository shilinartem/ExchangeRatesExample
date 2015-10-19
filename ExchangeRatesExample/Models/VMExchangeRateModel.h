//
//  VMExchangeRateModel.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 18.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface VMExchangeRateModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *fromCurrencyName;
@property (nonatomic, copy) NSString *toCurrencyName;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSNumber *exchangeValue;

@end
