//
//  Multipart.swift
//
//
//  Created by Bil Moorhead on 10/16/19.
//

import Foundation

public
struct MultiPart {
	
	public struct Part {
		
		let name: String
		let data: Data
		var mime: String?
		var filename: String?
		
	}
	public let parts: [Part]
	
	public func build() ->(contentType:String, body:Data) {
		
		var buffer = [UInt8](repeating: 0, count: 20)
		arc4random_buf(&buffer, 20)
		let boundary =  buffer.hex
		
		var body = Data("--\(boundary)\r\n".utf8)
		var inBetween = false
		parts.forEach {
			if inBetween { body.append( "--\(boundary)\r\n" ) }
			inBetween = true

			body.append( "Content-Disposition: form-data; name=\"\($0.name)\"" )
			if let filename = $0.filename { body.append( "; filename=\"\(filename)\"") }
			body.append( "\r\n" )
			
			if let mime = $0.mime { body.append( "Content-Type: \(mime)\r\n" ) }
			
			body.append( "\r\n" )
			body.append( $0.data )
			body.append( "\r\n" )
		}
		body.append( "--\(boundary)--\r\n" )
		
		let contentType = "multipart/form-data; boundary=\(boundary)"
		
		return (contentType,body)
	}
	
}
extension MultiPart {
	
	public init(parts: Part...) { self.init(parts:parts) }
	
}

extension MultiPart.Part {
	
	public static func string(
		_ string: String,
		named name:String,
		mime: String = "text/plain",
		filename: String? = nil
	) ->MultiPart.Part {
		
		return .init(name: name, data: Data(string.utf8), mime: mime, filename: filename)
	
	}
	
	public static func data(
		_ data: Data,
		named name:String,
		mime: String = "application/octet-stream",
		filename: String? = nil
	) ->MultiPart.Part {
		
		return .init(name: name, data: data, mime: mime, filename: filename)
		
	}
}
