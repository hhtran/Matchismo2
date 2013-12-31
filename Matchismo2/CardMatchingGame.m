//
//  CardMatchingGame.m
//  Matchismo2
//
//  Created by Henry Tran on 8/14/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *cardsFlipped;

@end

@implementation CardMatchingGame

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

-(NSMutableArray *) cardsFlipped
{
    if (!_cardsFlipped) _cardsFlipped = [[NSMutableArray alloc] init];
    return _cardsFlipped;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//Designated Initializer for the CardMatchingGame
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck isThreeCardMode:(bool)gameModeIsThree
{
    self = [super init];
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    self.cardsToMatch = gameModeIsThree ? 3 : 2;
    return self;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [self initWithCardCount:count usingDeck:deck isThreeCardMode:NO];
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

/*- (void)flipCardAtIndex:(NSUInteger)index
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
}*/

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *actionWords = [[NSMutableArray alloc] init];
    [actionWords addObjectsFromArray:@[@"Flipped", card.contents, @"."]]; //Default description. Overwritten after checks
    
    if (!card.isUnplayable){
        if (!card.isFaceUp){
            //If checking for match
            [self.cardsFlipped addObject:card];
            if([self.cardsFlipped count] == self.cardsToMatch){
                [actionWords removeAllObjects]; //Clear all words from description
                int matchScore = [self findMatchScore:self.cardsFlipped];
                if (matchScore == 0){ //Not a match. 
                    [self flipTheseCardsFaceDown:self.cardsFlipped];
                    self.score -= MISMATCH_PENALTY;
                    [actionWords addObjectsFromArray:@[[self getStringOfCardNames:self.cardsFlipped], @"don't match!", @MISMATCH_PENALTY, @"point penalty."]];
                    [self.cardsFlipped removeAllObjects];
                    [self.cardsFlipped addObject:card];
                } else {
                    [self makeTheseCardsUnplayable:self.cardsFlipped];
                    self.score += matchScore * MATCH_BONUS;
                    [actionWords addObjectsFromArray:@[[self getStringOfCardNames:self.cardsFlipped], @"for", [NSNumber numberWithInt:matchScore*MATCH_BONUS], @"points."]];
                    [self.cardsFlipped removeAllObjects];
                }
            }
            self.score -= FLIP_COST;
        } else { //Flipping card down. Case: Flip card back down.
            [actionWords removeAllObjects];
            [self.cardsFlipped removeObject:card];
            [actionWords addObjectsFromArray:@[@"Flipped", card.contents, @"back down."]];
        }
        card.faceUp = !card.isFaceUp;
    }
    
    self.actionDescription = [actionWords componentsJoinedByString:@" "];
}

-(NSString *) getStringOfCardNames: (NSArray *)cards
{
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    for (Card *card in cards){
        [strings addObject: card.contents];
    }
    return [strings componentsJoinedByString:@" and "];
}

-(void) flipTheseCardsFaceDown: (NSArray *)faceupCards
{
    for (Card *card in faceupCards){
        card.faceUp = NO;
    }
}

-(void) makeTheseCardsUnplayable: (NSArray *)cards
{
    for (Card *card in cards){
        card.unplayable = YES;
    }
}

//Find if every card matches every other card. Returns matchScore of what kind of match it is
//Else returns 0
- (int) findMatchScore: (NSArray *)cards
{
    int matchPoints = 0; //Not number of matches. Twice that, since there is double counting
    for (Card *card in cards){
        for (Card *otherCard in cards){
            if (card != otherCard){
                int match = [card match:otherCard];
                matchPoints+=match;
            }
        }
    }
    switch (matchPoints){
        case 0:
            return 0;
            break;
        default:
            return matchPoints;
    }
}

@end
