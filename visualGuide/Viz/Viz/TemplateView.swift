import SwiftUI

struct TemplateView: View {
    var body: some View {
        HeaderView(title: "Splunge",
                   subtitle: "SubSplunge",
                   desc: "Stuff for demonstrations go here. yay!",
                   back: .blue,
                   textColor: .white)
    }
}
