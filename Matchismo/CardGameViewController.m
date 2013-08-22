//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Teddy Wyly on 8/5/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic, readwrite) CardMatchingGame *game;

@property (strong, nonatomic) NSMutableArray *history; // of strings
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipLabel;

@end


@implementation CardGameViewController



- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:self.deck isTwoCardGame:[self isTwoCardGame]];
    return _game;
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] initWithGameName:self.gameName];
    return _gameResult;
}


- (Deck *)deck
{
    if (!_deck) _deck = [[Deck alloc] init];
    return _deck;
}


- (NSMutableArray *)history
{
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;

}


- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}


- (IBAction)dealButtonPressed:(UIButton *)sender
{
    self.game = nil;
    self.gameResult = nil;
    self.history = nil;
    self.flipCount = 0;
    [self updateUI];
}



- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    if ([self lastFlipText]) [self.history addObject:[self lastFlipText]];
    self.gameResult.score = self.game.score;
    [self updateUI];
    
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        [self configureCardButton:cardButton forCard:card];

    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastFlipLabel.attributedText = [self.history lastObject];
    
}

// Abstract Method

- (void)configureCardButton:(UIButton *)cardButton forCard:(Card *)card
{
    // set in subclass
    
}

// Abstract Class

- (BOOL)isTwoCardGame
{
    return NO;
}

// Abstract Method

- (NSAttributedString *)lastFlipText
{
    NSAttributedString *string = nil;
    return string;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}



@end
