//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Teddy Wyly on 8/8/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

#define SET_CARD_NAME @"SetCardGameName"

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
    return SET_CARD_NAME;
}

- (BOOL)isTwoCardGame
{
    return NO;
}

- (void)configureCardButton:(UIButton *)cardButton forCard:(Card *)card
{
    [cardButton setAttributedTitle:[self displayAttributedContentsFromString:card.contents] forState:UIControlStateNormal];
    [cardButton setBackgroundColor:cardButton.isSelected ? [UIColor lightGrayColor] : [UIColor whiteColor]];
    cardButton.alpha = cardButton.isEnabled ? 1.0 : 0.0;
    
}



- (NSAttributedString *)lastFlipText
{
    NSString *string = @"";
    NSMutableAttributedString *cardContents = [[NSMutableAttributedString alloc] init];
    if ([self.game.flipStatus.cardsInvolved count] == 1 || [self.game.flipStatus.cardsInvolved count] == 2) {
        Card *flippedCard = [self.game.flipStatus.cardsInvolved lastObject];
        if (flippedCard.isFaceUp) {
            string = [NSString stringWithFormat:@"Flipped up "];
            cardContents = [[self displayAttributedContentsFromString:flippedCard.contents] mutableCopy];
            [cardContents insertAttributedString:[[NSAttributedString alloc] initWithString:string] atIndex:0];
        }
    } else if ([self.game.flipStatus.cardsInvolved count] == 3) {
        Card *flippedCard = self.game.flipStatus.cardsInvolved[0];
        Card *secondCard = self.game.flipStatus.cardsInvolved[1];
        Card *thirdCard = self.game.flipStatus.cardsInvolved[2];
        if (self.game.flipStatus.successfulFlip) {
            NSString *partString = [NSString stringWithFormat:@" match for %i points!", self.game.flipStatus.pointChange];
            cardContents = [[self displayAttributedContentsFromString:flippedCard.contents] mutableCopy];
            [cardContents insertAttributedString:[self displayAttributedContentsFromString:secondCard.contents] atIndex:[cardContents length]];
            [cardContents insertAttributedString:[self displayAttributedContentsFromString:thirdCard.contents] atIndex:[cardContents length]];
            [cardContents insertAttributedString:[[NSAttributedString alloc] initWithString:partString] atIndex:[cardContents length]];
        } else {
            NSString *partString = [NSString stringWithFormat:@" don't match! %i point penalty!", self.game.flipStatus.pointChange];
            cardContents = [[self displayAttributedContentsFromString:flippedCard.contents] mutableCopy];
            [cardContents insertAttributedString:[self displayAttributedContentsFromString:secondCard.contents] atIndex:[cardContents length]];
            [cardContents insertAttributedString:[self displayAttributedContentsFromString:thirdCard.contents] atIndex:[cardContents length]];
            [cardContents insertAttributedString:[[NSAttributedString alloc] initWithString:partString] atIndex:[cardContents length]];
            
        }
    }
    return cardContents;
}

- (NSAttributedString *)displayAttributedContentsFromString:(NSString *)contents
{
    // Array of (number, color, shadeing, symbol
    NSArray *components = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *symbol = @"";
    if ([components[3] isEqualToString:@"diamond"]) {
        symbol = @"▲";
    } else if ([components[3] isEqualToString:@"squiggle"]) {
        symbol = @"■";
    } else if ([components[3] isEqualToString:@"oval"]) {
        symbol = @"●";
    }
    
    NSUInteger number = [components[0] integerValue];
    NSMutableString *mutableString = [@"" mutableCopy];
    
    for (NSUInteger count = 1; count <= number; count++) {
        mutableString = [[mutableString stringByAppendingString:symbol] mutableCopy];
    }
    
    
    
    float alpha = 1.0;
    if ([components[2] isEqualToString:@"solid"]) {
        alpha = 1.0;
    } else if ([components[2] isEqualToString:@"striped"]) {
        alpha = 0.3;
    } else if ([components[2] isEqualToString:@"open"]) {
        alpha = 0.0;
    }
    
    
    UIColor *color = nil;
    if ([components[1] isEqualToString:@"red"]) {
        color = [UIColor redColor];
    } else if ([components[1] isEqualToString:@"green"]) {
        color = [UIColor greenColor];
    } else if ([components[1] isEqualToString:@"purple"]) {
        color = [UIColor purpleColor];
    }
    
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@""];
    if (components) {
        attributedString = [[NSAttributedString alloc] initWithString:mutableString attributes:@{NSForegroundColorAttributeName : [color colorWithAlphaComponent:alpha], NSStrokeColorAttributeName : color, NSStrokeWidthAttributeName : @-5}];

    }
    
    return attributedString;
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.deck = [[SetCardDeck alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


@end
