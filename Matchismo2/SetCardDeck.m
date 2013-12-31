//
//  SetCardDeck.m
//  Matchismo2
//
//  Created by Henry Tran on 9/4/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"
@implementation SetCardDeck
- (id) init
{
    self = [super init];
    for (NSString *shape in [SetCard validShapes]){
        for (int maxColorNum = 0; maxColorNum < [[SetCard validColors] count]; maxColorNum++){
            for (NSString *shading in [SetCard validShadings]){
                for (int num = 0; num < [SetCard maxNumber]; num++){
                    SetCard *card = [[SetCard alloc] init];
                    card.shape = shape;
                    card.color = [SetCard validColors] [maxColorNum];
                    card.colorName = [SetCard validColorNames][maxColorNum];
                    card.shading = shading;
                    card.number = num;
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
    return self;
}
@end
