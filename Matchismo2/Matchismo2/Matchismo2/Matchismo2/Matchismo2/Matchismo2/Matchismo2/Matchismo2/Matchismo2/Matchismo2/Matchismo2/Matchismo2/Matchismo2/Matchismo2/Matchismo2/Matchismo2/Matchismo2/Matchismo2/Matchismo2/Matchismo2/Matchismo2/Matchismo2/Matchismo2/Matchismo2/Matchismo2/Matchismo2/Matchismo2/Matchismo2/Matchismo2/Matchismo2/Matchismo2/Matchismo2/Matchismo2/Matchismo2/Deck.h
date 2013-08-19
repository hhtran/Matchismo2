//
//  Deck.h
//  Matchismo
//
//  Created by Henry Tran on 6/11/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
