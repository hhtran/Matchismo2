//
//  CardGameViewController.m
//  Matchismo2
//
//  Created by Henry Tran on 8/14/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSwitch;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) GameResult *gameResult;
@property (nonatomic) bool isThreeCardGame;

@end

@implementation CardGameViewController

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:[[PlayingCardDeck alloc] init] isThreeCardMode:self.isThreeCardGame];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.actionDescriptionLabel.text = self.game.actionDescription;
    self.gameModeSwitch.enabled = self.flipCount == 0 ? YES : NO;
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    self.gameResult.score = self.game.score;
}

- (IBAction)startNewGame:(UIButton *)sender {
    [self resetCardMatchingGame];
    [self updateUI];
}

- (IBAction)changeGameMode:(id)sender {
    self.isThreeCardGame = self.gameModeSwitch.selectedSegmentIndex == 0 ? NO : YES;
    [self resetCardMatchingGame];
    [self updateUI];
}

- (void) resetCardMatchingGame
{
    self.game = nil;
    self.flipCount = 0;
    self.gameResult = nil;
}

@end
