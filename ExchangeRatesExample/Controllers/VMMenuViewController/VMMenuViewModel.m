//
//  VMMenuViewModel.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "VMMenuViewModel.h"
#import "VMMenuItem.h"
#include <UIKit/UIKit.h>

@interface VMMenuViewModel ()

@property (nonatomic, strong, readwrite) NSArray *sectionObjects;
@property (nonatomic, assign) VMExchangeValuesType selectType;

@end

@implementation VMMenuViewModel

- (void)loadDataWithSelectItemTyple:(VMExchangeValuesType)type {
    self.selectType = type;
    
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < 6; i++) {
        VMExchangeValuesType itemType = i;
        [items addObject:[VMMenuItem itemWithType:itemType selected:itemType == type]];
    }
    
    self.sectionObjects = items.copy;
    
    if ([self.delegate respondsToSelector:@selector(reloadData)]) {
        [self.delegate reloadData];
    }
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath {
    VMExchangeValuesType itemType = indexPath.row;
    
    if (itemType != self.selectType) {
        if ([self.delegate respondsToSelector:@selector(selectWithType:)]) {
            [self.delegate selectWithType:itemType];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(closeModalView)]) {
        [self.delegate closeModalView];
    }
}

@end
