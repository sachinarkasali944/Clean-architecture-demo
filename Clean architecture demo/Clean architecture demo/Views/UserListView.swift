import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.loadUsers()
                        }
                        .padding(.top)
                    }
                } else if viewModel.users.isEmpty {
                    Text("No users found")
                } else {
                    List(viewModel.users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
        .onAppear {
            viewModel.loadUsers()
        }
    }
}
