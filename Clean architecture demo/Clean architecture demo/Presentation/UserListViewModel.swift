import Foundation
import Combine

@MainActor
class UserListViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let getUsersUseCase: GetUsersUseCase

    init(getUsersUseCase: GetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
    }

    func loadUsers() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let fetched = try await getUsersUseCase.execute()
                users = fetched
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
