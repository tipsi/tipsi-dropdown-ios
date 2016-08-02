//
//  TPSSquareDropdown.h
//  Tipsi EE
//
//  Created by Sergey Yuzepovich on 14.06.15.
//  Copyright (c) 2015 RostDS. All rights reserved.
//

#import "TPSDropdownList.h"

@interface TPSSquareDropdown : TPSDropdownList
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, assign) CGFloat offsetX;
-(void)initArrowWithImage:(UIImage*)arrowImage;
@end
