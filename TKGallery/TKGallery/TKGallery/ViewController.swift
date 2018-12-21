//
//  ViewController.swift
//  TKGallery
//
//  Created by Yavuz BİTMEZ on 06/12/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var TKGArray : [TKGArr] = []

    
    @IBOutlet weak var collectionViv: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    func getData(){
        let url = URL(string: "https://api.tmgrup.com.tr/v1/link/149?id=262259")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            do {
                let tkgalery = try JSONDecoder().decode(TKData.self, from: data!)
                let Resp = tkgalery.data.listGalleryHomeAndDetail.Response[0]


                    for AlbumA in Resp.AlbumMedias {
                        let tkgArr = TKGArr()

                        tkgArr.descriptonP = AlbumA.Description.replacingOccurrences(of: "</p>", with:"")
                        tkgArr.imgP = AlbumA.Image
                        tkgArr.titleP = AlbumA.Title
                        self.TKGArray.append(tkgArr)
                    }
                
                

           
                DispatchQueue.main.async {
                    self.collectionViv.reloadData()
                    
                }
            }catch{
                print(error)
            }

        }.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TKGArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViv.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCollectionViewCell
        
        cell.detailLbl.text = self.TKGArray[indexPath.item].descriptonP?.replacingOccurrences(of: "<p>", with: "")
        cell.img.downloadImage(from: self.TKGArray[indexPath.item].imgP!)
        return cell
    }


    
}

extension UIImageView {
    func downloadImage (from url: String){
        let urlRequest = URLRequest(url:URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlresponse, error) in
            if error != nil {print(error!); return}
            
            DispatchQueue.main.async
                {
                    self.image = UIImage(data:data!)
            }
        }
        task.resume()
    }
}



