//
//  UIKit.swift
//  
//
//  Created by Bil Moorhead on 10/16/19.
//

#if os(macOS)

import AppKit
public typealias UniversalImage = NSImage

extension NSBitmapImageRep {
	
    public func png() ->Data? { representation(using: .png, properties: [:]) }
	public func jpeg(_ compressionQuality: CGFloat) ->Data? { representation(using: .jpeg, properties: [.compressionFactor: compressionQuality]) }
	
}
extension Data {
	
    public var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
	
}
extension NSImage {
	
    public func pngData() ->Data? { tiffRepresentation?.bitmap?.png() }
    public func jpegData(compressionQuality: CGFloat) ->Data? { tiffRepresentation?.bitmap?.jpeg(compressionQuality) }
	
}

#else

import UIKit
public typealias UniversalImage = UIImage

#endif

extension MultiPart.Part {

	public static func png(
		_ image: UniversalImage,
		named name:String,
		filename: String? = nil
	) ->MultiPart.Part {
		
		let pngData = image.pngData()!
		return .init(name: name, data: pngData, mime: "image/png", filename: filename)
		
	}
	
	public static func jpg(
		_ image: UniversalImage,
		compression:CGFloat = 1.0,
		named name:String,
		filename: String? = nil
	) ->MultiPart.Part {
		
		let jpgData = image.jpegData(compressionQuality: compression)!
		return .init(name: name, data: jpgData, mime: "image/jpg", filename: filename)
		
	}
	
}
