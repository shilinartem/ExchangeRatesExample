//
//  VMHomeScreenViewModel.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMExchangeValuesHelper.h"

@protocol VMHomeScreenViewModelDelegate <NSObject>

- (void)showErrorWithMessage:(NSString *)message;
- (void)showMenuWithSelectType:(VMExchangeValuesType)type;

@end

@interface VMHomeScreenViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *ligamentName;
@property (nonatomic, copy, readonly) NSString *exchangeRate;
@property (nonatomic, copy, readonly) NSString *changesTitle;
@property (nonatomic, copy, readonly) NSString *updateTime;
@property (nonatomic, assign, readonly) BOOL changesRedColor;
@property (nonatomic, weak) id <VMHomeScreenViewModelDelegate> delegate;

- (void)loadDataWithType:(VMExchangeValuesType)type;
- (void)openMenu;

@end
