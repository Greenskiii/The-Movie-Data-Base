//
//  ViewController.swift
//  TMDB
//
//  Created by Алексей Даневич on 21.08.2021.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SwitchMovieTVShowSegmentedControl: UISegmentedControl!
    
    var viewModel: MainMenuViewModel = MainMenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil),
                                forCellReuseIdentifier: "Cell")
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.loadMovies(completion: {
            self.tableView.reloadData()
        })
        self.viewModel.loadActors(completion: {
            self.collectionView.reloadData()
        })
        self.viewModel.loadTvShow(completion: {
            self.tableView.reloadData()
        })
    }
    
    @IBAction func `switch`(_ sender: Any) {
        self.tableView.reloadData()
    }
}

extension MainMenuViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = self.SwitchMovieTVShowSegmentedControl.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            return self.viewModel.movies.count
        case 1:
            return self.viewModel.tvShow.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else { return UITableViewCell() }
        
        let selectedIndex = self.SwitchMovieTVShowSegmentedControl.selectedSegmentIndex
        cell.selectionStyle = .none
        
        switch selectedIndex {
        case 0:
            let media = self.viewModel.movies[indexPath.row]
            let imagePathString = Constants.network.defaultImagePath + media.posterPath!
            cell.configure(imageURL: URL(string: imagePathString), title: media.title, releaseDate: media.releaseDate, voteAverage: media.voteAverage, overviewText: media.overview)
        case 1:
            let media = self.viewModel.tvShow[indexPath.row]
            let imagePathString = Constants.network.defaultImagePath + media.posterPath!
            cell.configure(imageURL: URL(string: imagePathString), title: media.originalName, releaseDate: media.firstAirDate, voteAverage: media.voteAverage, overviewText: media.overview)
        default:
            return UITableViewCell()
            
        }
        return cell
    }
}

extension MainMenuViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = self.SwitchMovieTVShowSegmentedControl.selectedSegmentIndex
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch selectedIndex {
        case 0:
            let identifier = String(describing: MovieDeteilViewController.self)
            if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? MovieDeteilViewController {
                detailViewController.viewModel.movie = self.viewModel.movies[indexPath.row]
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        case 1:
            let identifier = String(describing: TVShowDeteilViewController.self)
            if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? TVShowDeteilViewController {
                detailViewController.viewModel.tvShow = self.viewModel.tvShow[indexPath.row]
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        default:
            let identifier = String(describing: MovieDeteilViewController.self)
            if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? MovieDeteilViewController {
                detailViewController.viewModel.movie = self.viewModel.movies[indexPath.row]
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
}

extension MainMenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
            let actor = self.viewModel.actors[indexPath.row]
            cell.configure(actorName: actor.name, profilePath: actor.profilePath)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}











