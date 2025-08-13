//
//  Untitled.swift
//  PostApp
//
//  Created by Christiane Roth on 13.08.25.
//

/*
 1. Define a Generic Repository Protocol
 protocol Repository {
 associatedtype T
    func getAllPosts() async trows -> [T]
    func get() async trows
    func getPostByUserId(_ item: T) async throws
    func getPostById(_ item: T) async throws
    func createPost(_ item: T) async throws
    func updatePost(_ item: T) async throws
 
 
 
 2. Implement a Concrete Repository
    2.1 stuct Post:
    2.2 Create a Nework-Based Repository
        class PostRepository: Repository {
            private let networkService: NetworkService
            
            init(networkService: NetworkService = URLSession.shared) {
            self.networkService = networkService
        }
 
 func getAllPosts() asynnc throws -> [Posts] {
    let request...
 let (data, _) = try await networkService.data(for: request)
 returnn try JSONDecoder().decode([Post].self, from: data
 
 
 3. Use Depenndency Injection
    class ViewModel: ObservableObject {
 @Published var posts: [Post] = []
 
 
 
 init(postRepository: any Repository<Post> = PostNetworkRepository()) {
 self.postRepository = postRepository
 }
 
 @MainActor
 func fetchPosts() async {
 do {
 users = try await userRepository.getAll()
 } catch {
 self.error = error
 }}}
 
 1. PostRepositoryProtokoll:
    = Schnittstelle: welche Parameter benötigt werden und welcher Datentyp zurück gegeben werden muss
        quasi: fest legen was die grundvoraussetzung ist
 
 2. PostRepository als Singelton holt die Daten von einer URL, dort wird bestimmt woher was geholt wird für jeden einzelnen fall URL oder lokale datenbank
 
 3. UseCases: dort wird bestimmt von welcher datenquelle die infos geholt werden und stellt diese bereit
 
 4. Viewmodel greift nur noch blind auf die Usecases zurück und stellt sie der View zur verfügung
 
 
 
 
 
 */
