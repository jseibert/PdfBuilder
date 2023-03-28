//
//  CGRect + Extensions.swift
//  
//
//  Created by Andrii Pervushyn on 27.03.2023.
//

#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension CGRect {
    static func landscapeA4() -> CGRect {
        return CGRectMake(0.0, 0.0, 841.8, 595.2);
    }
}
