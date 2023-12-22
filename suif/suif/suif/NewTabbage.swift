import SwiftUI

struct NewTabbage: View {
    var body: some View {
        TabView {
            ForEachView()
              .tabItem {
                  Label("Current", systemImage: "cloud.sun.fill")
              }

            EllipseView()
              .tabItem {
                  Label("Current", systemImage: "calendar")
              }

            SnackSizing()
              .tabItem {
                  Label("Current", systemImage: "magnifyingglass")
              }
              
            FlexibleSize()
            BindingView(count: 23) 
        }.tabViewStyle(.page)
    }
}

#Preview {
    NewTabbage()
}
