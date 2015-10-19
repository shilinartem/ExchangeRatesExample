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
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        self.exchangeRate = [numberFormatter stringFromNumber:todayModel.exchangeValue];


        self.changesTitle = [self p_configurateProcentTitleWithTodayValue:todayModel.exchangeValue yesterdayValue:yesterdayModel.exchangeValue];

        NSDate *yesterdayDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        self.updateTime = [NSString stringWithFormat:@"%@ %@",@"Обновлено", [formatter stringFromDate:yesterdayDate]];
        
    } error:^(NSError *error) {
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(showErrorWithMessage:)]) {
            [self.delegate showErrorWithMessage:@"Ошибка соеденения с интернетом"];
        }
    }];

}

- (void)openMenu {
    if ([self.delegate respondsToSelector:@selector(showMenuWithSelectType:)]) {
        [self.delegate showMenuWithSelectType:self.type];
    }
}



#pragma mark - Private

- (NSString *)p_configurateProcentTitleWithTodayValue:(NSNumber *)today yesterdayValue:(NSNumber *)yesterday {
    
    CGFloat todayValue = today.floatValue;
    CGFloat yesterdayValue = yesterday.floatValue;
    
    if (todayValue > yesterdayValue) {
        return [NSString stringWithFormat:@"%f", [VMHomeScreenViewModel calculatePercentLargerNumber:todayValue fewer:yesterdayValue]];
    } else if (today.floatValue < yesterday.floatValue){
        self.changesRedColor = YES;
        return [NSString stringWithFormat:@"%f", [VMHomeScreenViewModel calculatePercentLargerNumber:yesterdayValue fewer:todayValue]];
    } else {
        return @"Курс не изменился";
    }
}

+ (CGFloat)calculatePercentLargerNumber:(CGFloat)larger fewer:(CGFloat)fewer {
    return ((larger - fewer) / ((larger - fewer) /2)) * 100;
}

@end
