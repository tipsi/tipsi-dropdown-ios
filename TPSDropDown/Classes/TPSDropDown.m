//
//  TPSDropDown.m
//
//  Created by Dmytro Zavgorodniy on 12/7/16
//  Copyright (c) 2016 Tipsi. All rights reserved.
//

#import "TPSDropDown.h"

#import <TPSMKDropdownMenu/MKDropdownMenu.h>

static void * TPSDropDownBoundsChangeContext = &TPSDropDownBoundsChangeContext;

@interface TPSDropDown () <MKDropdownMenuDataSource, MKDropdownMenuDelegate>

@property (nonatomic, strong) MKDropdownMenu *dropdownMenu;

@end

#pragma mark - Custom content view
static CGFloat TPSDropDownContentViewOffset = 10.f;
static CGSize  TPSDropDownContentViewIconSize = {24.f, 24.f};

@interface TPSDropDownContentView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation TPSDropDownContentView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.iconImageView = [[UIImageView alloc] initWithFrame:
                              CGRectMake(TPSDropDownContentViewOffset,
                                         0.f,
                                         TPSDropDownContentViewIconSize.width,
                                         CGRectGetHeight(frame))
                              ];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconImageView];
        CGFloat titleXPosition = (CGRectGetMaxX(self.iconImageView.frame) + TPSDropDownContentViewOffset);
        self.titleLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(titleXPosition,
                                      0.f,
                                      (CGRectGetWidth(frame) - (titleXPosition + TPSDropDownContentViewOffset)),
                                      CGRectGetHeight(frame))
                           ];
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)updateWithAttributedText:(NSAttributedString*)attributedText iconName:(NSString*)iconName {
    self.iconImageView.image = [iconName length] ? [[UIImage imageNamed:iconName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] : nil;
    self.iconImageView.tintColor = self.tintColor;
    self.titleLabel.attributedText = attributedText;
}

@end

#pragma mark -

@implementation TPSDropDown

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self p_init];
    }
    return self;
}

- (void)p_init {
    _items = @[];
    _selectedItemIndex = NSNotFound;
    _delegate = nil;
    _cornerRadius = 0.f;
    _borderWidth = 0.f;
    _borderColor = [UIColor clearColor];
    _separatorWidth = 1.f;
    _separatorColor = [UIColor lightGrayColor];
    _indicatorImage = nil;
    _indicatorImageSelectionRotation = 0.f;
    _font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    _textAlignment = NSTextAlignmentLeft;
    _textColor = [UIColor blackColor];
    _showShadow = NO;
    
    [self p_addBoundsChangeObserver];
    
    _dropdownMenu = [self p_buildDropdownMenuWithFrame:self.bounds];
    [self addSubview:_dropdownMenu];
}

- (void)dealloc {
    [self p_removeBoundsChangeObserver];
}

#pragma mark - Properties

- (void)setItems:(NSArray <id <TPSDropDownItem>> *)items {
    _items = items;
    
    // reload data with new items
    [self p_reloadData];
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex {
    if (_selectedItemIndex != selectedItemIndex) {
        _selectedItemIndex = selectedItemIndex;
        
        // reload data with new selected index
        dispatch_async(dispatch_get_main_queue(), ^{
            [self p_reloadData];
        });
    }
}

#pragma mark - Properties (Appearance)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
    
    self.dropdownMenu.dropdownCornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    
    self.dropdownMenu.dropdownBorderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    self.dropdownMenu.dropdownBorderColor = borderColor;
}

- (void)setSeparatorWidth:(CGFloat)separatorWidth {
    _separatorWidth = separatorWidth;
    
    self.dropdownMenu.rowSeparatorWidth = separatorWidth;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    
    self.dropdownMenu.rowSeparatorColor = separatorColor;
}

- (void)setIndicatorImage:(UIImage *)indicatorImage {
    _indicatorImage = indicatorImage;
    
    self.dropdownMenu.disclosureIndicatorImage = indicatorImage ?: [[UIImage alloc] init];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    
    // reload data with new font
    [self p_reloadData];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.dropdownMenu.componentTextAlignment = textAlignment;
    self.dropdownMenu.rowTextAlignment = textAlignment;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    // reload data with new textColor
    [self p_reloadData];
}

#pragma mark - Open DropDown

- (void)openDropDown:(BOOL)animated {
    [self.dropdownMenu openComponent:0 animated:animated];
}

- (void)closeDropDown:(BOOL)animated {
    [self.dropdownMenu closeAllComponentsAnimated:animated];
}

#pragma mark - UIView

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
    self.dropdownMenu.backgroundColor = backgroundColor;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && context == TPSDropDownBoundsChangeContext) {
        // reload when bounds changed
        [self p_reloadData];
    }
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return [self.items count];
}

#pragma mark - MKDropdownMenuDelegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return CGRectGetHeight(self.bounds);
}

- (nullable NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component {
    id <TPSDropDownItem> selectedItem = [self p_selectedItem];
    
    if ([selectedItem attributedTitle]) {
        return [selectedItem attributedTitle];
    } else {
        NSString *string = [selectedItem title] ?: @"";
        
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        [attributes setValue:self.font forKey:NSFontAttributeName];
        [attributes setValue:self.textColor forKey:NSForegroundColorAttributeName];
        
        return [[NSAttributedString alloc] initWithString:string attributes:[attributes copy]];
    }
}

- (nullable NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    id <TPSDropDownItem> item = [self p_itemAtIndex:row];
    
    if ([item attributedTitle]) {
        return [item attributedTitle];
    } else {
        NSString *string = [item title] ?: @"";
        
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        [attributes setValue:self.font forKey:NSFontAttributeName];
        [attributes setValue:self.textColor forKey:NSForegroundColorAttributeName];
        
        return [[NSAttributedString alloc] initWithString:string attributes:[attributes copy]];
    }
}

- (UIView *)dropdownMenu:(MKDropdownMenu *)dropdownMenu viewForComponent:(NSInteger)component {
    id <TPSDropDownItem> selectedItem = [self p_selectedItem];
    if ([selectedItem iconName]) {
        TPSDropDownContentView *contentView = [[TPSDropDownContentView alloc] initWithFrame:dropdownMenu.bounds];
        contentView.tintColor = self.tintColor;
        [contentView updateWithAttributedText:[self dropdownMenu:dropdownMenu attributedTitleForComponent:component] iconName:[selectedItem iconName]];
        return contentView;
    }
    return nil;

}

- (UIView *)dropdownMenu:(MKDropdownMenu *)dropdownMenu viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    id <TPSDropDownItem> item = [self p_itemAtIndex:row];
    if ([item iconName]) {
        TPSDropDownContentView *contentView = (TPSDropDownContentView*)view;
        if (!contentView) {
            contentView = [[TPSDropDownContentView alloc] initWithFrame:dropdownMenu.bounds];
            contentView.tintColor = self.tintColor;
        }
        [contentView updateWithAttributedText:[self dropdownMenu:dropdownMenu attributedTitleForRow:row forComponent:component] iconName:[item iconName]];
        return contentView;
    }
    return nil;
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // When we using setter we get side effect: reload data, if selectedItemIndex was changed
    self.selectedItemIndex = row;
    
    // Additional side effect: close all components
    [dropdownMenu closeAllComponentsAnimated:YES];
    
    // Notify delegate
    if ([self.delegate respondsToSelector:@selector(dropDown:didSelectItemAtIndex:)]) {
        [self.delegate dropDown:self didSelectItemAtIndex:row];
    }
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didOpenComponent:(NSInteger)component {
    // Notify delegate
    if ([self.delegate respondsToSelector:@selector(dropDownDidOpen:)]) {
        [self.delegate dropDownDidOpen:self];
    }
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didCloseComponent:(NSInteger)component {
    // Notify delegate
    if ([self.delegate respondsToSelector:@selector(dropDownDidClose:)]) {
        [self.delegate dropDownDidClose:self];
    }
}

#pragma mark - Private

- (MKDropdownMenu *)p_buildDropdownMenuWithFrame:(CGRect)frame {
    MKDropdownMenu *dropdownMenu = [[MKDropdownMenu alloc] initWithFrame:frame];
    dropdownMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    dropdownMenu.dataSource = self;
    dropdownMenu.delegate = self;
    
    // Default appearance
    dropdownMenu.dropdownCornerRadius = _cornerRadius;
    dropdownMenu.dropdownBorderWidth = _borderWidth;
    dropdownMenu.dropdownBorderColor = _borderColor;
    dropdownMenu.rowSeparatorWidth = _separatorWidth;
    dropdownMenu.rowSeparatorColor = _separatorColor;
    dropdownMenu.disclosureIndicatorImage = _indicatorImage ?: [[UIImage alloc] init];
    dropdownMenu.disclosureIndicatorSelectionRotation = _indicatorImageSelectionRotation;
    dropdownMenu.componentTextAlignment = _textAlignment;
    dropdownMenu.rowTextAlignment = _textAlignment;
    dropdownMenu.dropdownDropsShadow = _showShadow;
    dropdownMenu.backgroundColor = self.backgroundColor;
    
    return dropdownMenu;
}

- (void)p_reloadData {
    [self.dropdownMenu reloadAllComponents];
}

- (nullable id <TPSDropDownItem>)p_selectedItem {
    return [self p_itemAtIndex:self.selectedItemIndex];
}

- (nullable id <TPSDropDownItem>)p_itemAtIndex:(NSInteger)index {
    id <TPSDropDownItem> item = nil;
    if (index >= 0 && index < self.items.count) {
        item = [self.items[index] conformsToProtocol:@protocol(TPSDropDownItem)] ? self.items[index] : nil;
    }
    return item;
}

- (void)p_addBoundsChangeObserver {
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:TPSDropDownBoundsChangeContext];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:TPSDropDownBoundsChangeContext];
}

- (void)p_removeBoundsChangeObserver {
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) context:TPSDropDownBoundsChangeContext];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) context:TPSDropDownBoundsChangeContext];
}

@end
