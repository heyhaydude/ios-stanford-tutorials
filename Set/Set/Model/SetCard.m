//
//  PlayingCard.m
//  Matchismo
//
//  Created by mobile on 3/16/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *) validColors {
    return @[@"blue",@"green",@"red"];
}

+ (NSArray *) validShapes {
    return @[@"squiggle",@"diamond",@"oval"];
}

+ (NSArray *) validNumbers {
    return @[@"one",@"two",@"three"];
}

+ (NSArray *) validShading  {
    return @[@"full",@"empty",@"hash"];
}

- (NSString *) contents{
    return @"todo";
}

@end
