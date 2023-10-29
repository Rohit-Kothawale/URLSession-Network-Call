import Foundation

class ViewModel {
    private let networkManager = NetworkManager()

    func fetchGitHubUserData() async throws -> GitHubUser {
        do {
            return try await networkManager.getUser()
        } catch {
            throw GHError.unexpectedError
        }
    }
}
