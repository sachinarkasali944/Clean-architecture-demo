import Foundation

class MockUserRepository: UserRepository {
    func fetchUsers() async throws -> [User] {
        let users = [
            User(id: UUID(), name: "Alice Smith", email: "alice@example.com"),
            User(id: UUID(), name: "Bob Johnson", email: "bob@example.com"),
            User(id: UUID(), name: "Charlie Davis", email: "charlie@example.com")
        ]
        try await Task.sleep(nanoseconds: 1_000_000_000) // simulate network delay
        return users
    }
}
