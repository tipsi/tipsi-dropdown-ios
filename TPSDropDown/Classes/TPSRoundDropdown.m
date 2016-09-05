
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
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
        
        NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
        NSURL *bundleURL = [currentBundle.resourceURL URLByAppendingPathComponent:@"TPSDropDown.bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
        
        UIImage *arrow = [UIImage imageNamed:@"down-arrow-white" inBundle:resourceBundle compatibleWithTraitCollection:nil];
        [self initArrowWithImage:arrow];
    }
    return self;
}

-(UIFont *)labelFont:(NSUInteger)labelIdx{
    if (self.labelFont) {
        return self.labelFont;
    }
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
}

-(UIColor *)labelColor:(NSUInteger)labelIdx{
    return [UIColor whiteColor];
}

-(CGFloat)customYoffset {
    return 1;
}

@end
