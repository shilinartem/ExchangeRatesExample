//
//  VMExchangeFacade.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const VMExchangeFacadeErrorDomain;

typedef NS_ENUM(NSUInteger, VMExchangeFacadeErrorCode) {
    VMExchangeFacadeErrorCodeNone,
    VMExchangeFacadeErrorCodeUndefined,
};

typedef NS_ENUM(NSUInteger, VMExchangeFacadeMonetaryCurrencyType) {
    VMExchangeFacadeMonetaryCurrencyTypeNone,
    VMExchangeFacadeMonetaryCurrencyTypeUSDtoRUR,
    VMExchangeFacadeMonetaryCurrencyTypeRURtoUSD,
    VMExchangeFacadeMonetaryCurrencyTypeEURtoRUR,
    VMExchangeFacadeMonetaryCurrencyTypeRURtoEUR,
    VMExchangeFacadeMonetaryCurrencyTypeUSDtoEUR,
    VMExchangeFacadeMonetaryCurrencyTypeEURtoUSD,
};

@interface VMExchangeFacade : NSObject

@end
