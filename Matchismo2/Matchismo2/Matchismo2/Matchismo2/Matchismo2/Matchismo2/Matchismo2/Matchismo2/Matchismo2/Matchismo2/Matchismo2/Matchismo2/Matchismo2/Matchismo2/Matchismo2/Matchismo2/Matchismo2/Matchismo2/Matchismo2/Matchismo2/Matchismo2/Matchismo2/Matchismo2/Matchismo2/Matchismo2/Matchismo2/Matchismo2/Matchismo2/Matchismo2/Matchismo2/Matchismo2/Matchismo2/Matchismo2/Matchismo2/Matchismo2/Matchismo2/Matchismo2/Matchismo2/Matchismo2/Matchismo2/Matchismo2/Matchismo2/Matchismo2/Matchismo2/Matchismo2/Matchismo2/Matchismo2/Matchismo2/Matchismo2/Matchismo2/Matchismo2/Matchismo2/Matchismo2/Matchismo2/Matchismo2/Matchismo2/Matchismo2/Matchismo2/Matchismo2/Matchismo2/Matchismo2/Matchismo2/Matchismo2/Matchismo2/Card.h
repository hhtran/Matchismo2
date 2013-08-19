//
//  Card.h
//  Matchismo
//
//  Created by Henry Tran on 6/11/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int)match:(Card *)card;
- (int)matchWithArray:(NSArray *)otherCards;




@end
