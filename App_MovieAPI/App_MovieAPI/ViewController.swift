//
//  ViewController.swift
//  App_MovieAPI
//
//  Created by Kaique Lopes on 04/05/21.
//

import UIKit

class MovieData: Codable{
    let original_name: String?
    let original_title: String?
    let vote_average: Double?
    let vote_count: Double?
    let poster_path: String?
    let overview: String?
    let original_language: String?
    let backdrop_path: String?
    let first_air_date: String?
    let popularity: Double?
    let media_type: String?
}

class Movie: Codable{
    let results: [MovieData]?
}

class ViewController: UIViewController {
    var movies: Movie?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // MARK: - URL
        if let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=7f83f0a91411cb45647d15d4ab954ae5") {
            let data = URLSession.shared.dataTask(with: url) { datas, request, error in
                if error == nil {
                    
                    if let dataRequest = datas {
                        do {
                            let data = try JSONDecoder().decode(Movie.self, from: dataRequest)
                            DispatchQueue.main.async {
                                self.movies = data
                                self.tableView.reloadData()
                            }
                        }catch {
                            print("Deu erro aqui")
                        }
                    }
                } else {
                    print("Houve algum erro ao consultar os Filmes!")
                }
            }
            data.resume()
        }
        
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let value = movies?.results?[indexPath.row].original_name, !value.isEmpty {
            cell.textLabel?.text = value
        } else {
            cell.textLabel?.text = movies?.results?[indexPath.row].original_title ?? ""
        }
        cell.detailTextLabel?.text = movies?.results?[indexPath.row].overview ?? ""
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "webkitview", sender: movies?.results?[indexPath.row].poster_path ?? "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webkitview" {
            let destination = segue.destination as! WebKitViewController
            if let photo = sender as? String {
                destination.photo = photo
            }
        }
    }
}
