//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Lloyd W. Sykes on 6/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController ()

@end

@implementation FISBlackjackViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.game = [FISBlackjackGame new];
    
    self.houseCard1.hidden = TRUE;
    self.houseCard1.text = @"";
    self.houseCard2.hidden = TRUE;
    self.houseCard3.hidden = TRUE;
    self.houseCard4.hidden = TRUE;
    self.houseCard5.hidden = TRUE;
    
    self.playerCard1.hidden = TRUE;
    self.playerCard2.hidden = TRUE;
    self.playerCard3.hidden = TRUE;
    self.playerCard4.hidden = TRUE;
    self.playerCard5.hidden = TRUE;
    
    self.gameResult.hidden = TRUE;
    self.playerStay.hidden = TRUE;
    self.houseStay.hidden = TRUE;
    self.playerBust.hidden = TRUE;
    self.houseBust.hidden = TRUE;
    self.playerBlackjack.hidden = TRUE;
    self.houseBlackjack.hidden = TRUE;
    self.houseScore.hidden = TRUE;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dealButtonTapped:(id)sender {
    
    [self.game.house resetForNewGame];
    [self.game.player resetForNewGame];
    [self.game dealNewRound];
    
    self.dealCard.enabled = FALSE;
    self.houseScore.hidden = TRUE;
    
    self.houseCard1.text = @"";
    
    self.playerCard3.hidden = TRUE;
    self.playerCard4.hidden = TRUE;
    self.playerCard5.hidden = TRUE;
    self.houseCard3.hidden = TRUE;
    self.houseCard4.hidden = TRUE;
    self.houseCard5.hidden = TRUE;
    
    self.gameResult.hidden = TRUE;
    
    self.houseStay.hidden = TRUE;
    self.playerStay.hidden = TRUE;
    
    self.stayPlayer.enabled = FALSE;
    self.hitPlayer.enabled = FALSE;
    
    self.playerBust.hidden = TRUE;
    self.houseBust.hidden = TRUE;
    self.playerBlackjack.hidden = TRUE;
    self.houseBlackjack.hidden = TRUE;
    
    self.playerCard1.hidden = FALSE;
    self.playerCard1.text = ((FISCard *) self.game.player.cardsInHand[0]).cardLabel;
    self.playerCard2.hidden = FALSE;
    self.playerCard2.text = ((FISCard *) self.game.player.cardsInHand[1]).cardLabel;
    self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];
    
    self.houseCard1.hidden = FALSE;
    
    self.houseCard2.hidden = FALSE;
    self.houseCard2.text = ((FISCard *)self.game.house.cardsInHand[1]).cardLabel;
    self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];
    
    if (self.game.player.blackjack == YES) {
        
        self.playerWins.hidden = FALSE;
        self.playerBlackjack.hidden = FALSE;
        self.gameResult.hidden = FALSE;
        self.gameResult.text = @"You Win!";
        [self.game incrementWinsAndLossesForHouseWins:(!self.houseWins)];
        self.playerWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.player.wins];
        self.houseLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.house.losses];
        self.dealCard.enabled = TRUE;
        
    } else if (self.game.house.blackjack == YES) {
        
        
        self.houseBlackjack.hidden = FALSE;
        self.gameResult.hidden = FALSE;
        self.gameResult.text = @"House Wins";
        [self.game incrementWinsAndLossesForHouseWins:(self.houseWins)];
        self.houseWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.player.wins];
        self.playerLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.player.losses];
        self.houseScore.hidden = FALSE;
        self.dealCard.enabled = TRUE;
        
    } else {
        
        self.hitPlayer.enabled = TRUE;
        self.stayPlayer.enabled = TRUE;
    }
    
    
}

- (IBAction)hitButtonTapped:(id)sender {
    
    /* When a user taps the hit button it should deal a new card to the player, then the house should take it's turn, then wait for further input. Make sure to check for winners! */
    
    [self.game dealCardToPlayer];
    
    if (self.game.player.cardsInHand.count == 3) {
        
        self.playerCard3.hidden = FALSE;
        self.playerCard3.text = ((FISCard *)self.game.player.cardsInHand[2]).cardLabel;
        self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];
        
    }
    
    if (self.game.player.cardsInHand.count == 4) {
        
        self.playerCard4.hidden = FALSE;
        self.playerCard4.text = ((FISCard *)self.game.player.cardsInHand[3]).cardLabel;
        self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];
        
    }
    
    if (self.game.player.cardsInHand.count == 5) {
        
        self.playerCard5.hidden = FALSE;
        self.playerCard5.text = ((FISCard *)self.game.player.cardsInHand[4]).cardLabel;
        self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];
        
    }
    
    if (self.game.player.busted == YES) {
        
        self.houseCard1.text = ((FISCard *) self.game.house.cardsInHand[0]).cardLabel;
        self.playerBust.hidden = FALSE;
        self.hitPlayer.enabled = FALSE;
        self.stayPlayer.enabled = FALSE;
        self.gameResult.hidden = FALSE;
        self.gameResult.text = @"House Wins";
        [self.game incrementWinsAndLossesForHouseWins:(self.houseWins)];
        self.houseWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.house.wins];
        self.playerLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.player.losses];
        self.dealCard.enabled = TRUE;
        self.houseScore.hidden = FALSE;
        
    }
    
}

- (IBAction)stayButtonTapped:(id)sender {
    
    self.dealCard.hidden = FALSE;
    self.playerStay.hidden = FALSE;
    self.hitPlayer.enabled = FALSE;
    self.stayPlayer.enabled = FALSE;
    self.houseScore.hidden = FALSE;
    self.houseCard1.text = ((FISCard *)self.game.house.cardsInHand[0]).cardLabel;
    
    if ([self.game.house shouldHit] && self.game.house.cardsInHand.count == 2) {
        
        [self.game dealCardToHouse];
        
        self.houseCard3.hidden = FALSE;
        self.houseCard3.text = ((FISCard *)self.game.house.cardsInHand[2]).cardLabel;
        self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];
        
    }
    
    if ([self.game.house shouldHit] && self.game.house.cardsInHand.count == 3) {
        
        [self.game dealCardToHouse];
        
        self.houseCard4.hidden = FALSE;
        self.houseCard4.text = ((FISCard *)self.game.house.cardsInHand[3]).cardLabel;
        self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];
        
    }
    
    if ([self.game.house shouldHit] && self.game.house.cardsInHand.count == 4) {
        
        [self.game dealCardToHouse];
        
        self.houseCard5.hidden = FALSE;
        self.houseCard5.text = ((FISCard *)self.game.house.cardsInHand[4]).cardLabel;
        self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];
        
    }
    
    if (!self.game.house.shouldHit && self.game.house.handscore > 21) {
        
        self.houseBust.hidden = FALSE;
        
        
    } else {
        
        self.houseStay.hidden = FALSE;
        
    }
    
    if (self.game.house.handscore > self.game.player.handscore && !self.game.house.busted) {
        
        self.gameResult.hidden = FALSE;
        self.gameResult.text = @"House Wins";
        [self.game incrementWinsAndLossesForHouseWins:(self.houseWins)];
        self.houseWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.house.wins];
        self.playerLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.player.losses];
        self.dealCard.enabled = TRUE;
        
    } else {
        
        self.gameResult.hidden = FALSE;
        self.gameResult.text = @"You Win!";
        [self.game incrementWinsAndLossesForHouseWins:!(self.houseWins)];
        self.playerWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.player.wins];
        self.houseLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.house.losses];
        self.dealCard.enabled = TRUE;
        
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
