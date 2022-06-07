//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Павел Кай on 07.06.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Adress", text: $order.streetAdress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                
                Section {
                    NavigationLink {
                        CheckoutView(order: order)
                    } label: {
                        Text("Check out")
                    }
                    .disabled(order.hasValidAddress == false)
                }
            }
            .navigationTitle("Deviliry details")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
