//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by mobile on 3/17/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck : Deck

- (instancetype)init{
    self = [super init];
    
    if (self) {
    
        for (NSString *color in [SetCard validColors]) {
            for (NSString *number in [SetCard validNumbers]) {
                
                for (NSString *shading in [SetCard validShading]){
                    
                    for (NSString *shape in [SetCard validShapes]) {
                        
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.number = number;
                        card.shading = shading;
                        card.shape = shape;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
