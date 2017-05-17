//
//  ViewController.h
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/12/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreViewController.h"
#import "DBManager.h"
#import "CNPPopupController.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, CNPPopupControllerDelegate>
{
    NSMutableArray *cards;
    
    UILabel *scoreLbl;
    CNPPopupController *popupController;
    NSString *lastCard;
    NSUInteger score;
    NSUInteger winCards;
}
@property (nonatomic, strong) UICollectionView *matrix;

@end

