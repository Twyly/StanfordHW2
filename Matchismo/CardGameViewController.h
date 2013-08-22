//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Teddy Wyly on 8/5/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
@class Deck;
@class GameResult;

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic, readonly) CardMatchingGame *game; // getter shoul dbe overridden with is two card matching game
@property (strong, nonatomic) GameResult *gameResult; // getter should be overridden with type of card game name
@property (strong, nonatomic) NSString *gameName;

- (BOOL)isTwoCardGame; //abstract method

@end
