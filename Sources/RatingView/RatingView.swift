import SwiftUI

@available(iOS 13.0, *)
public struct RatingBarView: View {
    // MARK:  PROPERTIES
    /// An array of 5 values with each value giving the progress of the number of stars
    /// The progress value must be between 0.0 and 1.0 and should be given in reverse
    /// The value at index 0 will correspond to the progress value for 5 star rating, 2nd for 4star rating and so on
    @State var progressValues : [Float] = [0.0,0.0,0.0,0.0,0.0]
    /// Current Rating from the user if any , defaults to 0
    @State var userRating: Int = 0
    /// Net rating from the user if any, default to 0.0
    @State var netRate : Float = 0.0
    /// The label that appears next to the row of stars
    var label : String = ""
    /// The color of the star that will be displayed when not selected, defaults to gray
    var offColor = Color.gray
    /// The color of the star when selected, defaults to accentColor
    var onColor = Color.accentColor
    
    
    // MARK: BODY
    public var body: some View {
            VStack{
                    // Top net rating view
                    Text("\(netRate) stars").font(.largeTitle)
                    Text("out of 5")
                        
                    // 5 rows for five progress bars each showing the progress value for each type of star rating
                    HStack{
                        VStack(alignment: .leading){
                            HStack{
                                ForEach(0..<5){_ in
                                    Image(systemName: "star.fill")
                                }
                            }
                            HStack{
                                ForEach(0..<4){_ in
                                    Image(systemName: "star.fill")
                                }
                            }
                            HStack{
                                ForEach(0..<3){_ in
                                    Image(systemName: "star.fill")
                                }
                            }
                            HStack{
                                ForEach(0..<2){_ in
                                    Image(systemName: "star.fill")
                                }
                            }
                            HStack{
                                ForEach(0..<1){_ in
                                    Image(systemName: "star.fill")
                                }
                            }
                        }
                        VStack(alignment: .leading){
                            ForEach(0..<5){item in
                                ProgressBar(value: $progressValues[item])
                                    .frame(height: 10)
                            }
                        }
                    }
                    .padding()
                
                    // User Editable Rating
                    UserEditableRating(rating: $userRating, label: label, offColor: offColor, onColor: onColor)
            }
            .padding(.horizontal, 8)
            
}


}


fileprivate struct ProgressBar: View {
    //MARK: PROPERTIES
    @Binding var value: Float
    
    //MARK: BODY
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .leading){
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.gray))
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.accentColor)
                    .animation(.easeIn)
            }.cornerRadius(45.0)
            
        }//: GEOMETRY READER
    }
}


fileprivate struct UserEditableRating: View{
    
    // MARK: PROPERTIES
    /// A binding to the rating that will be edited
    @Binding var rating: Int
    /// The label that appears next to the row of stars
    var label : String = ""
    /// The color of the star that will be displayed when not selected, defaults to gray
    var offColor = Color.gray
    /// The color of the star when selected, defaults to accentColor
    var onColor = Color.accentColor
    
    
    let maximumRating = 5
    let offImage = Image(systemName: "star")
    let onImage = Image(systemName: "star.fill")

    
    //MARK: BODY
    
    var body: some View {
      
            HStack{
                Text(label)
                    .padding(.trailing, 4)
                ForEach(1..<maximumRating + 1) { number in
                    self.image(for: number)
                        .font(.title)
                        .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                        .onTapGesture {
                            print("Rated \(number) stars")
                        }
                                
             }
            }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}
