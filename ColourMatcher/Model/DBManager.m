//
//  DBManager.m
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/17/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager


+ (id)sharedManager {
    static DBManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] initWithDatabaseFilename:@"score.sql"];
    });
    return sharedMyManager;
}

- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
    
        // Copy the database file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectoryWithPath:dbFilename];
    }
    return self;
}

- (void)copyDatabaseIntoDocumentsDirectoryWithPath:(NSString *)path{
    // Check if the database file exists in the documents directory.
    self.databaseFilePath = [self.documentsDirectory stringByAppendingPathComponent:path];
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.databaseFilePath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:self.databaseFilePath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

- (void)saveScore:(NSUInteger)score withName:(NSString *)name {
    [self openDB];
    
    const char *sql = "INSERT INTO scores(name, score) VALUES(?,?)";
    sqlite3_stmt *sqlStatement;
    if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    sqlite3_open([self.databaseFilePath UTF8String], &db);
    sqlite3_bind_text(sqlStatement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int64(sqlStatement, 2, score);
    sqlite3_step(sqlStatement);
    sqlite3_finalize(sqlStatement);
    sqlite3_close(db);
}

- (NSMutableArray *)getScores {
    [self openDB];
    
    const char *sql = "SELECT * from scores order by score desc limit 10";
    sqlite3_stmt *sqlStatement;
    if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    NSMutableArray *scores = [NSMutableArray array];
    while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
        Score *scoreObj = [[Score alloc]init];
        scoreObj.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
        scoreObj.score = sqlite3_column_int(sqlStatement, 2);
        
        [scores addObject:scoreObj];
    }
    
    NSLog(@"scores - %@",scores);
    return scores;
}


-(void)openDB {
    if(!(sqlite3_open([self.databaseFilePath UTF8String], &db) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
    }
    
}


@end
