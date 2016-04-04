//
//  BezierPathView.m
//  DropIt
//
//  Created by mobile on 4/4/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView


- (void)setPath:(UIBezierPath *)path{
    _path = path;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.path stroke];
}


@end
