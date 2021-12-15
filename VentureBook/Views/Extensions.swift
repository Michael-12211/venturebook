//
//  Extensions.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Kevin Tran on 2021-11-22.
//

import SwiftUI

extension Color{
    static func rgb(r: Double, g: Double, b: Double) -> Color{
        return Color(red: r/255, green: g/255, blue: b/255)
    }
    static let backgroundColor = Color.rgb(r: 255, g: 236, b: 209)
    static let buttonColor = Color.rgb(r: 21, g: 97, b: 109)
    static let headerColor = Color.rgb(r: 255, g: 125, b: 0)

}
