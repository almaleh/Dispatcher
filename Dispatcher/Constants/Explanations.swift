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
    The caller queue is blocked, and work runs on caller thread.
    """

    static let serial = """
    Serial queues can only use one thread.
    """

    static let concurrent = """
    Concurrent queues can spawn multiple threads as needed.
    """

}
