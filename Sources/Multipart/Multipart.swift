//
//  Multipart.swift
//
//
//  Created by Bil Moorhead on 10/16/19.
//

import Foundation

struct MultiPart {
	
	struct Part {
		
		let name: String
		let data: Data
		var mime: String?
		var filename: String?
		
	}
	let parts: [Part]
	
	func build() ->(contentType:String, body:Data) {
		
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
	
	init(parts: Part...) { self.init(parts:parts) }
	
}

extension MultiPart.Part {
	
	static func string(
		_ string: String,
		named name:String
	) ->MultiPart.Part {
		
		return .init(name: name, data: Data(string.utf8), mime: "text/plain", filename: nil)
	
	}
	
	static func data(
		_ data: Data,
		named name:String
	) ->MultiPart.Part {
		
		return .init(name: name, data: data, mime: "octet-stream", filename: nil)
		
	}
}
