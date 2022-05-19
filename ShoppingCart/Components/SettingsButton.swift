import SwiftUI

struct SettingsButton: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(systemName: "gearshape")
                .padding(.top, 5)
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton()
    }
}
