//
//  http-methods.swift
//  WatchOS WatchKit Extension
//
//  Created by Kaavya on 2022-02-26.
//

import Foundation

extension HTTPClient {
    // A selection of http methods
    public enum HttpMethod: String {
        case POST, PATCH, PUT, GET, DELETE, OPTIONS, HEAD, TRACE
    }
}
