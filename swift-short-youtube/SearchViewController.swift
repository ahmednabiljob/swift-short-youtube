//
//  SearchViewController.swift
//  swift-short-youtube
//
//  Created by Ahmed on 3/12/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class SearchViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    let transition = CircularTransition()
    var videoArray = [Video]()
    var selectedVideoID:String = ""
    var selectedVideoTitle:String = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    
    @IBAction func signOutButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true){
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchBar.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = self.view.center
        transition.circleColor = .lightGray
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.view.center
        transition.circleColor = .red
        
        return transition
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Video"{
            //print("preparing..")
            
            if let videoController = segue.destination as? VideoViewController{
                print("preparing for segue .... ")
                videoController.videoID = selectedVideoID
                videoController.videoTitle = selectedVideoTitle
                videoController.transitioningDelegate=self
                videoController.modalPresentationStyle = .custom
            }
            else{
                print("Something not right")
            }
        }
    }
    

}




extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VideoTableViewCell
        cell.videoTitleLabel.text = self.videoArray[indexPath.row].videoTitle
        cell.videoImageView.kf.setImage(with: URL(string: self.videoArray[indexPath.row].imageUrlString))
        return cell        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideoID = self.videoArray[indexPath.row].videoUrlString
        selectedVideoTitle = self.videoArray[indexPath.row].videoTitle
        //print("seque starting .. ")
        /*let storyBoard = UIStoryboard(name: "Main", bundle: nil )
        let videoController = storyBoard.instantiateViewController(withIdentifier: "Video") as! VideoViewController
        videoController.videoID = selectedVideoID
        videoController.videoTitle = selectedVideoTitle*/
        performSegue(withIdentifier: "Video", sender: self)
        
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    /*func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }*/
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            let videoObj = VideoHelper(keyword: text)
            
            videoObj.fetchVideos{
                data in
                self.videoArray = data
                //print("here is the count \(self.videoArray[0].videoTitle)")
                self.searchTableView.reloadData()
                
            }
        }

        
    }
}





