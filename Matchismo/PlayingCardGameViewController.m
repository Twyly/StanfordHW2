//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Teddy Wyly on 8/8/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

#define PLAYING_CARD_NAME @"PlayingCardGameName"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)gameName
{
    return PLAYING_CARD_NAME;
}


- (void)configureCardButton:(UIButton *)cardButton forCard:(Card *)card
{
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
    UIImage *cardback = [UIImage imageNamed:@"cardbackimage.jpeg"];
    [cardButton setBackgroundImage:(!cardButton.selected ? cardback : nil) forState:UIControlStateNormal];
    cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    
}

- (NSAttributedString *)lastFlipText
{
    NSString *string = @"";
    if ([self.game.flipStatus.cardsInvolved count] == 1) {
        Card *flippedCard = [self.game.flipStatus.cardsInvolved lastObject];
        if (flippedCard.isFaceUp) {
            string = [NSString stringWithFormat:@"Flipped up %@", flippedCard.contents];
        }
    } else if ([self.game.flipStatus.cardsInvolved count] == 2) {
        Card *flippedCard = self.game.flipStatus.cardsInvolved[0];
        Card *otherCard = self.game.flipStatus.cardsInvolved[1];
        if (self.game.flipStatus.successfulFlip) {
            string = [NSString stringWithFormat:@"%@ and %@ match for %i points!", flippedCard.contents, otherCard.contents, self.game.flipStatus.pointChange];
        } else {
            string = [NSString stringWithFormat:@"%@ and %@ don't match! %i point penalty!", flippedCard.contents, otherCard.contents, self.game.flipStatus.pointChange];
        }
    } else if ([self.game.flipStatus.cardsInvolved count] == 3) {
        Card *flippedCard = self.game.flipStatus.cardsInvolved[0];
        Card *secondCard = self.game.flipStatus.cardsInvolved[1];
        Card *thirdCard = self.game.flipStatus.cardsInvolved[2];
        if (self.game.flipStatus.successfulFlip) {
            string = [NSString stringWithFormat:@"%@, %@, and %@ match for %i points!", flippedCard.contents, secondCard.contents, thirdCard.contents, self.game.flipStatus.pointChange];
        } else {
            string = [NSString stringWithFormat:@"%@, %@, and %@ don't match! %i point penalty!", flippedCard.contents, secondCard.contents, thirdCard.contents, self.game.flipStatus.pointChange];
        }
    }
    return [[NSAttributedString alloc] initWithString:string];;
}

- (BOOL)isTwoCardGame
{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.deck = [[PlayingCardDeck alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
