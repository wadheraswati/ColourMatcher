//
//  HighScoreViewController.m
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/17/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import "HighScoreViewController.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

- (void)viewDidLoad {
    
    scores = [NSMutableArray arrayWithArray:[[DBManager sharedManager] getScores]];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, self.view.bounds.size.width, 20)];
    [titleLbl setTextColor:[UIColor blackColor]];
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    [titleLbl setFont:[UIFont boldSystemFontOfSize:14]];
    [titleLbl setText:@"High Scores"];
    [self.view addSubview:titleLbl];

    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"DONE" forState:UIControlStateNormal];
    [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [doneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn sizeToFit];
    [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - doneBtn.bounds.size.width - 5, 25, doneBtn.bounds.size.width, doneBtn.bounds.size.height)];
    [self.view addSubview:doneBtn];
    
    UITableView *scoreTable = [[UITableView alloc] initWithFrame:CGRectMake(0, doneBtn.frame.origin.y + doneBtn.frame.size.height + 10, self.view.bounds.size.width, self.view.bounds.size.height)];
    [scoreTable setRowHeight:40];
    [scoreTable setDelegate:self];
    [scoreTable setDataSource:self];
    [scoreTable registerClass:[ScoreTableViewCell class] forCellReuseIdentifier:@"scoreCell"];
    [scoreTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:scoreTable];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate and UITableViewDataSource Methods -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView2 numberOfRowsInSection:(NSInteger)section {
    return (section == 0)?1:scores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreTableViewCell *cell = (ScoreTableViewCell *)[tableView2 dequeueReusableCellWithIdentifier:@"scoreCell"];
    if (cell == nil) {
        cell = [[ScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scoreCell"];
    }
    
    if(indexPath.section == 0) {
        [cell.rankLbl setText:@"RANK"];
        [cell.nameLbl setText:@"NAME"];
        [cell.scoreLbl setText:@"SCORE"];
        [cell.rankLbl setFont:[UIFont boldSystemFontOfSize:14]];
        [cell.nameLbl setFont:[UIFont boldSystemFontOfSize:14]];
        [cell.nameLbl setFont:[UIFont boldSystemFontOfSize:14]];

    }
    else {
        [cell.rankLbl setText:[NSString stringWithFormat:@"%d", (int)indexPath.row + 1]];
        [cell.nameLbl setText:scores[indexPath.row].name];
        [cell.scoreLbl setText:[NSString stringWithFormat:@"%d", scores[indexPath.row].score]]
        ;
    }

    [cell layoutSubviews];
    
    return cell;
}

#pragma mark - Helper Methods -

- (void)doneBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
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
