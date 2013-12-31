//
//  SetGameViewController.m
//  Matchismo2
//
//  Created by Henry Tran on 9/3/13.
//  Copyright (c) 2013 Henry Tran. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardGameViewController.h"
#import "SetCardDeck.h"
#import "SetMatchingGame.h"
#import "GameResult.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionDescriptionLabel;
@property (strong, nonatomic) SetMatchingGame *game;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation SetGameViewController

- (CardMatchingGame *) game
{
    if (!_game) _game = [[SetMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI
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
    //self.actionDescriptionLabel.text = self.game.actionDescription;
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    self.gameResult.score = self.game.score;
}

@end
