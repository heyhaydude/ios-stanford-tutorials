//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by mobile on 3/18/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic,strong) NSString *selectedCardDisplay;

@end
