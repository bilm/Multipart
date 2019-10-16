//
//  Data.swift
//  
//
//  Created by Bil Moorhead on 10/16/19.
//

import Foundation

extension Data {
	
	public mutating func append<T>(_ string: T) where T: StringProtocol {
	
		append( Data(string.utf8) )
	
	}

}
