//
//  GameResult.h
//  Matchismo2
//
//  Created by Henry Tran on 9/3/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

+ (NSArray *) allGameResults;


@end
