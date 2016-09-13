
//
//  TPSSquareDropdown.m
//  Tipsi EE
//
//  Created by Sergey Yuzepovich on 14.06.15.
//  Copyright (c) 2015 RostDS. All rights reserved.
//

#import "TPSSquareDropdown.h"

@interface TPSSquareDropdown()
@property(nonatomic,weak) UIImageView *arrowView;
@end

@implementation TPSSquareDropdown
static const NSUInteger ARROW_W = 11;
static const NSUInteger ARROW_H = 6;

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = [UIColor colorWithRed:232.f/255 green:228.f/255 blue:223.f/255 alpha:1.f].CGColor;
        self.layer.cornerRadius = 0.f;
        
        NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
        NSString *resourceBundlePath = [currentBundle pathForResource:@"TPSDropDown" ofType:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithPath:resourceBundlePath];
        
        UIImage *arrow = [UIImage imageNamed:@"arrow" inBundle:resourceBundle compatibleWithTraitCollection:nil];
        [self initArrowWithImage:arrow];
    }
    return self;
}

-(void)initArrowWithImage:(UIImage*)arrowImage{
    [self.arrowView removeFromSuperview];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:arrowImage];
    [self addSubview:imgView];
    self.arrowView = imgView;
    [self updateArrowFrame];
}

-(void)updateArrowFrame{
    self.arrowView.frame = CGRectMake(CGRectGetWidth(self.frame)-ARROW_W*2,
                                      [self elementHeight]/2 - ARROW_H/2,
                                      ARROW_W,
                                      ARROW_H);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateArrowFrame];
}

-(CGFloat)customXoffsetAtIndex:(NSInteger)index {
    return self.offsetX ?: 23.f;
}

-(CGFloat)customYoffset {
    return 3;
}

-(UIColor *)labelColor:(NSUInteger)labelIdx {
    if (self.labelColor) {
        return self.labelColor;
    }
    return [UIColor blackColor];
}

-(UIFont *)labelFont:(NSUInteger)labelIdx{
    if (self.labelFont) {
        return self.labelFont;
    }
    else {
        if(labelIdx == 0){
            return [UIFont fontWithName:@"TheSerif-Regular" size:16];
        }
        return [UIFont fontWithName:@"TheSansRegular-Caps" size:16];
    }
}

-(void)setupWithElements:(NSArray *)rows {
    self.userInteractionEnabled = !(CGRectGetMinY(self.frame) < 0);
    [self updateArrowFrame];
    [super setupWithElements:rows];
}

-(NSUInteger)textAlignment{
    return NSTextAlignmentLeft;
}

@end
