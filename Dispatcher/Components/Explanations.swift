//
//  Explanations.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-21.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import Foundation

let asyncExplanation = """
Async dispatch does not block the caller.
"""

let syncExplanation = """
The caller queue is blocked, and work runs on caller thread.
"""

let serialExplanation = """
Serial queues can only use one thread.
"""

let concurrentExplanation = """
Concurrent queues can spawn multiple threads as needed.
"""
