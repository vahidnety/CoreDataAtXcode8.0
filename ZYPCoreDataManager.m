//
//  ZYPCoreDataManager.m
//  01-CoreDataFirstTest
//
//  Created by yunpengzhang on 2016/10/20.
//  Copyright © 2016年 yunpengzhang. All rights reserved.
//

#import "ZYPCoreDataManager.h"

@implementation ZYPCoreDataManager
+ (instancetype)sharedManeger{
    static id instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [self new];
        
    });
    return instance;
}

#pragma mark - Core Data stack

@synthesize moc = _moc;

- (NSManagedObjectContext *)moc {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    if (_moc != nil) {
        return _moc;
    }

    @synchronized (self) {
                //实例化管理上下文
            _moc = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        //管理对象模型
            NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];
            //实例化调度存储器
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:mom];
            //添加数据库
        
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        NSString *path = [cacheDir stringByAppendingPathComponent:@"com.zyp.database"];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES),
                                  NSInferMappingModelAutomaticallyOption: @(YES)};
        [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:nil];
        //给管理上下文制定存储调度器
        _moc.persistentStoreCoordinator = psc;
        
//            @"com.zyp.database"
//                   }
    }

    return _moc;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.moc;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
