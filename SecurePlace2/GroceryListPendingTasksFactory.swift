//
//  Groc.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 16.04.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Wendy

class GroceryListPendingTasksFactory: PendingTasksFactory {

    func getTask(tag: String) -> PendingTask? {
        switch tag {
            case CreateGroceryListItemPendingTask.pendingTaskRunnerTag: return CreateGroceryListItemPendingTask()
        default: return nil
        }
    }

}
