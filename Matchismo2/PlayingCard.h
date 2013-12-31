//
//  PlayingCard.h
//  Matchismo
//
//  Created by Henry Tran on 6/12/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
