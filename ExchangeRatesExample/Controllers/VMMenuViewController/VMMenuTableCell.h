//
//  VMMenuTableCell.h
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VMMenuItem;

@interface VMMenuTableCell : UITableViewCell

- (void)configureCellWithItem:(VMMenuItem *)item;

@end
