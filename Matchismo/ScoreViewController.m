//
//  ScoreViewController.m
//  Matchismo
//
//  Created by Teddy Wyly on 8/9/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "ScoreViewController.h"
#import "GameResult.h"

@interface ScoreViewController ()
@property (weak, nonatomic) IBOutlet UITextView *playingCardTextField;
@property (weak, nonatomic) IBOutlet UITextView *setCardTextField;
@property (nonatomic) SEL sortSelector;

@end

@implementation ScoreViewController

@synthesize sortSelector = _sortSelector;

#define PLAYING_CARD_NAME @"PlayingCardGameName"
#define SET_CARD_NAME @"SetCardGameName"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateUI
{
    NSString *displayPlayingCardText = @"";
    NSString *displaySetText = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    
    
    for (GameResult *result in [[GameResult allGameResults] sortedArrayUsingSelector:self.sortSelector]) {
        if ([result.gameName isEqualToString:PLAYING_CARD_NAME]) {
            displayPlayingCardText = [displayPlayingCardText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, result.end, round(result.duration)];
        } else if ([result.gameName isEqualToString:SET_CARD_NAME]) {
            displaySetText = [displaySetText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, result.end, round(result.duration)];
        }
    }
    self.playingCardTextField.text = displayPlayingCardText;
    self.setCardTextField.text = displaySetText;
    
}

- (SEL)sortSelector
{
    if (!_sortSelector) _sortSelector = @selector(compareScoreToGameResult:);
    return _sortSelector;
}

- (void)setSortSelector:(SEL)sortSelector
{
    _sortSelector = sortSelector;
    [self updateUI];
}

- (IBAction)sortByScore:(UIButton *)sender
{
    self.sortSelector = @selector(compareScoreToGameResult:);
}

- (IBAction)sortByDuration:(UIButton *)sender
{
    self.sortSelector = @selector(compareDurationToGameResult:);

}

- (IBAction)sortByDate:(UIButton *)sender
{
    self.sortSelector = @selector(compareEndDateToGameResult:);

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
    [super viewWillAppear:animated];
    [self updateUI];
}

@end
