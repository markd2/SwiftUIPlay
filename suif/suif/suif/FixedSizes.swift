import SwiftUI

struct FixedSizes: View {
    var body: some View { // (going down) say 400x800 size
        Text("Once upon a midnight dreary while I pondered weak and weary over many a quaint and curious volume of Klingon lore")  // (coming up) text is 300x150
          .border(.blue, width: 1) 
          .frame(width: 300, height: 300) // (going down) makes it 300 x 300
          .border(.red, width: 2)
        // so the border of the text snugglies the text, but the border around the
        // frame is a biggish square
    }
}

#Preview {
    FixedSizes()
}
