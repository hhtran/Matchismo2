//
//  SetCard.h
//  Matchismo2
//
//  Created by Henry Tran on 9/4/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *colorName;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSInteger number;

+ (NSArray *)validShapes;
+ (NSArray *)validShadings;
+ (NSArray *)validColors; //Array of UIColors
+ (NSArray *)validColorNames;
+ (NSInteger)maxNumber;

@end
