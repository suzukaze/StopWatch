import Cocoa

class ViewController: NSViewController {
    var startDate : NSDate!
    var timer : NSTimer!
    var elapsedTime : NSTimeInterval!
    var tempElapsedTime : NSTimeInterval!
    
    @IBOutlet weak var timeText: NSTextField!
    @IBOutlet weak var leftButton: NSButton!
    @IBOutlet weak var rightButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTimer()
        initButton()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func initTimer() {
        timeText.stringValue = "00:00:00.0"
        elapsedTime = 0
        tempElapsedTime = 0
    }
    
    func initButton() {
        leftButton.hidden = true
        rightButton.hidden = false
        rightButton.title = "スタート"
        rightButton.action = #selector(ViewController.clickStart)
    }
    
    func update() {
        tempElapsedTime = NSDate().timeIntervalSinceDate(startDate)
        var date = NSDate(timeIntervalSince1970: tempElapsedTime)
        date = date.dateByAddingTimeInterval(elapsedTime)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "GMT")
        dateFormatter.dateFormat = "HH:mm:ss.S"
        
        timeText.stringValue = dateFormatter.stringFromDate(date)
    }
    
    func clickStart() {
        startDate = NSDate()
        startTimer()
        leftButton.hidden = true
        changeRightButtonNameAndVisible("ストップ")
        rightButton.action = #selector(ViewController.clickStop)
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    func clickStop() {
        stopTimer()
        changeLeftButtonNameAndVisible("リセット")
        changeRightButtonNameAndVisible("リスタート")
        leftButton.action = #selector(ViewController.clickReset)
        rightButton.action = #selector(ViewController.clickRestart)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func clickRestart() {
        restartTimer()
        leftButton.hidden = true
        changeRightButtonNameAndVisible("ストップ")
        rightButton.action = #selector(ViewController.clickStop)
    }
    
    func restartTimer() {
        var elapsedTimeDouble : Double = elapsedTime as Double
        let tempElapseTimeDouble : Double = tempElapsedTime as Double
        elapsedTimeDouble += tempElapseTimeDouble
        elapsedTime = elapsedTimeDouble as NSTimeInterval
        startDate = NSDate()
        startTimer()
    }
    
    func clickReset() {
        initTimer()
        initButton()
    }
    
    func changeLeftButtonNameAndVisible(title : String) {
        leftButton.title = title
        leftButton.hidden = false
    }
    
    func changeRightButtonNameAndVisible(title : String) {
        rightButton.title = title
        rightButton.hidden = false
    }
}

