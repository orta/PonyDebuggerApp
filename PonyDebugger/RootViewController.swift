import Cocoa

class RootViewController: NSViewController {

    let server = PonyDServer()

    override func viewDidLoad() {
        super.viewDidLoad()
        server.startServer()
    }
    
}
