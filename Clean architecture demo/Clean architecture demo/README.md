//
//  CleanArchitectureDemo.swift
//  CleanArchitectureDemo
//
//  Created by ChatGPT on 2026-06-03.
//

import SwiftUI
import Combine

// MARK: - Domain Layer

// Entity
struct User: Identifiable {
    let id: UUID
    let name: String
    let email: String
}

// Protocols
protocol UserRepository {
    func fetchUsers() -> AnyPublisher<[User], Error>
}

// Use Case
class GetUsersUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[User], Error> {
        repository.fetchUsers()
    }
}

// MARK: - Data Layer

class MockUserRepository: UserRepository {
    func fetchUsers() -> AnyPublisher<[User], Error> {
        let users = [
            User(id: UUID(), name: "Alice Smith", email: "alice@example.com"),
            User(id: UUID(), name: "Bob Johnson", email: "bob@example.com"),
            User(id: UUID(), name: "Charlie Davis", email: "charlie@example.com")
        ]
        return Just(users)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Presentation Layer

class UserListViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let getUsersUseCase: GetUsersUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getUsersUseCase: GetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
    }

    func loadUsers() {
        isLoading = true
        errorMessage = nil

        getUsersUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
}

// MARK: - SwiftUI Views

struct UserListView: View {
    @StateObject var viewModel: UserListViewModel

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

// MARK: - App Layer (Composition Root)

@main
struct CleanArchitectureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = MockUserRepository()
            let useCase = GetUsersUseCase(repository: repository)
            let viewModel = UserListViewModel(getUsersUseCase: useCase)
            UserListView(viewModel: viewModel)
        }
    }
}
