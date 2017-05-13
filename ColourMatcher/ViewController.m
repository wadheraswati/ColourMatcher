//
//  ViewController.m
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/12/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.navigationItem.title = @"Main";
    [self.navigationController setNavigationBarHidden:YES];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.matrix = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 10 , self.view.bounds.size.width - 10, self.view.bounds.size.height - 20) collectionViewLayout:layout];
    self.matrix.backgroundColor = [UIColor blackColor];
    self.matrix.clipsToBounds = YES;
    self.matrix.delegate = self;
    self.matrix.dataSource = self;
    [self.matrix setCenter:self.view.center];
    [self.matrix registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"matrixCell"];
    [self.view addSubview:self.matrix];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark UICollectionView Data Source & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"matrixCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((collectionView.bounds.size.width - 15)/4, (collectionView.bounds.size.height - 50)/4);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
