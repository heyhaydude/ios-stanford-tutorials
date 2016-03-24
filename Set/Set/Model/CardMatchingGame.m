//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by mobile on 3/18/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards;
@property (nonatomic,strong) PlayingCard *firstCard;
@property (nonatomic,strong) PlayingCard *secondCard;


@end

@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSString *)selectedCardDisplay{
    
    NSString *first = (self.firstCard) ? self.firstCard.contents: @"";
    
    NSString *second = (self.secondCard) ? self.secondCard.contents: @"";
    
    return [first stringByAppendingString:second];
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

- (PlayingCard *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? ((PlayingCard *)[self.cards objectAtIndex:index]) : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index{
    PlayingCard *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        card.chosen = YES;
        self.firstCard = nil;
        self.secondCard = (PlayingCard *)card;
            
        for (Card *otherCard in self.cards) {
            if (card != otherCard && otherCard.isChosen && !otherCard.isMatched) {
                int matchScore = [CardMatchingGame match:@[card,otherCard]];
                self.firstCard = (PlayingCard *) otherCard;
                if (matchScore) {
                    self.score  += matchScore * MATCH_BONUS;
                    otherCard.matched = YES;
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    otherCard.chosen = NO;
                    card.chosen = NO;
                }
                self.score -= COST_TO_CHOOSE;
                break;
            }
        }
    }
}

+ (int)match:(NSArray *)cards{
    int score = 0;
    
    if ([cards count]==2) {
        PlayingCard *card1 = cards[0];
        PlayingCard *card2 = cards[1];
        
        if (card1.rank == card2.rank) {
            score = 4;
        } else if ([card1.suit isEqualToString:card2.suit]){
            score = 1;
        }
    }
    
    return score;
}

@end
