//
//  VMMenuViewController.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMExchangeValuesHelper.h"

@protocol VMMenuViewControllerDelegate <NSObject>

- (void)updateDataWithType:(VMExchangeValuesType)type;

@end

@interface VMMenuViewController : UIViewController

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, assign) VMExchangeValuesType selectType;
@property (nonatomic, weak) id <VMMenuViewControllerDelegate> delegate;

@end
