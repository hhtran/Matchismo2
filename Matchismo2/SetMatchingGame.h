//
//  SetMatchingGame.h
//  Matchismo2
//
//  Created by Henry Tran on 9/4/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "CardMatchingGame.h"

@interface SetMatchingGame : CardMatchingGame
@property (nonatomic, readonly) int score;
@property (strong, nonatomic) NSString *actionDescription;

- (NSMutableArray *)cards;
- (void)flipCardAtIndex:(NSUInteger)index;
@end
