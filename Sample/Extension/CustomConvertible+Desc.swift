//
//  CustomConvertible+Desc.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import Foundation
public extension CustomStringConvertible {
    var description: String {
        var description = " \(type(of: self)): { "
        let selfMirror = Mirror(reflecting: self)
        for (index,child) in selfMirror.children.enumerated() {
            if let propertyName = child.label {
                description += "\(propertyName): \(unwrap(child.value))"
                if  index == (selfMirror.children.count - 1){
                    description += " }"
                }else{
                    description += ", "
                }
            }
        }
        return description
    }
    
    func unwrap<T>(_ any: T) -> Any
    {
        let mirror = Mirror(reflecting: any)
        guard mirror.displayStyle == .optional, let first = mirror.children.first else {
            return any
        }
        return first.value
    }
}

