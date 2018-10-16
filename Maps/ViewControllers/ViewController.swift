
import UIKit

class ViewController: UIViewController {
  
  private var animator: DraggableTransitionDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let locationsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationsViewController") as? LocationsViewController else { return }
    
    animator = DraggableTransitionDelegate(viewControllerToPresent: locationsViewController, presentingViewController: self)
    locationsViewController.transitioningDelegate = animator
    locationsViewController.modalPresentationStyle = .custom
    
    present(locationsViewController, animated: true)
  }
}


