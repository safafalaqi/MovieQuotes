//
//  MovieCollectionViewController.swift
//  Movie Quotes
//
//  Created by Safa Falaqi on 21/12/2021.
//

import UIKit

private let reuseIdentifier = "Cell"
var selectedMovies = [Movie]()
var suggestionsArray = [String]()
var movies:[Movie] = DataLoader().movieData //list of movies from the json file data.json

class MovieCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
   

    
    let inset: CGFloat = 10
        let minimumLineSpacing: CGFloat = 10
        let minimumInteritemSpacing: CGFloat = 10
        let cellsPerRow = 5
    let margin: CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

           flowLayout.minimumInteritemSpacing = margin
           flowLayout.minimumLineSpacing = margin
           flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        // swipe gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        createSugesstionList()
    }
    func createSugesstionList(){
        for m in  movies{
            suggestionsArray.append(m.movie)
           
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

                if selectedMovies.count > 0 {
                    performSegue(withIdentifier: "toQuiz", sender: self)
                }else{
                    let alert = UIAlertController(title: "No Movies Selected !", message: "Select movies from the collection to start the quiz" , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return minimumLineSpacing
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return minimumInteritemSpacing
       }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3   //number of column
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(3 - 1))
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(3))
            return CGSize(width: size, height: size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           collectionView?.collectionViewLayout.invalidateLayout()
           super.viewWillTransition(to: size, with: coordinator)
       }

  

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        // Configure the cell
        cell.label.text = movies[indexPath.row].movie
        cell.image.image = UIImage(named: movies[indexPath.row].image)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        //here make a light blue stroke for the selected cell
        if cell!.layer.borderColor == UIColor.systemTeal.cgColor{
            cell?.layer.borderColor = UIColor.clear.cgColor
            c.label.textColor = UIColor.black
            selectedMovies.removeAll { m -> Bool in
                return m.movie == movies[indexPath.row].movie
            }
            print("delete \(movies[indexPath.row].movie)")
        }else{
            cell?.layer.borderColor = UIColor.systemTeal.cgColor
            cell?.layer.borderWidth = 5
            c.label.textColor = UIColor.systemTeal
            //here when selected add it to the selected list
            selectedMovies.append(movies[indexPath.row])
            print("append \(movies[indexPath.row].movie)")
        }
    }


}
