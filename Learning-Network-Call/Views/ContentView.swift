import SwiftUI

struct ContentView: View {
    var viewModel = ViewModel()
    @State var user: GitHubUser?
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .fill(.white)
            }
            .shadow(radius: 7)
            .frame(width: 120, height: 120)
            .padding()
            
            Text(user?.login ?? "")
                .bold()
                .font(.title3)
            Text(user?.bio ?? "")
                .padding()
            Spacer()
        }
        .background(.green)
        .cornerRadius(12)
        .padding()
        .task {
            do {
                user = try await viewModel.fetchGitHubUserData()
            } catch GHError.invalidURL {
                print("Invalid Url")
            } catch GHError.invalidData {
                print("Invalid data")
            } catch GHError.invalidResponse {
                print("Invalid response")
            } catch {
                print("Unexpected error!!")
            }
        }
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
