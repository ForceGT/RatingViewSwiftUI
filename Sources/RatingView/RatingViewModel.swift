//
//  File.swift
//  
//
//  Created by Gaurav Thakkar on 16/02/21.
//

import Foundation
import SwiftUI

public class RatingViewModel : ObservableObject {
    
    // MARK:  PROPERTIES
    /// An array of 5 values with each value giving the progress of the number of stars
    /// The progress value must be between 0.0 and 1.0 and should be given in reverse
    /// The value at index 0 will correspond to the progress value for 5 star rating, 2nd for 4star rating and so on
    @Published public var progressValues : [Float] = []
    /// Current Rating from the user if any , defaults to 0
    @Published public var userRating: Int = 0
    /// Net rating from the user if any, default to 0.0
    @Published public var netRate : Float = 0.0
    /// The color of the star that will be displayed when not selected, defaults to gray
    public var offColor = Color.gray
    /// The color of the star when selected, defaults to accentColor
    public var onColor = Color.accentColor
    /// The background color of the progress bar
    public var backgroundColor : Color = Color.gray
    /// The fill color of the progress bar
    public var fillColor : Color = Color.accentColor
    
    
    public init(progressValues : [Float] = [0.0,0.0,0.0,0.0,0.0], userRating: Int = 0, netRate: Float = 0.0, offColor: Color = Color.gray, onColor: Color = Color.accentColor, backgroundColor: Color = Color.gray, fillColor: Color = Color.accentColor) {
        self.progressValues = progressValues
        self.userRating = userRating
        self.netRate = netRate
        self.offColor = offColor
        self.onColor = onColor
        self.backgroundColor = backgroundColor
        self.fillColor = fillColor
        
    }
    
    
}
