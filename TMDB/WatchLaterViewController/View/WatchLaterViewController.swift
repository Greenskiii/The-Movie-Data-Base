
import UIKit
import RealmSwift

class WatchLaterViewController: UIViewController {
    // dsdzxzx
    
    @IBOutlet weak var SaveListeTableView: UITableView!
    let realm = try? Realm()
    var movies: [MovieRealm] = []
    var filteredMovie: [MovieRealm] = []
    var movie: [MovieRealm] = []
    
    var viewModel: WatchLaterViewModel = WatchLaterViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.SaveListeTableView.register(UINib(nibName: "SaveListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.movies = self.getMovies()
        self.SaveListeTableView.reloadData()
        
        
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: MovieRealm? = nil) {
        filteredMovie = movies.filter { (movie: MovieRealm) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        
        self.SaveListeTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            DataManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movies[indexPath.row].id )
            
            
        }
    }
    
    
    
    
    private func getMovies() -> [MovieRealm] {
        
        var movies = [MovieRealm]()
        guard let citiesResults = realm?.objects(MovieRealm.self) else { return [] }
        for movie in citiesResults {
            movies.append(movie)
        }
        return movies
    }
}



extension WatchLaterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return self.filteredMovie.count
        }
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SaveListTableViewCell else { return UITableViewCell() }
        
        
        
        if isFiltering {
            self.movie = self.filteredMovie
        } else {
            self.movie = self.movies
        }
        
        cell.selectionStyle = .none
        cell.configure(with: movie[indexPath.row])
        
        return cell
        
    }
}

extension WatchLaterViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}








