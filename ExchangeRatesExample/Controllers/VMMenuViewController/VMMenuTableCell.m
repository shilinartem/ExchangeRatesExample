//
//  VMMenuTableCell.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "VMMenuTableCell.h"
#import "VMMenuItem.h"
#import "UIFont+VMFont.h"

@interface VMMenuTableCell ()

@property (strong, nonatomic) IBOutlet UILabel *title;

@end

@implementation VMMenuTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithItem:(VMMenuItem *)item {
    
    if (![item isKindOfClass:[VMMenuItem class]]) {
        return;
    }
    
    self.title.text = item.title;
    self.title.font = [UIFont menuFont];
    
    if (item.isSelected) {
        self.title.alpha = 1;
    } else {
        self.title.alpha = 0.7;
    }
}

@end
