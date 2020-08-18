import SwiftUI

public struct BasicToggle: View {
    
    @Binding var isOn: Bool
    
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    public var body: some View {
        
        Toggle(isOn: $isOn, label: { EmptyView() })
            .frame(width: 50)
            .offset(x: -5)
        
    }
    
}

struct BasicToggle_Previews: PreviewProvider {
    static var previews: some View {
        BasicToggle(isOn: .constant(true))
    }
}
