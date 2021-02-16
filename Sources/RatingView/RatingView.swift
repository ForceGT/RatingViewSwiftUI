import SwiftUI

@available(iOS 13.0, *)
public struct RatingView: View {
    // MARK:  PROPERTIES
    @ObservedObject var ratingViewModel : RatingViewModel
    /// The callback to be triggered when the rating is tapped
    public var onRatingTapped : ((Int) -> Void)?
    // Keeping it last just for trailing closure syntax
    
    public init(ratingViewModel : RatingViewModel, onRatingTapped : @escaping ((Int) -> Void)){
        self.ratingViewModel = RatingViewModel()
        self.onRatingTapped = onRatingTapped
    }
    // MARK: BODY
    public var body: some View {
            VStack{
                    // Top net rating view
                Text("\(ratingViewModel.netRate, specifier: "%.1f") stars").font(.largeTitle)
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
                                ProgressBar(value: $ratingViewModel.progressValues[item], backgroundColor: ratingViewModel.backgroundColor, fillColor: ratingViewModel.fillColor)
                                    .frame(height: 10)
                            }
                        }
                    }
                    .padding()
                
                    // User Editable Rating
                UserEditableRating(rating: $ratingViewModel.userRating, offColor: ratingViewModel.offColor, onColor: ratingViewModel.onColor, onRatingTap: self.onRatingTapped)
            }
            .padding(.horizontal, 8)
            
}


}


fileprivate struct ProgressBar: View {
    //MARK: PROPERTIES
    /// The value of the progress Bar
    @Binding var value: Float
    /// The unfilled/background color of the progress bar
    var backgroundColor = Color.gray
    /// The fill color of the progress bar
    var fillColor = Color.accentColor
    
    //MARK: BODY
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .leading){
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(backgroundColor)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(fillColor)
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
    @State var label : String = ""
    /// The color of the star that will be displayed when not selected, defaults to gray
    var offColor = Color.gray
    /// The color of the star when selected, defaults to accentColor
    var onColor = Color.accentColor
    
    var onRatingTap : ((Int) -> Void)?
    
    
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
                            if let onRatingTap = onRatingTap{
                                onRatingTap(number)
                            }
                            withAnimation(.easeIn(duration: 0.75)){
                                self.rating = number
                            }
                            label = String(number)
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
