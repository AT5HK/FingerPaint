//
//  FPCustomView.m
//  FingerPaint
//
//  Created by Auston Salvana on 7/10/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "FPCustomView.h"

@interface FPCustomView ()

@property (nonatomic) NSMutableArray *paths;
@property (nonatomic) UIBezierPath *currentPath;
@property (nonatomic) CGPoint startPoint;

@end

@implementation FPCustomView

- (id)initWithCoder:(NSCoder *)aDecoder // (1)
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO]; // (2)
        [self setBackgroundColor:[UIColor whiteColor]];
        self.paths = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] setStroke];
    for(UIBezierPath *path in self.paths) {
        [path stroke];
    }
//    NSLog(@"call draw rect");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInView:self];
    self.currentPath = [UIBezierPath bezierPath];
    [self.currentPath setLineWidth:5.0];
    [self.paths addObject:self.currentPath];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.currentPath removeAllPoints];
    [self.currentPath moveToPoint:self.startPoint];
    [self.currentPath addLineToPoint:p]; // (4)
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
