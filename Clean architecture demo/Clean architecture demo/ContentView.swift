//
//  ContentView.swift
//  Clean architecture demo
//
//  Created by Sachin Arkasali on 03/06/26.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: UserListViewModel

    var body: some View {
        UserListView(viewModel: viewModel)
    }
}

#Preview {
    let repo = MockUserRepository()
    let useCase = GetUsersUseCase(repository: repo)
    let vm = UserListViewModel(getUsersUseCase: useCase)
    ContentView(viewModel: vm)
}
