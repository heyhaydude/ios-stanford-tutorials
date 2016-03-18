//
//  Deck.h
//  Matchismo
//
//  Created by mobile on 3/16/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;
- (Card *) drawRandomCard;

@end
