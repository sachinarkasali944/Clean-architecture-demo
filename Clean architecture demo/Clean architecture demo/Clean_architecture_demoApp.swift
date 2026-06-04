//
//  Clean_architecture_demoApp.swift
//  Clean architecture demo
//
//  Created by Sachin Arkasali on 03/06/26.
//

import SwiftUI

@main
struct Clean_architecture_demoApp: App {
    var body: some Scene {
        WindowGroup {
            // Composition root: wire up repository -> use case -> view model -> view
            let repository = MockUserRepository()
            let useCase = GetUsersUseCase(repository: repository)
            let viewModel = UserListViewModel(getUsersUseCase: useCase)
            ContentView(viewModel: viewModel)
        }
    }
}
