//
//  PlayingCard.h
//  Matchismo
//
//  Created by mobile on 3/16/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *shading;

+ (NSArray *)validColors;
+ (NSArray *)validShapes;
+ (NSArray *)validNumbers;
+ (NSArray *)validShading;

+ (int)match:(NSArray *)cards;

@end
