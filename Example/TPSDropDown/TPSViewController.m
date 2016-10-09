//
//  TPSViewController.m
//  TPSDropDown
//
//  Created by Sergey Yuzepovich on 08/01/2016.
//  Copyright (c) 2016 Sergey Yuzepovich. All rights reserved.
//

#import "TPSViewController.h"
#import "TPSDropdownList.h"
#import "TPSSquareDropdown.h"
#import "TPSRoundDropdown.h"

@interface TPSViewController ()
@property (weak, nonatomic) IBOutlet TPSDropdownList *simpleDropdown;
@property (weak, nonatomic) IBOutlet TPSSquareDropdown *squareDropdown;
@property (weak, nonatomic) IBOutlet TPSRoundDropdown *roundDropdown;
@end

@implementation TPSViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.simpleDropdown setupWithElements:@[@"One", @"Two", @"Three"]];
    [self.squareDropdown setupWithElements:@[@"One", @"Two", @"Three"]];
    [self.roundDropdown setupWithElements:@[@"One", @"Two", @"Three"]];
    
    [self.simpleDropdown applyStyleJson:@"{\"style\":{\"backgroundColor\":\"0x00ffff\",\"borderWidth\":3,\"borderColor\":\"0xffff00\",\"cornerRadius\":3,\"separatorHeight\":1,\"separatorColor\":\"0xAA00AA\",\"fontName\":\"Arial\",\"fontSize\":18,\"textColor\":\"0xCCCCCC\",\"textAlignment\":\"Center\",\"indicatorImageName\":\"arrow\"}}"];
}

@end
