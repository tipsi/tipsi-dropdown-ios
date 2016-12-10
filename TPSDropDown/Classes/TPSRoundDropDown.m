//
//  TPSRoundDropDown.m
//
//  Created by Dmytro Zavgorodniy on 12/7/16
//  Copyright (c) 2016 Tipsi. All rights reserved.
//

#import "TPSRoundDropDown.h"

static void * TPSRoundDropDownBoundsChangeContext = &TPSRoundDropDownBoundsChangeContext;

@implementation TPSRoundDropDown

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_addBoundsChangeObserver];
        [self p_setupAppearance];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self p_addBoundsChangeObserver];
        [self p_setupAppearance];
    }
    return self;
}

- (void)dealloc {
    [self p_removeBoundsChangeObserver];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && context == TPSRoundDropDownBoundsChangeContext) {
        // update corder radius when bounds changed
        self.cornerRadius = CGRectGetHeight(self.bounds)/2.f;
    }
}

#pragma mark - Private

- (void)p_setupAppearance {
    self.backgroundColor = [UIColor colorWithRed:170.f/255.f green:170.f/255.f blue:170.f/255.f alpha:1.f];
    self.borderWidth = 0.f;
    self.separatorWidth = 1.f;
    self.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14.f];
    self.textColor = [UIColor whiteColor];
    self.separatorColor = [UIColor colorWithRed:170.f/255.f green:170.f/255.f blue:170.f/255.f alpha:1.f];
    self.textAlignment = NSTextAlignmentLeft;
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"TPSDropDownBundle" ofType:@"bundle"]];
    UIImage *indicatorImage = [UIImage imageNamed:@"round_drop_down_indicator_image" inBundle:bundle compatibleWithTraitCollection:nil];
    self.indicatorImage = indicatorImage;
}

- (void)p_addBoundsChangeObserver {
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:TPSRoundDropDownBoundsChangeContext];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:TPSRoundDropDownBoundsChangeContext];
}

- (void)p_removeBoundsChangeObserver {
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) context:TPSRoundDropDownBoundsChangeContext];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) context:TPSRoundDropDownBoundsChangeContext];
}

@end
