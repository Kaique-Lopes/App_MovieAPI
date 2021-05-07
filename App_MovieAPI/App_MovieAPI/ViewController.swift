//
//  ViewController.swift
//  App_MovieAPI
//
//  Created by Kaique Lopes on 04/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/550?api_key=7f83f0a91411cb45647d15d4ab954ae5") {
            let data = URLSession.shared.dataTask(with: url) { datas, request, error in
                if error == nil {
                    print("Sucesso ao consultar Filmes!")
                } else {
                    print("Houve algum erro ao consultar os Filmes!")
                }
            }
            data.resume()
        }
        
        
    }
    
    
}

