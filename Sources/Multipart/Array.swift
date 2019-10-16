//
//  Array.swift
//  
//
//  Created by Bil Moorhead on 10/16/19.
//

import Foundation

extension Array where Element == UInt8 {
	
	public var hex: String {
	
		map{ String(format: "%02x", $0) }.joined(separator: "")
	
	}
	
}
