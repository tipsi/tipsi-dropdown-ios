
//
//  TPSSquareDropdown.m
//  Tipsi EE
//
//  Created by Sergey Yuzepovich on 14.06.15.
//  Copyright (c) 2015 RostDS. All rights reserved.
//

#import "TPSSquareDropdown.h"

@interface TPSSquareDropdown()
@end

@implementation TPSSquareDropdown

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self applyStyleJson:@"{\"style\":{\"borderWidth\":1,\"separatorHeight\":1,\"separatorColor\":\"0xFFFFFF\",\"fontName\":\"TheSerif-Regular\",\"fontSize\":16,\"textAlignment\":\"Left\",\"indicatorImageName\":\"arrow\",\"borderColor\":\"0xE8E4DF\"}}"];
    }
    return self;
}

@end
