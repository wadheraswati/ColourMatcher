//
//  DBManager.h
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/17/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Score.h"

@interface DBManager : NSObject
{
    sqlite3 *db;
}

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilePath;

+ (id)sharedManager;

- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
- (void)saveScore:(NSUInteger)score withName:(NSString *)name;
- (NSMutableArray *)getScores;

@end
