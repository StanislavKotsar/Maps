
import UIKit

class LocationsTableViewCell: UITableViewCell {
  @IBOutlet weak var locationIcon: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
}

private struct LocationData {
  let title: String
  let subtitle: String
  let imgString: String
  
  static var `default`: [LocationData] {
    return [
      LocationData(title: "Mozirje", subtitle: "Mozirje", imgString: "locationIcon"),
      LocationData(title: "641 St Peters Ave", subtitle: "641 St Peters Ave, Brooklyn", imgString: "locationIcon"),
      LocationData(title: "Nassau St", subtitle: "122 Nassau St, New York", imgString: "searchIcon"),
      LocationData(title: "1115 Apple Ave", subtitle: "San Francisco", imgString: "searchIcon"),
      LocationData(title: "Facebook NY Office", subtitle: "San Francisco", imgString: "searchIcon"),
      LocationData(title: "Mary Turner", subtitle: "Directions from My Location", imgString: "directionIcon"),
      LocationData(title: "Hannah Logan's Location", subtitle: "Directions from My Location", imgString: "directionIcon"),
      LocationData(title: "Mom's Location", subtitle: "Directions from My Location", imgString: "directionIcon"),
      LocationData(title: "Target Location", subtitle: "Directions from My Location", imgString: "directionIcon")
    ]
  }
}

class LocationsViewController: UIViewController {
  
  @IBOutlet weak var handleView: UIView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var tableView: UITableView!

  @IBOutlet weak var containerViewWidth: NSLayoutConstraint!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // I know it's bad I will fix it later
    containerView.frame = CGRect(x: containerView.frame.minX, y: containerView.frame.minY, width: UIScreen.main.bounds.width, height: containerView.frame.height)
    setUpViews()
  }

    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func setUpViews() {
    handleView.layer.cornerRadius = 2.5
    containerView.round(corners: [.topLeft, .topRight], radius: 8)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    tableView.isUserInteractionEnabled = false
  }
}

extension LocationsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return LocationData.default.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapsCell", for: indexPath) as? LocationsTableViewCell else { return UITableViewCell() }
    
    let data = LocationData.default[indexPath.row]
    cell.titleLabel.text = data.title
    cell.subtitleLabel.text = data.subtitle
    cell.locationIcon.image = UIImage(named: data.imgString)!
    return cell
  }
}

extension LocationsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

extension LocationsViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    guard let draggablePresentation = presentationController as? DraggablePresentationController else { return }
    draggablePresentation.animateToOpen()
    searchBar.resignFirstResponder() // Remove keyboard so that it doesn't get in the way
  }
}

