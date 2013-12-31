//
//  SetMatchingGame.m
//  Matchismo2
//
//  Created by Henry Tran on 9/4/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "SetMatchingGame.h"
#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

@interface SetMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end

@implementation SetMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *actionWords = [[NSMutableArray alloc] init];
    NSString *hello = card.contents;
    [actionWords addObjectsFromArray:@[@"Flipped", card.contents, @"."]]; //Default description. Overwritten after checks
    
    if (!card.isUnplayable){
        if (!card.isFaceUp){
            card.faceUp = !card.isFaceUp;
        }
    }
    
    self.actionDescription = [actionWords componentsJoinedByString:@" "];
}

@end
