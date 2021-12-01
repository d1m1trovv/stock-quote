//
//  NetworkError.swift
//  stocks
//
//  Created by Admin on 1.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

enum NetworkError: Error, String {
    case connectionFailed = "Could not connect to server"
}
