//
//  TPSSquareDropDown.m
//
//  Created by Dmytro Zavgorodniy on 12/7/16
//  Copyright (c) 2016 Tipsi. All rights reserved.
//

#import "TPSSquareDropDown.h"

@implementation TPSSquareDropDown

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupAppearance];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self p_setupAppearance];
    }
    return self;
}

#pragma mark - Private

- (void)p_setupAppearance {
    self.borderWidth = 1.f;
    self.separatorWidth = 1.f;
    self.separatorColor = [UIColor whiteColor];
    self.font = [UIFont fontWithName:@"TheSerif-Regular" size:16.f];
    self.textAlignment = NSTextAlignmentLeft;
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"TPSDropDownBundle" ofType:@"bundle"]];
    UIImage *indicatorImage = [UIImage imageNamed:@"square_drop_down_indicator_image" inBundle:bundle compatibleWithTraitCollection:nil];
    self.indicatorImage = indicatorImage;
    
    self.borderColor = [UIColor colorWithRed:232.f/255.f green:228.f/255.f blue:223.f/255.f alpha:1.f];
}

@end
