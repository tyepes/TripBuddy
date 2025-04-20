//
//  LoginView.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import SwiftUI

struct LoginView: View {
    @State var email:String
    @State var password: String
    @State var toMapView: Bool = false
    @StateObject var adventuresList : AdventureList = AdventureList()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Sign In")
                    .padding(.top, 20)
                    .font(.headline)
                    TextField("Enter email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    SecureField("Enter password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                Button("Submit", action: {
                    toMapView = true
                    
                })
                NavigationLink("Submit", isActive: $toMapView) {
                    TripListView(adventures: adventuresList)
                }
                .buttonStyle(.bordered)
                Button("Sign Up", action: {
                    
                })
                .foregroundStyle(.green)
                .padding(.bottom)
                

            }
            .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.systemBackground))
                            .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)
                    )
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            
        }
    }
}


#Preview {
    LoginView(email: "", password: "")
}
