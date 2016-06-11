import Cocoa

class PonyDServer: NSObject {

    let task = NSTask()

    func startServer() {
        let outputPipe = NSPipe()

        task.launchPath = "/usr/local/bin/ponyd"
        let arguments = ["serve", "--listen-interface=127.0.0.1"]

        task.arguments = arguments
        task.launch()

        let notifications = NSNotificationCenter.defaultCenter()
        task.standardOutput = outputPipe;

        notifications.addObserver(self, selector: #selector(outputAvailable), name: NSFileHandleDataAvailableNotification, object: outputPipe.fileHandleForReading)
        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotifyForModes([NSDefaultRunLoopMode, NSEventTrackingRunLoopMode])

        let errorPipe = NSPipe()
        task.standardError = errorPipe;

        notifications.addObserver(self, selector: #selector(outputAvailable), name: NSFileHandleDataAvailableNotification, object: outputPipe.fileHandleForReading)
        errorPipe.fileHandleForReading.waitForDataInBackgroundAndNotifyForModes([NSDefaultRunLoopMode, NSEventTrackingRunLoopMode])
    }

    func stop() {
        task.terminate()
        task.waitUntilExit()

        let killAll = NSTask()
        killAll.launchPath = "/usr/bin/killall"
        killAll.arguments = ["ponyd"]
        killAll.launch()
        killAll.waitUntilExit()
    }

    func outputAvailable(notification: NSNotification) {
        guard let fileHandle = notification.object as? NSFileHandle else { return }
        let data = fileHandle.availableData

        if data.length > 0 {
            let output = NSString(data: data, encoding: NSUTF8StringEncoding)
            print(output)
        }
    }
}
