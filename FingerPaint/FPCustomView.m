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
@property (nonatomic) NSArray *arrayOfColors;
@property (nonatomic) NSMutableArray *bezierColorArray;
@property (nonatomic) UIColor *colorFromArray;
@property (nonatomic) NSTimer *timer;
@property (assign) float time;

@end

@implementation FPCustomView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.paths = [NSMutableArray array];
        self.bezierColorArray = [NSMutableArray array];
        self.arrayOfColors = @[
                               [UIColor grayColor],
                               [UIColor blueColor],
                               [UIColor yellowColor],
                               [UIColor redColor]
                               ];
    }
    return self;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)drawRect:(CGRect)rect {
    int startColor = 0;
    for(UIBezierPath *path in self.paths) {
        [self.bezierColorArray[startColor] setStroke];
        [path stroke];
        startColor++;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(incrementCounter) userInfo:nil repeats:YES];
    self.colorFromArray = (UIColor*)(self.arrayOfColors[self.currentColor]);
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInView:self];
    self.currentPath = [UIBezierPath bezierPath];
    [self.currentPath setLineWidth:5.0];
    [self.paths addObject:self.currentPath];
    [self.bezierColorArray addObject:self.colorFromArray];
     NSLog(@"currentColor Num: %d",self.currentColor);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    float velocity = [self velocityBetweenPoints:p startingLocation:self.startPoint];
    [self.currentPath setLineWidth:(velocity/10)];
    NSLog(@"speed: %f", velocity);
    [self.currentPath removeAllPoints];
    [self.currentPath moveToPoint:self.startPoint];
    [self.currentPath addLineToPoint:p];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.timer invalidate];
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

-(float)velocityBetweenPoints:(CGPoint)currentLocation startingLocation:(CGPoint)startLocation {
    CGFloat distance;
    CGFloat dx = currentLocation.x - startLocation.x;
    CGFloat dy = currentLocation.y - startLocation.y;
    distance = sqrt(dx*dx + dy*dy );
    return (float)distance/self.time;
}

#pragma mark - time methods

-(void)incrementCounter{
    self.time += 0.001f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
