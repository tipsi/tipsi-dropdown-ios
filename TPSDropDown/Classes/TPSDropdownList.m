//
//  TPSDropdownList.m
//  Tipsi EE
//
//  Created by Sergey Yuzepovich on 06.04.15.
//  Copyright (c) 2015 RostDS. All rights reserved.
//

#import "TPSDropdownList.h"
#import <pop/POP.h>

@interface TPSDropdownList()<UIGestureRecognizerDelegate>
@property(nonatomic) BOOL expanded;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic) CGFloat initialHeight;
@property(nonatomic,strong) UIGestureRecognizer *dismissGesture;
@property(nonatomic,strong) UIGestureRecognizer *scrollGesture;
@property(nonatomic,strong) POPAnimatableProperty *animatebleOffset;
@property(nonatomic) CGPoint offsetProperty;
@property(nonatomic) BOOL scrollInProgress;
@property(nonatomic) id firstElement;
@property(nonatomic) id selectedElement;
@property(nonatomic) BOOL collapsing;
@property(nonatomic) dispatch_once_t onceToken;
@property(nonatomic) CGFloat initialY;
@property(readwrite, assign, nonatomic) NSUInteger selectedIndex;
@end

#define MAX_HEIGHT (CGRectGetHeight([UIScreen mainScreen].bounds)-CGRectGetMinY([self convertRect:self.bounds toView:nil])-20)
#define DECELERATE_ANIMATION_KEY @"decelerate"
static const NSUInteger LABEL_TAG = 1111;

@implementation TPSDropdownList

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.initialHeight = CGRectGetHeight(self.frame);
    self.showCheckmark = NO;
    self.animatebleOffset =
    [POPAnimatableProperty propertyWithName:@"offset" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(TPSDropdownList *obj, CGFloat values[]) {
            values[0] = [obj offsetProperty].x;
            values[1] = [obj offsetProperty].y;
        };
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            [obj setOffsetProperty:CGPointMake(values[0],values[1])];
        };
    }];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
  [super setUserInteractionEnabled:userInteractionEnabled];
  self.dismissGesture.enabled = userInteractionEnabled;
  self.scrollGesture.enabled = userInteractionEnabled;
}

- (void)didMoveToWindow {
#warning This code shuold be replaced with better implementation
  dispatch_once(&_onceToken, ^{
    [self setupGestures];
  });
}

-(void)setupGestures{
#warning This code shuold be replaced with better implementation
    UIView *masterView = self.superview;  // TODO : Make this better!!!
    while (CGRectGetHeight(masterView.frame) < CGRectGetHeight([UIScreen mainScreen].bounds) - 100.f) {
      masterView = masterView.superview;
    }
  
    UILongPressGestureRecognizer *anyGest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(hide:)];
    anyGest.allowableMovement = 1000;
    anyGest.minimumPressDuration = 0;
    [masterView addGestureRecognizer:anyGest];
    anyGest.delegate = self;
    self.dismissGesture = anyGest;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(scroll:)];
    [masterView addGestureRecognizer:pan];
    pan.delegate = self;
    self.scrollGesture = pan;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
  return self.expanded || [self pointInside:[gestureRecognizer locationInView:self] withEvent:nil];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if(gestureRecognizer == self.scrollGesture){
        return YES;
    }
    return NO;
}

-(void)scroll:(UIPanGestureRecognizer*)pan{
    if(!self.expanded){
        return;
    }
    if(pan.state == UIGestureRecognizerStateBegan) {
        self.initialY = [pan locationInView:self].y;
        self.scrollInProgress = YES;
        [self cancelDecay];
    }
    if(pan.state == UIGestureRecognizerStateChanged){
        CGPoint loc = [pan locationInView:self];
        if([self pointInside:loc withEvent:nil]){
            float deltaY = [pan locationInView:self].y - self.initialY;
            CGRect b = self.bounds;
            b.origin.y -= deltaY;
            [self setOffsetProperty:b.origin];
            self.initialY = [pan locationInView:self].y;
        }
    }
    if(pan.state == UIGestureRecognizerStateEnded){
        if(fabs([pan velocityInView:self].y) > 1){//deccelerate
            POPDecayAnimation *decayAnimation = [POPDecayAnimation animation];
            decayAnimation.property = self.animatebleOffset;
            decayAnimation.velocity = [NSValue valueWithCGPoint: CGPointMake(0, -[pan velocityInView:self].y)];
            [self pop_addAnimation:decayAnimation forKey:DECELERATE_ANIMATION_KEY];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollInProgress = NO;
        });
    }
}

-(void)cancelDecay{
    [self pop_removeAllAnimations];
}

-(void)hide:(UIGestureRecognizer*)gesture{
    if(gesture.state == UIGestureRecognizerStateEnded){
        if(self.expanded && [self pointInside:[gesture locationInView:self] withEvent:nil]){
            [self cancelDecay];
            [self pickElementAtPoint:[gesture locationInView:self]];
        }
        [self toggleState];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)resetFirstElement {
    self.firstElement = nil;
}

-(void)buildWithElements:(NSArray *)rows {
  self.data = [NSMutableArray arrayWithArray: rows];
  if(self.firstElement == nil){
    self.firstElement = self.data.firstObject;
  }
  
  for (UIView* v in self.subviews) {
    if(v.tag == LABEL_TAG){
      [v removeFromSuperview];
    }
  }
    
    NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
    NSString *resourceBundlePath = [currentBundle pathForResource:@"TPSDropDown" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:resourceBundlePath];
    
  for (int i = 0; i < self.data.count; i++) {
      
      UIImageView *iconImageView = iconImageView = [self iconImageViewAtIndex:i];
      
      if (iconImageView) {
          iconImageView.tag = LABEL_TAG;
          [self addSubview:iconImageView];
      }
      
    CGRect lblRect = CGRectMake([self customXoffsetAtIndex:i], i * [self elementHeight] + [self customYoffset], CGRectGetWidth(self.frame)-20, [self elementHeight]);
    UILabel *lbl = [[UILabel alloc]initWithFrame:lblRect];
    [lbl setFont:[self labelFont:i]];
    [lbl setTextColor:[self labelColor:i]];
    lbl.tag = LABEL_TAG;
    if ([self.data[i] isKindOfClass:[NSAttributedString class]]) {
      lbl.attributedText = self.data[i];
      lbl.numberOfLines = 2;
    }
    else {
      lbl.text = self.data[i];
    }
    lbl.textAlignment = [self textAlignment];
    [self addSubview:lbl];
    
    if (self.showCheckmark && [self.selectedElement isEqual:self.data[i]] && i != 0) {
      UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_checkmark_light" inBundle:resourceBundle compatibleWithTraitCollection:nil]];
      imageView.frame = (CGRect){CGPointMake(CGRectGetWidth(lblRect) - CGRectGetWidth(imageView.frame) - 20.f, (CGRectGetHeight(lblRect) - CGRectGetHeight(imageView.frame)) / 2.f), imageView.frame.size};
      [lbl addSubview:imageView];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, (i+1)*[self elementHeight], CGRectGetWidth(self.frame), 1)];
    line.tag = LABEL_TAG;
    [line setBackgroundColor:[UIColor lightGrayColor]];
    line.alpha = 0.5;
    [self addSubview:line];
  }

}

-(void)setupWithElements:(NSArray*)rows {
  self.selectedElement = nil;
  [self buildWithElements:rows];
}

- (UIImageView*)iconImageViewAtIndex:(NSInteger)index {
    return nil;
}

-(CGFloat)customXoffsetAtIndex:(NSInteger)index {
    return 10;
}
-(CGFloat)customYoffset {
    return 0;
}

-(NSUInteger)textAlignment{
    return NSTextAlignmentCenter;
}

-(NSUInteger)elementHeight{
    return self.initialHeight;
}

-(UIFont*)labelFont:(NSUInteger)labelIdx{
    return [UIFont systemFontOfSize:15];
}

-(UIColor *)labelColor:(NSUInteger)labelIdx{
    return [UIColor blackColor];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!self.expanded){
        [self toggleState];
        [self flashElement:0];
    }
    else{
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self pickElementAtPoint:point];
        [self toggleState];
    }

}

-(void)bringElementAtIndex:(NSUInteger)srcIdx toIndex:(NSUInteger)dstIdx{
    [self.data exchangeObjectAtIndex:srcIdx withObjectAtIndex:dstIdx];
    [self buildWithElements:self.data];
}
-(void)bringElementAtIndexToTitle:(NSUInteger)index{
    [self bringElementAtIndex:index toIndex:0];
}

-(void)pickElementAtIndex:(NSUInteger)index{
    self.selectedIndex = index;
    
  if (!self.showCheckmark || !(self.selectedElement && [self.selectedElement isEqual:self.data[index]])) {
        self.selectedElement = self.data[index];
        [self flashElement:index];
        [self bringElementAtIndexToTitle:index];
    }
    else {
      self.selectedElement = nil;
      [self flashElement:index];
      [self buildWithElements:self.data];
      index = 0;
    }
  
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(dropdown:didSelectItemAtIndex:withValue:)]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate dropdown:self didSelectItemAtIndex:index withValue:self.data[0]];
        });
    }
}

- (void)selectElementWithName:(id)name {
    if ([self.getCurrentItem isEqual:name]) {
        return;
    }
    
    id del = self.delegate;
    self.delegate = nil;
    NSInteger idx = [self.data indexOfObject:name];
    if (idx == NSNotFound) {
        idx = 0;
    }
    [self pickElementAtIndex:idx];
    self.delegate = del;
}

-(void)pickElementAtPoint:(CGPoint)point{
    NSUInteger idx = point.y / [self elementHeight];
    NSLog(@"Element index:%lu",(unsigned long)idx);
    if(idx < self.data.count){
        [self pickElementAtIndex:idx];
    }
}

-(void)flashElement:(NSUInteger)index{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                        index * self.initialHeight,
                                                        CGRectGetWidth(self.frame),
                                                        self.initialHeight)];
    [v setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:v];
    
    [UIView animateWithDuration:0.3 animations:^{
        v.alpha = 0;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
}

- (void)closeDropdown {
    if (self.expanded) {
        id delegate = self.delegate;
        self.delegate = nil;
        [self toggleState];
        self.delegate = delegate;
    }
}

-(void)toggleState{
    CGFloat maximumHeight = (self.maximumHeight > 1 ? MIN(self.maximumHeight, MAX_HEIGHT) : MAX_HEIGHT);
    CGFloat HEIGHT_DELTA_TMP = MIN(self.data.count * [self elementHeight], maximumHeight);
    CGFloat duration = 0.2;
    
    CGRect b = self.bounds;
    b.origin = CGPointZero;
    self.bounds = b;
    
    //find height constraint and change it
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeHeight) {
            if(self.expanded){
                c.constant = self.initialHeight;
            }
            else{
                c.constant = HEIGHT_DELTA_TMP;
                [self bringElementAtIndexToTitle:[self.data indexOfObject:self.firstElement]];
            }

            if ([self.delegate respondsToSelector:@selector(dropdown:willChangeExpandedState:)]) {
                [self.delegate dropdown:self willChangeExpandedState:!self.expanded];
            }
            [UIView animateWithDuration:duration animations:^{
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.expanded = !self.expanded;
            }];
            return;
        }
    }
    
    //if no height constraint present then change frame.height
    self.translatesAutoresizingMaskIntoConstraints = YES;
    if (!self.expanded) {
        [self bringElementAtIndexToTitle:[self.data indexOfObject:self.firstElement]];
    }
    else {
        [self cancelDecay];
        NSInteger selectedIdx = NSNotFound;
        if (self.selectedElement && ((selectedIdx = [self.data indexOfObject:self.selectedElement]) != NSNotFound)) {
            [self bringElementAtIndexToTitle:selectedIdx];
        }
        else {
            [self setOffsetProperty:CGPointMake(CGRectGetMinX(self.bounds), 0.f)];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(dropdown:willChangeExpandedState:)]) {
        [self.delegate dropdown:self willChangeExpandedState:!self.expanded];
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(CGRectGetMinX(self.frame),
                                CGRectGetMinY(self.frame),
                                CGRectGetWidth(self.frame),
                                self.expanded ? self.initialHeight : HEIGHT_DELTA_TMP);
        
    } completion:^(BOOL finished) {
        self.expanded = !self.expanded;
    }];
}

-(NSString*)getCurrentItem{
    return self.data[0];
}

-(void)dealloc{
    [self.dismissGesture.view removeGestureRecognizer:self.dismissGesture];
    [self.scrollGesture.view removeGestureRecognizer:self.scrollGesture];
}

-(void)setOffsetProperty:(CGPoint)offsetProperty{
    CGRect b = self.bounds;
    b.origin = offsetProperty;
    if(b.origin.y < 0){
        b.origin.y = 0;
    }
    NSUInteger contentH = self.data.count * [self elementHeight];
    int delta = contentH - b.size.height;
    if(b.origin.y > delta){
        b.origin.y = delta;
    }
    self.bounds = b;
}

-(CGPoint)offsetProperty{
    return self.bounds.origin;
}


@end
