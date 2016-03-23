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

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? [self.cards objectAtIndex:index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    self.firstCard = nil;
    self.secondCard = nil;
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }else{
            self.secondCard = (PlayingCard *)card;
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [CardMatchingGame match:@[card,otherCard]];
                    if (matchScore) {
                        self.score  += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                        self.firstCard = (PlayingCard *) otherCard;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

+ (int)match:(NSArray *)cards{
    int score = 0;
    
    if ([cards count]==2) {
        Card *card1 = cards[0];
        Card *card2 = cards[1];
        
        if ([card1.contents isEqualToString:card2.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
