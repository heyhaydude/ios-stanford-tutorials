//
//  PolygonShape.h
//  WhatATool
//
//  Created by mobile on 3/15/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

@interface PolygonShape : NSObject

@property (nonatomic) int numberOfSides;

-(PolygonShape *)initWithNumberOfSides:(int)sides minimumNumberOfSides:(int)min maximumNumberOfSides:(int)max;

@end
