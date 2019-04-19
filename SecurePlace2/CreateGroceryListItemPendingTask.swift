//
//  Pe.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 16.04.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Wendy

class CreateGroceryListItemPendingTask: PendingTask {

    static let pendingTaskRunnerTag = String(describing: CreateGroceryListItemPendingTask.self)
    static let groceryStoreItemTextTooLongErrorId = "GROCERY_STORE_ITEM_TEXT_TOO_LONG"

    var taskId: Double?
    var dataId: String?
    var groupId: String?
    var tag: String = CreateGroceryListItemPendingTask.pendingTaskRunnerTag
    var manuallyRun: Bool = false
    var createdAt: Date?

    convenience init(groceryStoreItemId: Int) {
        self.init()
        self.dataId = String(groceryStoreItemId)
    }

    func isReadyToRun() -> Bool {
        return true
    }

    func runTask(complete: @escaping (Bool) -> Void) {
        // Here, instantiate your dependencies, talk to your DB, your API, etc. Run the task.
        // After the task succeeds or fails, return to Wendy the result.
           print("alla")
        DispatchQueue.main.asyncAfter(deadline: .now() + 50.0, execute: {
            UserDefaults.standard.set(true, forKey: "Key")
        })

    }

}
