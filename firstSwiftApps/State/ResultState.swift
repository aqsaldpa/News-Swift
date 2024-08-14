//
//  ResultState.swift
//  firstSwiftApps
//
//  Created by Aqsal Dharmaputra on 14/08/24.
//

import Foundation

enum ResultState<T> {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
