//
//  ViewController.m
//  FingerPaint
//
//  Created by Auston Salvana on 7/10/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "ViewController.h"
#import "FPCustomView.h"

@interface ViewController ()

@property (nonatomic) FPCustomView *myCustomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.myCustomView = (FPCustomView*)self.whiteBoardView;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeColor:(id)sender {
    if (self.myCustomView.currentColor == 3) {
        self.myCustomView.currentColor = 0;
    }
    else{
        self.myCustomView.currentColor += 1;
    }
}

@end
