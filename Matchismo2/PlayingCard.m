//
//  PlayingCard.m
//  Matchismo
//
//  Created by Henry Tran on 6/12/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♥", @"♦", @"♠", @"♣"];
    return validSuits;
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if(!rankStrings) rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void) setSuit: (NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}


- (int) match:(PlayingCard *)otherCard
{
    int score = 0;
    if ([otherCard.suit isEqualToString:self.suit]){
        score = 1;
    } else if (otherCard.rank == self.rank){
        score = 4;
    }
    return score;
}
@end
