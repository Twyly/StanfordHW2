//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Teddy Wyly on 8/9/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameResult.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *playingCardSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *setCardSegmentedControl;

@end

#define PLAYING_CARD_DIFFICULTY_KEY @"PlayingCardDifficultyKey"
#define SET_CARD_DIFFICULTY_KEY @"SetCardDifficultyKey"

@implementation SettingsViewController

- (IBAction)deleteScoresButton:(UIButton *)sender
{
    [GameResult deleteGameResults];
}
- (IBAction)playingCardSegmentedControlValueChanged:(UISegmentedControl *)sender
{
    NSString *difficulty = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    [[NSUserDefaults standardUserDefaults] setObject:difficulty forKey:PLAYING_CARD_DIFFICULTY_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)setCardSegmentedControlValueChanged:(UISegmentedControl *)sender
{
    NSString *difficulty = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    [[NSUserDefaults standardUserDefaults] setObject:difficulty forKey:SET_CARD_DIFFICULTY_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *playingCardDifficulty = [[NSUserDefaults standardUserDefaults] objectForKey:PLAYING_CARD_DIFFICULTY_KEY];
    NSString *setCardDifficulty = [[NSUserDefaults standardUserDefaults] objectForKey:SET_CARD_DIFFICULTY_KEY];
    
    [self.playingCardSegmentedControl setSelectedSegmentIndex:1];
    [self.setCardSegmentedControl setSelectedSegmentIndex:1];
    
    if ([playingCardDifficulty isEqualToString:@"Beginner"]) {
        [self.playingCardSegmentedControl setSelectedSegmentIndex:0];
    } else if ([playingCardDifficulty isEqualToString:@"Normal"]) {
        [self.playingCardSegmentedControl setSelectedSegmentIndex:1];
    } else if ([playingCardDifficulty isEqualToString:@"Advanced"]) {
        [self.playingCardSegmentedControl setSelectedSegmentIndex:2];
    }
    
    if ([setCardDifficulty isEqualToString:@"Beginner"]) {
        [self.setCardSegmentedControl setSelectedSegmentIndex:0];
    } else if ([setCardDifficulty isEqualToString:@"Normal"]) {
        [self.setCardSegmentedControl setSelectedSegmentIndex:1];
    } else if ([setCardDifficulty isEqualToString:@"Advanced"]) {
        [self.setCardSegmentedControl setSelectedSegmentIndex:2];
    }
}

@end
