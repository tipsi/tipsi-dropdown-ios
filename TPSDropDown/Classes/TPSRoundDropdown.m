
//
//  TPSRoundDropdown.m
//  tipsi
//
//  Created by Sergey Yuzepovich on 27.05.16.
//  Copyright © 2016 tipsi. All rights reserved.
//

#import "TPSRoundDropdown.h"

@implementation TPSRoundDropdown

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self applyStyleDictionary:@{@"cornerRadius":@(CGRectGetHeight(self.frame)/2),
                                     @"backgroundColor":@"0xAAAAAA",
                                     @"borderWidth":@(1),
                                     @"separatorHeight":@(1),
                                     @"fontName":@"ProximaNova-Semibold",
                                     @"fontSize":@(14),
                                     @"textColor":@"0xFFFFFF",
                                     @"separatorColor":@"0xAAAAAA",
                                     @"textAlignment":@"Left",
                                     @"indicatorImageName":@"down-arrow-white"}];
    }
    return self;
}

@end
