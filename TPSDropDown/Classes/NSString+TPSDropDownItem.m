//
//  NSString+TPSDropDownItem.m
//
//  Created by Dmytro Zavgorodniy on 12/7/16.
//  Copyright (c) 2016 Tipsi. All rights reserved.
//

#import "NSString+TPSDropDownItem.h"

@implementation NSString (TPSDropDownItem)

#pragma mark - TPSDropDownItem

- (NSString *)title {
    return self;
}

- (NSAttributedString *)attributedTitle {
    return nil;
}

- (NSString *)iconName {
    return nil;
}

@end
