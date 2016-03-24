//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by mobile on 3/18/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "SetGame.h"
#import "SetCard.h"
#import "SetDeck.h"

@interface SetGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards;
@property (nonatomic,strong) NSMutableArray *chosenCards;
@property (nonatomic,strong,readwrite) NSMutableArray *actionHistory;

@end

@implementation SetGame

- (void)setActionHistory:(NSMutableArray *)actionHistory{
    if (!_actionHistory) {
        _actionHistory = [[NSMutableArray alloc] init];
    }
}

- (NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

- (SetCard *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? [self.cards objectAtIndex:index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    card.chosen = YES;
    
    self.chosenCards = nil;
    self.chosenCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen) {
            [self.chosenCards addObject:otherCard];
        }
    }
    
    int count = [SetGame match:self.chosenCards];
    BOOL attemptedMatch = YES;
    BOOL successfulMatch = NO;
    if (count == 0) {
        // not enough cards were chosen yet so just chose the current card
        card.chosen = YES;
        attemptedMatch = NO;
    }else if (count < 0){
        // bad match, so dock points for being wrong
        self.score += count;
        //unchoose all the cards
        for (Card * otherCard in self.chosenCards) {
            otherCard.chosen = NO;
        }
    }else{
        // correct set! give points
        self.score += count;
        successfulMatch = YES;
        // mark them as matched
        for (Card * otherCard in self.chosenCards) {
            otherCard.matched = YES;
            otherCard.chosen = NO;
        }
    }
    
    // set the display text and history info
    NSMutableString *msg = [NSMutableString stringWithString:@"Selected "];
    for (int i = 0; i < [self.chosenCards count]; i++) {
        if (i == 0) {
            [msg appendFormat:@"%@",[[self.chosenCards objectAtIndex:i] contents]];
        } else {
            [msg appendFormat:@" and %@",[[self.chosenCards objectAtIndex:i] contents]];
        }
    }
    if (attemptedMatch) {
        if (successfulMatch) {
            [msg appendString:@" for a SUCCESSFUL MATCH!"];
        } else {
            [msg appendString:@" for a lame and unsuccessful match."];
        }
    }
    [self.actionHistory addObject:msg];
}

+ (int)match:(NSArray *)cards{
    int score=0;
    
    // there have to be 3 cards selected to attempt a match
    if ([cards count]==3) {
        SetCard *otherCard1 = [cards objectAtIndex:0];
        SetCard *otherCard2 = [cards objectAtIndex:1];
        SetCard *otherCard3 = [cards objectAtIndex:2];
        
        //check each feature and check if they are all the same or all different
        //feature unique counts should be either one or three. never 2.
        NSSet *colorSet = [NSSet setWithObjects:otherCard1.color, otherCard2.color, otherCard3.color, nil];
        NSSet *shapeSet = [NSSet setWithObjects:otherCard1.shape, otherCard2.shape, otherCard3.shape, nil];
        NSSet *numberSet = [NSSet setWithObjects:otherCard1.number, otherCard2.number, otherCard3.number, nil];
        NSSet *shadingSet = [NSSet setWithObjects:otherCard1.shading, otherCard2.shading, otherCard3.shading, nil];
        
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



@end
