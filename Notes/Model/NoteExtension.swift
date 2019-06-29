//
//  NoteExtension.swift
//  Notes
//
//  Created by Бабин Владимир on 27/06/2019.
//  Copyright © 2019 Pro IT Resource. All rights reserved.
//

import UIKit

extension Note {
    var json: [String: Any] {
        var json = [String: Any]()
        json["uid"] = uid
        json["title"] = title
        json["content"] = content
        if color != .white {
            json["color"] = color.toHexString()
        }
        if importance != .ordinary {
            json["importance"] = importance.rawValue
        }
        if let selfDestructionDate = selfDestructionDate {
            json["selfDestructionDate"] = selfDestructionDate.timeIntervalSince1970
        }
        return json
    }
    
    static func parse(json: [String: Any]) -> Note? {
        guard let uid = json["uid"] as? String,
            let title = json["title"] as? String,
            let content = json["content"] as? String
            else { return nil }
        
        var color: UIColor = .white
        if let hexColor = json["color"] as? String {
            color = UIColor(hexString: hexColor)
        }
        
        var importance: Importance = .ordinary
        if let importanceString = json["importance"] as? String {
            importance = Importance(rawValue: importanceString) ?? .ordinary
        }
        
        var selfDestructionDate: Date? = nil
        if let selfDestructionDateInterval = json["selfDestructionDate"] as? TimeInterval {
            selfDestructionDate = Date(timeIntervalSince1970: selfDestructionDateInterval)
        }
        
        return Note(uid: uid, title: title, content: content, color: color, importance: importance, selfDestructionDate: selfDestructionDate)
    }
}

private extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
