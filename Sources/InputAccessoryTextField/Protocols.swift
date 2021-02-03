//
//  File.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import Foundation


public protocol ImageNaming {
    var imageName: String { get }
}

extension String: ImageNaming {
    public var imageName: String {
        return self
    }
}
