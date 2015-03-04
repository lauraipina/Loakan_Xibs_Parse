//
//  LIPCoreDataStack.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 16/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

@import Foundation;
@import CoreData;

@class NSManagedObjectContext;

@interface LIPCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+(NSString *) persistentStoreCoordinatorErrorNotificationName;

+(LIPCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                databaseFilename:(NSString*) aDBName;

+(LIPCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName;

+(LIPCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                     databaseURL:(NSURL*) aDBURL;

-(id) initWithModelName:(NSString *)aModelName
            databaseURL:(NSURL*) aDBURL;

-(void) zapAllData;

-(void) saveWithErrorBlock: (void(^)(NSError *error))errorBlock;

-(NSArray *) executeFetchRequest:(NSFetchRequest *)req errorBlock:(void(^)(NSError *error)) errorBlock;


@end
