
import UIKit

class WatchLaterViewController: UIViewController {
    
    @IBOutlet weak var SaveListeTableView: UITableView!
    
    
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
        
        self.viewModel.getAllMovies(completion: {})
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
        self.viewModel.filteredMovie = self.viewModel.movies.filter { (movie: MovieRealm) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        
        self.SaveListeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.viewModel.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            DataManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: self.viewModel.movies[indexPath.row].id )
            
            
        }
    }
}

extension WatchLaterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isFiltering {
            return self.viewModel.filteredMovie.count
        }
        return self.viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SaveListTableViewCell else { return UITableViewCell() }
        
        if self.isFiltering {
            self.viewModel.movie = self.viewModel.filteredMovie
        } else {
            self.viewModel.movie = self.viewModel.movies
        }
        
        cell.selectionStyle = .none
        let media = self.viewModel.movies[indexPath.row]
        let imagePathString = Constants.network.defaultImagePath + media.posterPath
        cell.configure(imageURL: URL(string: imagePathString), title: media.title, releaseDate: media.date, voteAverage: media.voteAverage, overviewText: media.overview)
        return cell
        
    }
}

extension WatchLaterViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}








