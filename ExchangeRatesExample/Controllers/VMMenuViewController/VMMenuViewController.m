//
//  VMMenuViewController.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 20.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import <Objection/Objection.h>
#import "VMMenuViewController.h"
#import "VMMenuViewModel.h"
#import "VMMenuTableCell.h"
#import "VMMenuItem.h"

@interface VMMenuViewController () <UITableViewDataSource, UITableViewDelegate, VMMenuViewModelDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topTableConstraintForAnimation;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VMMenuViewModel *viewModel;
@end

@implementation VMMenuViewController
objection_requires(@"viewModel")

- (void)awakeFromObjection {
    [super awakeFromObjection];
    self.viewModel.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.topTableConstraintForAnimation.constant = self.view.frame.size.height - self.tableView.frame.size.height;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.tableView layoutIfNeeded];
                     } completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:self.backgroundImage];
    
    [[JSObjection defaultInjector] injectDependencies:self];
    
    [self.viewModel loadDataWithSelectItemTyple:self.selectType];
    
    self.topTableConstraintForAnimation.constant = self.view.frame.size.height;
    [self.tableView layoutIfNeeded];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)selectWithType:(VMExchangeValuesType)type {
    if ([self.delegate respondsToSelector:@selector(updateDataWithType:)]) {
        [self.delegate updateDataWithType:type];
    }
}

- (IBAction)closeButtonAction:(id)sender {
    [self closeModalView];
}

- (void)closeModalView {
    
    self.topTableConstraintForAnimation.constant = self.view.frame.size.height;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.tableView layoutIfNeeded];
                     } completion:^(BOOL finished){
                         [self dismissViewControllerAnimated:NO completion:nil];
                     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.sectionObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VMMenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    [cell configureCellWithItem:(VMMenuItem *)self.viewModel.sectionObjects[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel selectRowAtIndexPath:indexPath];
}

@end
