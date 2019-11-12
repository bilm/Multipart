//
//  UIKit.swift
//  
//
//  Created by Bil Moorhead on 10/16/19.
//

#if os(iOS)
import UIKit

extension MultiPart.Part {

	public static func png(
		_ image: UIImage,
		named name:String,
		filename: String? = nil
	) ->MultiPart.Part {
		
		let pngData = image.pngData()!
		return .init(name: name, data: pngData, mime: "image/png", filename: filename)
		
	}
	
	public static func jpg(
		_ image: UIImage,
		compression:CGFloat = 1.0,
		named name:String,
		filename: String? = nil
	) ->MultiPart.Part {
		
		let jpgData = image.jpegData(compressionQuality: compression)!
		return .init(name: name, data: jpgData, mime: "image/jpg", filename: filename)
		
	}
	
}

#endif
