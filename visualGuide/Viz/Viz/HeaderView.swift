import SwiftUI

struct HeaderView: View {
    var title: String
    var subtitle: String
    var desc: String
    var back: Color
    var textColor: Color

    var body: some View {
        VStack(spacing: 30) {
            Text(title)
                .font(.largeTitle)
            
            Text(subtitle)
                .font(.title)
                .foregroundColor(.gray)
            
            Text(desc)
                .frame(maxWidth: .infinity) // extend until you can't no mo
                .font(.title)
                .foregroundColor(textColor)
                .padding() // add space all around the text
                .background(back)
        }
    }
}
