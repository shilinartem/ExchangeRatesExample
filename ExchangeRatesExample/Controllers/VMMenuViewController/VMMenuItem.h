//
//  VMMenuItem.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMExchangeValuesHelper.h"

@interface VMMenuItem : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) BOOL isSelected;
@property (nonatomic, assign, readonly) VMExchangeValuesType type;

+ (instancetype)itemWithType:(VMExchangeValuesType)type selected:(BOOL)selected;

@end
