//
//  SetMatchingCardGame.m
//  Matchismo2
//
//  Created by Henry Tran on 9/4/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "SetMatchingCardGame.h"

@interface SetMatchingCardGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end

@implementation SetMatchingCardGame
-(void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *actionWords = [[NSMutableArray alloc] init];
    [actionWords addObjectsFromArray:@[@"Flipped", card.contents, @"."]]; //Default description. Overwritten after checks
    
    if (!card.isUnplayable){
        if (!card.isFaceUp){
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable){ //If a valid card to check
                    [actionWords removeAllObjects]; //Clear all words from description
                    int matchScore = [card match:otherCard];
                    if (matchScore) { //If points given. Case: Is a match
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore;
                        [actionWords addObjectsFromArray:@[@"Matched", card.contents, @"and", otherCard.contents, @"for", [NSNumber numberWithInt:matchScore], @"points."]];
                    } else { //No points given. Penalty. Case: Is not a match
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        [actionWords addObjectsFromArray:@[card.contents, @"and", otherCard.contents, @"don't match!", @MISMATCH_PENALTY, @"point penalty."]];
                    }
                }
            }
            self.score -= FLIP_COST;
        } else { //Flipping card down. Case: Flip card back down.
            [actionWords addObjectsFromArray:@[@"Flipped", card.contents, @"back down."]];
        }
        card.faceUp = !card.isFaceUp;
    }
    
    self.actionDescription = [actionWords componentsJoinedByString:@" "];
}
@end
