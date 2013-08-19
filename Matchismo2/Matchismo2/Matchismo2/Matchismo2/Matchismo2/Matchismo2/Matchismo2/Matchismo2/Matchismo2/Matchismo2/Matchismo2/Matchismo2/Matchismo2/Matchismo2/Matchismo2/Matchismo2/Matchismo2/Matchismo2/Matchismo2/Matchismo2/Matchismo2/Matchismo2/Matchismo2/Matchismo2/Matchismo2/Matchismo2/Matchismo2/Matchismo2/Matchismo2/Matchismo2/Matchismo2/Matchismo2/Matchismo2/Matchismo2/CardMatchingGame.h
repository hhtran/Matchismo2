//
//  CardMatchingGame.h
//  Matchismo2
//
//  Created by Henry Tran on 8/14/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject
@property (nonatomic, readonly) int score;

- (NSMutableArray *)cards;
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index;

@end
