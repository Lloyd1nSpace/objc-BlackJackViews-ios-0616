//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Lloyd W. Sykes on 6/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@interface FISBlackjackGame ()

@end

@implementation FISBlackjackGame

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _deck = [FISCardDeck new];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
        
    }
    
    return self;
    
}

- (void)playBlackjack {
    
    [self.deck resetDeck];
    [self.house resetForNewGame];
    [self.player resetForNewGame];
    [self dealNewRound];
    
    for (NSUInteger i = 0; i < 3; i++) {
        
        [self processPlayerTurn];
        if (self.player.busted == YES) {
            
            break;
            
        }
        
        
        [self processHouseTurn];
        if (self.house.busted == YES) {
            
            break;
            
        }
        
    }
    
    [self incrementWinsAndLossesForHouseWins:[self houseWins]];
    
    NSLog(@"\n\n\n\n\nPlay BlackJack!\n\n\n\n\n%@\n\n\n\n\n", self.player.description);
    NSLog(@"\n\n\n\n\n\n\nPlay BlackJack!\n\n\n\n\n\n%@\n\n\n\n\n\n", self.house.description);
    
}

- (void)dealNewRound {
    
    [self.deck resetDeck];
    
    FISCard *playerCard1 = [self.deck drawNextCard];
    [self.player acceptCard:playerCard1];
    
    NSLog(@"This is my playerCard1: %@", playerCard1);
    
    FISCard *houseCard1 = [self.deck drawNextCard];
    [self.house acceptCard:houseCard1];
    
    FISCard *playerCard2 = [self.deck drawNextCard];
    [self.player acceptCard:playerCard2];
    
    FISCard *houseCard2 = [self.deck drawNextCard];
    [self.house acceptCard:houseCard2];
    
}

- (void)dealCardToPlayer {
    
    if ([self.player shouldHit] && [self.player busted] == NO && [self.player stayed] == NO) {
        
        FISCard *card = [self.deck drawNextCard];
        [self.player acceptCard:card];
        
    }
    
}

- (void)dealCardToHouse {
    
    if ([self.house shouldHit] && [self.house busted] == NO && [self.house stayed] == NO) {
        
        FISCard *card = [self.deck drawNextCard];
        [self.house acceptCard:card];
        
    }
    
}

- (void)processPlayerTurn {
    
    [self dealCardToPlayer];
    
}

- (void)processHouseTurn {
    
    [self dealCardToHouse];
    
}

- (BOOL)houseWins {
    
    if (self.player.blackjack && self.house.blackjack) {
        
        return NO;
        
    } else if (self.house.busted == YES || self.player.handscore > self.house.handscore) {
        
        return NO;
        
    } else {
        
        return YES;
        
    }
    
    return NO;
    
}
- (void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins {
    
    if (houseWins == YES) {
        
        self.house.wins++;
        self.player.losses++;
        NSLog(@"House Wins! House: %@ W%lu - L%lu, Player: %@ W%lu - L%lu", self.house.name, self.house.wins, self.house.losses, self.player.name, self.player.wins, self.player.losses);
        
    }
    
    if (houseWins == NO) {
        
        self.house.losses++;
        self.player.wins++;
        NSLog(@"Player Wins! House: %@ W%lu - L%lu, Player: %@ W%lu - L%lu", self.house.name, self.house.wins, self.house.losses, self.player.name, self.player.wins, self.player.losses);
        
    }
    
}

@end
