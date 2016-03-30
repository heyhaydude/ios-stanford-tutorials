//
//  ViewController.m
//  SuperCardd
//
//  Created by mobile on 3/30/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playingCardView.suit = @"♥️";
    self.playingCardView.rank = 13;
    
}

@end
