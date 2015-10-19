//
//  VMMenuViewModel.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMExchangeValuesHelper.h"

@protocol VMMenuViewModelDelegate <NSObject>

- (void)selectWithType:(VMExchangeValuesType)type;
- (void)reloadData;
- (void)closeModalView;

@end

@interface VMMenuViewModel : NSObject

@property (nonatomic, weak) id <VMMenuViewModelDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray *sectionObjects;

- (void)loadDataWithSelectItemTyple:(VMExchangeValuesType)type;
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
