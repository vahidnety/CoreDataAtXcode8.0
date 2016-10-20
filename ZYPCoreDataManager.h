//
//  ZYPCoreDataManager.h
//  01-CoreDataFirstTest
//
//  Created by yunpengzhang on 2016/10/20.
//  Copyright © 2016年 yunpengzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface ZYPCoreDataManager : NSObject
@property (strong,readonly)NSManagedObjectContext *moc;
/**
 持久化容器 - 可以提供管理上下文 iOS 10 推出
 包含了 Core Data stack 中所有的核心对象，都不是线程安全的
 
 - NSManagedObjectContext *viewContext; 管理上下文
 - NSManagedObjectModel *managedObjectModel;
 - NSPersistentStoreCoordinator *persistentStoreCoordinator;
 */
//@property (readonly, strong) NSPersistentContainer *persistentContainer;

/**
 管理对象上下文
 */
+ (instancetype)sharedManeger;
/**
 保存上下文
 */
- (void)saveContext;
@end
