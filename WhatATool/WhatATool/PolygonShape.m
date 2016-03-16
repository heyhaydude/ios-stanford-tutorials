//
//  PolygonShape.m
//  WhatATool
//
//  Created by mobile on 3/15/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PolygonShape.h"

@interface PolygonShape()

//@property (nonatomic) int numberOfSides;
@property (nonatomic) int minimumNumberOfSides;
@property (nonatomic) int maximumNumberOfSides;
@property (nonatomic) float angleInDegrees;
@property (nonatomic) float angleInRadians;
@property (nonatomic, readonly) NSString *name;

@end


@implementation PolygonShape

-(void)minimumNumberOfSides:(int)sides{
    if (sides > 2) {
        _minimumNumberOfSides = sides;
    } else {
        _minimumNumberOfSides = 3;
    }
}

-(void)maximumNumberOfSides:(int)sides{
    if (sides > 12){
        _maximumNumberOfSides = 12;
    } else {
        _maximumNumberOfSides = sides;
    }
}


-(void)numberOfSides:(int)sides{
    if (sides >= [self minimumNumberOfSides] &&
        sides <= [self maximumNumberOfSides]) {
        _numberOfSides = sides;
    } else {
        NSLog(@"Sides don't meet constraints.");
    }
}

-(PolygonShape *)initWithNumberOfSides:(int)sides
      minimumNumberOfSides:(int)min
      maximumNumberOfSides:(int)max {
    
    self = [super init];
    if (!self) return nil;
    
    [self minimumNumberOfSides:min];
    [self maximumNumberOfSides:max];
    [self numberOfSides:sides];
//    self.minimumNumberOfSides = min;
//    self.maximumNumberOfSides = max;
//    self.numberOfSides = sides;
    return self;
}

@end