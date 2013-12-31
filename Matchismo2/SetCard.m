//
//  SetCard.m
//  Matchismo2
//
//  Created by Henry Tran on 9/4/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

//Returns 1 if it is a match in shape, shading, or color.
//Returns 0 if not a match

- (NSString *) contents
{
    
    NSString *contents = [NSString stringWithFormat:@"%d %@ %@ %@", self.number, self.colorName, self.shading, self.shape];
    return contents;
}

+ (NSArray *)validShapes
{
    NSArray *shapes = @[@"▲", @"●", @"■"];
    return shapes;
}

+ (NSArray *) validShadings
{
    NSArray *shadings = @[@"solid", @"striped", @"open"];
    return shadings;
}

//Returns array of UIColors
+ (NSArray *) validColors
{
    NSArray *colors = @[[UIColor redColor], [UIColor purpleColor], [UIColor greenColor]];
    return colors;
}

+ (NSArray *) validColorNames
{
    NSArray *colors = @[@"red", @"purple", @"green"];
    return colors;
}

+ (NSInteger) maxNumber
{
    return 3;
}

//IMPLEMENT LATER

//Returns 1 if it matches number, color, shape, or shading
//Returns 0 if not a match
- (int) match:(SetCard *)card
{
    //If it is a match of some sort
    if (![[self matchType:card] isEqualToString:@"none"]){
        return 1;
    } else {
        return 0;
    }
}

- (int)matchWithArray:(NSArray *)otherCards
{
    NSMutableArray *matchedCardType = [[NSMutableArray alloc] init];
    for (SetCard *card in otherCards){
        NSString *matchType = [self matchType:card];
        if (![matchType isEqualToString:@"none"]){
            
        }
    }
    return 1;
}

- (NSString *)matchType:(SetCard *)card
{
    if (self.number == card.number){
        return @"number";
    } else if ([self.shading isEqualToString:card.shading]){
        return @"shading";
    } else if ([self.shape isEqualToString:card.shading]){
        return @"shape";
    } else if ([[self.color description] isEqualToString:[card.color description]]){
        return @"color";
    } else {
        return @"none";
    }
}

@end
