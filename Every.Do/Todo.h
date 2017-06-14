//
//  Todo.h
//  Every.Do
//
//  Created by Harry Li on 2017-06-13.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *todoDescription;
@property (nonatomic) NSString *priorityNumber;
@property (nonatomic) BOOL isCompleted;

- (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)todoDescription andPriorityNumber:(NSString *)priorityNumber;

@end
