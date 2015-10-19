//
//  UIFont+VMFont.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 19.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "UIFont+VMFont.h"

@implementation UIFont (VMFont)


+ (UIFont *)ligamentFont {
    return [UIFont fontWithName:@"Lato-Bold" size:17.0];
}

+ (UIFont *)exchangeFont {
    return [UIFont fontWithName:@"Lato-Regular" size:80.0];
}

+ (UIFont *)changesFont {
    return [UIFont fontWithName:@"Lato-MediumItalic" size:17.0];
}

+ (UIFont *)updateFont {
    return [UIFont fontWithName:@"Lato-Black" size:11.0];
}

+ (UIFont *)menuFont {
    return [UIFont fontWithName:@"Lato-Regular" size:28.0];
}

@end
