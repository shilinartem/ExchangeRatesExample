//
//  VMHomeScreenViewController.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "VMHomeScreenViewController.h"
#import <Objection/Objection.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VMHomeScreenViewModel.h"
#import "UIFont+VMFont.h"
#import "VMMenuViewController.h"

static NSString * const kMenuSegueIdentifier = @"OpenMenu";

@interface VMHomeScreenViewController () <VMHomeScreenViewModelDelegate, VMMenuViewControllerDelegate>

@property (nonatomic, strong) VMHomeScreenViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UILabel *ligamentNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *exchangeRateLabel;
@property (nonatomic, weak) IBOutlet UILabel *changesTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *updateTimeLabel;
@end

@implementation VMHomeScreenViewController
objection_requires(@"viewModel")

- (void)awakeFromObjection {
    [super awakeFromObjection];
    self.viewModel.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[JSObjection defaultInjector] injectDependencies:self];
    
    [self.viewModel loadDataWithType:VMExchangeValuesTypeUSDtoRUR];
    
    RAC(self, ligamentNameLabel.text) = [RACObserve(self, viewModel.ligamentName) deliverOnMainThread];
    RAC(self, exchangeRateLabel.text) = [RACObserve(self, viewModel.exchangeRate) deliverOnMainThread];
    RAC(self, changesTitleLabel.text) = [RACObserve(self, viewModel.changesTitle) deliverOnMainThread];
    RAC(self, updateTimeLabel.text) = [RACObserve(self, viewModel.updateTime) deliverOnMainThread];
    
    RAC(self, changesTitleLabel.textColor) = [[RACObserve(self, viewModel.changesRedColor) deliverOnMainThread] flattenMap:^RACStream *(NSNumber *isRed) {
        if (!isRed.boolValue) {
            return [RACSignal return:[UIColor colorWithRed:126/255.0 green:211/255.0 blue:33/255.0 alpha:1]];
        } else {
            return [RACSignal return:[UIColor colorWithRed:206/255.0 green:13/255.0 blue:36/255.0 alpha:1]];
        }
    }];
    
    self.ligamentNameLabel.font = [UIFont ligamentFont];
    self.exchangeRateLabel.font = [UIFont exchangeFont];
    self.changesTitleLabel.font = [UIFont changesFont];
    self.updateTimeLabel.font = [UIFont updateFont];
}

- (void)showErrorWithMessage:(NSString *)message {
    NSLog(@"%@",message);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber *)sender {
    if ([segue.identifier isEqualToString:kMenuSegueIdentifier]) {
        VMMenuViewController *menu = [segue destinationViewController];
        menu.selectType = sender.integerValue;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
            UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
        else
            UIGraphicsBeginImageContext(self.view.bounds.size);
        
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        menu.backgroundImage = image;
        menu.delegate = self;
    }
}

#pragma mark - <VMHomeScreenViewModelDelegate>

- (void)showMenuWithSelectType:(VMExchangeValuesType)type {
    [self performSegueWithIdentifier:kMenuSegueIdentifier sender:@(type)];
}

- (IBAction)openMenuAction:(id)sender {
    [self.viewModel openMenu];
}

#pragma mark - <VMMenuViewControllerDelegate>

- (void)updateDataWithType:(VMExchangeValuesType)type {
    [self.viewModel loadDataWithType:type];
}

@end
