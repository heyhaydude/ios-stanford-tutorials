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

@end

@implementation SetGame

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
    
    self.chosenCards = nil;
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen) {
            [self.chosenCards addObject:otherCard];
        }
    }
    
    int count = [(SetCard *)card match:self.chosenCards];
    
    if (count == 0) {
        // not enough cards were chosen yet so just chose the current card
        card.chosen = YES;
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
        // mark them as matched
        card.matched = YES;
        for (Card * otherCard in self.chosenCards) {
            otherCard.matched = YES;
        }
    }
}


@end
