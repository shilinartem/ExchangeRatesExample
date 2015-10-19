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

@interface VMHomeScreenViewController ()<VMHomeScreenViewModelDelegate>

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
    RAC(self, updateTimeLabel.text) = [[RACObserve(self, viewModel.updateTime) deliverOnMainThread] logAll];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
