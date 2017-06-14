//
//  Todo.m
//  Every.Do
//
//  Created by Harry Li on 2017-06-13.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)todoDescription andPriorityNumber:(NSString *)priorityNumber
{
    self = [super init];
    if (self) {
        _title = title;
        _todoDescription = todoDescription;
        _priorityNumber = priorityNumber;
        _isCompleted = NO;
    }
    return self;
}


@end
