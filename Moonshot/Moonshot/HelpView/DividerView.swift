//
//  DividerView.swift
//  Moonshot
//
//  Created by Павел Кай on 02.06.2022.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackgroung)
            .padding(.vertical)
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
    }
}
