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

@interface TPSViewController ()

@property (weak, nonatomic) IBOutlet TPSDropDown *dropDown;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *squareDropDown;
@property (weak, nonatomic) IBOutlet TPSRoundDropDown *roundDropDown;

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
}

@end
