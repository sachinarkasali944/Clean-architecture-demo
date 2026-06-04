//
This demo now uses Swift concurrency (async/await) instead of Combine.

Structure:
- Domain: `Domain/User.swift`, `Domain/UserRepository.swift` (async protocol)
- Data: `Data/MockUserRepository.swift` (async mock)
- UseCase: `UseCase/GetUsersUseCase.swift` (async)
- Presentation: `Presentation/UserListViewModel.swift` (`@MainActor`, uses `Task`)
- Views: `Views/UserListView.swift`, `ContentView.swift`

See `ContentView.swift` and `Clean_architecture_demoApp.swift` for composition examples.


---

## Learning Notes

- **Goal:** A minimal SwiftUI demo showing Clean Architecture layers: Domain, Data, Use Case, Presentation.
- **How it maps:** `User` is the entity (Domain). `UserRepository` is a domain-facing protocol. `MockUserRepository` is a Data-layer implementation. `GetUsersUseCase` is the domain use-case. `UserListViewModel` is the presentation logic. `UserListView` is the SwiftUI view.
- **To explore:** Open [Clean_architecture_demoApp.swift](Clean_architecture_demoApp.swift#L1) and [ContentView.swift](ContentView.swift#L1) to see how dependencies are composed and how the view model drives the UI.
- **Exercises:** Replace `MockUserRepository` with a network-backed implementation; add persistence; write unit tests for `GetUsersUseCase` and `UserListViewModel`.

Happy learning — ask if you want tests or a network example added.
