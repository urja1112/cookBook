//
//  ProfileView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
               List {
                   if let user =  authViewModel.currentUser {
                       Section(header: Text("Account")) {
                           HStack {
                               Image(systemName: "envelope")
                               Text(user.email ?? "abc@gmail.com")
                           }
                       }
                   }

//                   Section(header: Text("Settings")) {
//                       NavigationLink("Notifications", destination: NotificationPreferencesView())
//                       NavigationLink("Privacy Policy", destination: PrivacyPolicyView())
//                       NavigationLink("About", destination: AboutAppView())
//                   }

                   Section {
                       Button(role: .destructive) {
                           do {
                               try authViewModel.logout()
                           } catch {
                               print("Logout failed: \(error.localizedDescription)")
                           }
                       } label: {
                           HStack {
                               Image(systemName: "rectangle.portrait.and.arrow.right")
                               Text("Logout")
                           }
                       }
                   }
               }
               .navigationTitle("Profile")
           }
       }
}


#Preview {
    ProfileView()
}
