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

- (int)match:(NSArray *)otherCards{
    int score=0;

    // there have to be 3 cards selected to attempt a match
    if ([otherCards count]==2) {
        SetCard *otherCard1 = [otherCards firstObject];
        SetCard *otherCard2 = [otherCards objectAtIndex:1];
        
        //check each feature and check if they are all the same or all different
        //feature unique counts should be either one or three. never 2.
        NSSet *colorSet = [NSSet setWithObjects:self.color, otherCard1.color, otherCard2.color,nil];
        NSSet *shapeSet = [NSSet setWithObjects:self.shape, otherCard1.shape, otherCard2.shape,nil];
        NSSet *numberSet = [NSSet setWithObjects:self.number, otherCard1.number, otherCard2.number,nil];
        NSSet *shadingSet = [NSSet setWithObjects:self.shading, otherCard1.shading, otherCard2.shading,nil];
        
        NSArray *features = @[colorSet,shapeSet,numberSet,shadingSet];
        
        BOOL match = YES;
        for (NSSet *set in features) {
            if ([set count] == 2) {
                match = NO;
                break;
            }
        }
        
        if (match) {
            score = 10;
        }else{
            score = -20;
        }
    }
    return score;
}

- (NSString *) contents{
    return @"todo";
}

@end
