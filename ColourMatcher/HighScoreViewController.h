//
//  HighScoreViewController.h
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/17/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreTableViewCell.h"
#import "DBManager.h"

@interface HighScoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray <Score *> *scores;
}

@end
