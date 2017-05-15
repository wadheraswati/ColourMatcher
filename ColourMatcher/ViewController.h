//
//  ViewController.h
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/12/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray *cards;
    NSMutableArray *winCards;
    
    NSString *lastCard;
}
@property (nonatomic, strong) UICollectionView *matrix;

@end

