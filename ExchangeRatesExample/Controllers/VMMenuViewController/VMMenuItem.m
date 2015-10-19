//
//  VMMenuItem.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "VMMenuItem.h"

@interface VMMenuItem ()

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) BOOL isSelected;
@property (nonatomic, assign, readwrite) VMExchangeValuesType type;

@end

@implementation VMMenuItem

+ (instancetype)itemWithType:(VMExchangeValuesType)type selected:(BOOL)selected {
    VMMenuItem *item = [VMMenuItem new];
    item.title = [VMExchangeValuesHelper nameWithType:type];
    item.isSelected = selected;
    item.type = type;
    return item;
}

@end
