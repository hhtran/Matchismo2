//
//  Card.m
//  Matchismo
//
//  Created by Henry Tran on 6/11/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//


#import "Card.h"

@interface Card ()

@end


@implementation Card
- (int)match:(Card *)card
{
    int score = 0;
    
    if ([card.contents isEqualToString:self.contents]){
        score = 1;
    }
    
    return score;
}

//Checks matches for this card in an array of other cards. Returns the score.
- (int)matchWithArray:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards){
        score += [self match:card];
    }
    return score;
}

@end
