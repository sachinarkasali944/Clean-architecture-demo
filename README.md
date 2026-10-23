# Clean Architecture Demo

> A small SwiftUI app tracing the path from repository to use case to screen.

An approachable sample with a user entity, repository protocol, mock data implementation, use case, and presentation view model.

## Highlights

- Domain contracts independent of the SwiftUI view.
- Injected mock repository.
- Async use case and MainActor view model.
- A user-list view illustrating the layer boundaries.

## Open and run

1. Clone this repository and open `Clean architecture demo/Clean architecture demo.xcodeproj` in Xcode.
2. Select the app scheme and a simulator compatible with the deployment target in **Build Settings → iOS Deployment Target**. Use an Xcode version with SDK support for that target.
3. Build and run with **⌘R**. For a physical device, select your development team.

```bash
git clone https://github.com/sachinarkasali944/Clean-architecture-demo.git
cd Clean-architecture-demo
open "Clean architecture demo/Clean architecture demo.xcodeproj"
```

## Demo scope

The repository supplies mock users. A remote data source and persistent store are not implemented.

## Explore the code

- [Xcode project](./Clean%20architecture%20demo/Clean%20architecture%20demo.xcodeproj)
- [Project files](./Clean%20architecture%20demo)

## Further reading

[Read the detailed implementation guide](./Clean%20architecture%20demo/Clean%20architecture%20demo/README.md).
