//
//  VMHomeScreenViewModel.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Objection/Objection.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VMHomeScreenViewModel.h"
#import "VMExchangeFacade.h"
#import "VMExchangeRateModel.h"

@interface VMHomeScreenViewModel ()

@property (nonatomic, copy, readwrite) NSString *ligamentName;
@property (nonatomic, copy, readwrite) NSString *exchangeRate;
@property (nonatomic, copy, readwrite) NSString *changesTitle;
@property (nonatomic, copy, readwrite) NSString *updateTime;
@property (nonatomic, assign, readwrite) BOOL changesRedColor;
@property (nonatomic, strong) VMExchangeFacade *facade;
@property (nonatomic, assign) VMExchangeValuesType type;

@end

@implementation VMHomeScreenViewModel
objection_requires(@"facade")

- (void)loadDataWithType:(VMExchangeValuesType)type {
    self.type = type;
    self.ligamentName = [VMExchangeValuesHelper nameWithType:type];

    RACSignal *todaySignal = [self.facade todayRateWithType:type];
    RACSignal *yesterdaySignal = [self.facade yesterdayRateWithType:type];
    
    @weakify(self)
    [[[RACSignal combineLatest:@[todaySignal, yesterdaySignal]] deliverOnMainThread] subscribeNext:^(RACTuple *tuple) {
        RACTupleUnpack(VMExchangeRateModel *todayModel, VMExchangeRateModel *yesterdayModel) = tuple;
        @strongify(self)

        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        self.exchangeRate = [numberFormatter stringFromNumber:todayModel.exchangeValue];


        self.changesTitle = [self p_configurateProcentTitleWithTodayValue:todayModel.exchangeValue yesterdayValue:yesterdayModel.exchangeValue base:todayModel.fromCurrencyName];

        NSDate *yesterdayDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        self.updateTime = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"ОБНОВЛЕНО В", nil), [formatter stringFromDate:yesterdayDate]];
        
    } error:^(NSError *error) {
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(showErrorWithMessage:)]) {
            [self.delegate showErrorWithMessage:NSLocalizedString(@"Ошибка соеденения с интернетом", nil)];
        }
    }];

}

- (void)openMenu {
    if ([self.delegate respondsToSelector:@selector(showMenuWithSelectType:)]) {
        [self.delegate showMenuWithSelectType:self.type];
    }
}

#pragma mark - Private

- (NSString *)p_configurateProcentTitleWithTodayValue:(NSNumber *)today yesterdayValue:(NSNumber *)yesterday base:(NSString *)base{
    
    
    CGFloat todayValue = today.floatValue;
    CGFloat yesterdayValue = yesterday.floatValue;
    
    if (todayValue > yesterdayValue) {
        return [NSString stringWithFormat:@"%@ %@ %@ %f %@",NSLocalizedString(@"Со вчерашнего дня", nil), [VMHomeScreenViewModel baseFormatter:base], NSLocalizedString(@"вырос на", nil), [VMHomeScreenViewModel calculatePercentLargerNumber:todayValue fewer:yesterdayValue], NSLocalizedString(@"процента", nil)];
    } else if (today.floatValue < yesterday.floatValue){
        self.changesRedColor = YES;
        return [NSString stringWithFormat:@"%@ %@ %@ %f %@",NSLocalizedString(@"Со вчерашнего дня", nil), [VMHomeScreenViewModel baseFormatter:base], NSLocalizedString(@"упал на", nil), [VMHomeScreenViewModel calculatePercentLargerNumber:todayValue fewer:yesterdayValue], NSLocalizedString(@"процента", nil)];
    } else {
        return NSLocalizedString(@"Со вчерашнего дня курс не изменился", nil);
    }
}

+ (NSString *)baseFormatter:(NSString *)base {
    if ([base isEqualToString:@"RUB"]) {
        return NSLocalizedString(@"рубль", nil);
    } else if ([base isEqualToString:@"USD"]) {
        return NSLocalizedString(@"доллар", nil);
    } else if ([base isEqualToString:@"EUR"]) {
        return NSLocalizedString(@"евро", nil);
    } else {
        return NSLocalizedString(@"валюта", nil);
    }
}

+ (CGFloat)calculatePercentLargerNumber:(CGFloat)larger fewer:(CGFloat)fewer {
    return (larger - fewer) / (larger + fewer) / 2 * 100;
}

@end
