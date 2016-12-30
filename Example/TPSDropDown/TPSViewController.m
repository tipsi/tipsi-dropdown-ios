//
//  TPSViewController.m
//  TPSDropDown
//
//  Created by Dmytro Zavgorodniy on 12/7/16.
//  Copyright (c) 2016 Tipsi. All rights reserved.
//

#import "TPSViewController.h"

#import <TPSDropDown/TPSDropDown.h>
#import <TPSDropDown/TPSRoundDropDown.h>
#import <TPSDropDown/TPSSquareDropDown.h>

@interface TPSDropDownPayItem : NSObject <TPSDropDownItem>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconName;
@end

@implementation TPSDropDownPayItem

- (instancetype)initWithTitle:(NSString*)title iconName:(NSString*)iconName {
    if (self = [super init]) {
        self.title = title;
        self.iconName = iconName;
    }
    return self;
}

- (NSAttributedString *)attributedTitle {
    return nil;
}

@end

@interface TPSViewController ()
@property (weak, nonatomic) IBOutlet TPSDropDown *dropDown;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *squareDropDown;
@property (weak, nonatomic) IBOutlet TPSRoundDropDown *roundDropDown;
@property (weak, nonatomic) IBOutlet TPSDropDown *payDropDown;
@end

@implementation TPSViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dropDown.items = @[@"One", @"Two", @"Three"];
    self.dropDown.selectedItemIndex = 0;

    self.squareDropDown.items = @[@"One", @"Two", @"Three"];
    self.squareDropDown.selectedItemIndex = 0;
    
    self.roundDropDown.items = @[@"One", @"Two", @"Three"];
    self.roundDropDown.selectedItemIndex = 0;
    
    TPSDropDownPayItem *visaItem = [[TPSDropDownPayItem alloc] initWithTitle:@"Visa" iconName:@"1"];
    TPSDropDownPayItem *masterItem = [[TPSDropDownPayItem alloc] initWithTitle:@"Master Card" iconName:@"2"];
    TPSDropDownPayItem *maestroItem = [[TPSDropDownPayItem alloc] initWithTitle:@"PayPal" iconName:@"3"];
    TPSDropDownPayItem *payPalItem = [[TPSDropDownPayItem alloc] initWithTitle:@"Maestro" iconName:@"4"];

    self.payDropDown.items = @[visaItem, masterItem, payPalItem, maestroItem];
    self.payDropDown.selectedItemIndex = 0;
}

#pragma mark - Open / Close 

- (void)openDropDown {
    [self.dropDown openDropDown:NO];
}

- (void)openPaymentDropDown {
    [self.payDropDown openDropDown:NO];
}

// Close dropdowns for Snapshot tests
- (void)closeAllDropDowns {
    [self.dropDown closeDropDown:NO];
    [self.squareDropDown closeDropDown:NO];
    [self.roundDropDown closeDropDown:NO];
    [self.payDropDown closeDropDown:NO];
}

@end
