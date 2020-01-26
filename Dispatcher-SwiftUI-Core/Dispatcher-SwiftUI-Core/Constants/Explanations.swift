//
//  Explanations.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-21.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import Foundation

struct Explanations {
    private init(){}
    
    static let async = """
    Async dispatch does not block the caller.
    """

    static let sync = """
    Sync blocks the caller, and its work runs on the caller thread.
    """

    static let serial = """
    Serial queues do not run on more than one thread at a time. Order is guaranteed.
    """

    static let concurrent = """
    Concurrent queues can spawn multiple threads as needed.
    """

}
