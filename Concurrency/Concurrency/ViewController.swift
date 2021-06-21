//
//  ViewController.swift
//  Concurrency
//
//  Created by Doron Feldman on 14/10/2020.
//

import UIKit

class ViewController: UIViewController  {
    var data: ThreadSafeArray<String> = ThreadSafeArray<String>()
    
    @IBOutlet weak var logTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        logTableView.delegate = self
        logTableView.dataSource = self
    }

    @IBAction func runButtonClicked(_ sender: Any) {
        data.clear()
        
        barzelimThreading()
//        dispatchQueueConcurrency()
//        dispatchQueueConcurrencyWithDiffrentQos()
//        dispatchQueueConcurrencySync()
//        definingOurOwnQueues()
//        dispatchSerialQueue1()
//        dispatchSerialQueue2()
//        dispatchAfter()
//        dispatchBarrier()
//        dispatchGroup1()
//        dispatchGroup2()
//        workItemWithCancelation()
        
//        cannotSyncInsideAsync()
//        cannotSyncMainQueue()
    }
    
    // MARK: barzelimThreading
    
    let lock = NSLock()
    let semaphore = DispatchSemaphore(value: 0)
    
    func barzelimThreading() {
        let aThread = Thread {
            for i in 1...10 {
                self.lock.lock()
                self.data.append("🐶 \(i)")
                self.lock.unlock()
                usleep(1)
            }
            self.semaphore.signal()
        }
        
        let bThread = Thread {
            for i in 1...10 {
                self.lock.lock()
                self.data.append("🐱 \(i)")
                self.lock.unlock()
                usleep(1)
            }
            self.semaphore.signal()
        }
        
        aThread.start()
        bThread.start()
        
        semaphore.wait()
        semaphore.wait()
        logTableView.reloadData()
    }
    
    // MARK: dispatchQueueConcurrency
    
    func dispatchQueueConcurrency() {
        DispatchQueue.global().async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            self.reloadTableView()
        }
        
        DispatchQueue.global().async {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            self.reloadTableView()
        }
    }
    
    // MARK: dispatchQueueConcurrencyWithDiffrentQos
    
    func dispatchQueueConcurrencyWithDiffrentQos() {
        DispatchQueue.global(qos: .background).async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            self.reloadTableView()
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            self.reloadTableView()
        }
    }
    
    // MARK: dispatchQueueConcurrencySync
    
    func dispatchQueueConcurrencySync() {
        print("thread: \(Thread.current)")
        
        DispatchQueue.global().sync {
            print("🐶 thread: \(Thread.current)")
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
        }
        
        DispatchQueue.global().sync {
            print("🐱 thread: \(Thread.current)")
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
        }
        
        // The reload here is diffrent
        self.logTableView.reloadData()
    }
    
    
    // MARK: definingOurOwnQueues
    
    let ourOwnQueue = DispatchQueue(label: "ourOwnQueue", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
    
    func definingOurOwnQueues() {
        ourOwnQueue.async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            self.reloadTableView()
        }
        
        ourOwnQueue.async {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            self.reloadTableView()
        }
        
        ourOwnQueue.activate()
    }
    
    
    // MARK: dispatchSerialQueue
    
    let ourOwnSerialQueue = DispatchQueue(label: "ourOwnSerialQueue", qos: .userInitiated, attributes: [])
    
    func dispatchSerialQueue1() {
        ourOwnSerialQueue.async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            self.reloadTableView()
        }
        
        ourOwnSerialQueue.async {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            self.reloadTableView()
        }
    }
    
    
    let ourOwnSerialForwardingQueue = DispatchQueue(label: "ourOwnSerialForwardingQueue", attributes: [], target: DispatchQueue.global(qos: .userInitiated))
    
    func dispatchSerialQueue2() {
        ourOwnSerialForwardingQueue.async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            self.reloadTableView()
        }
        
        ourOwnSerialForwardingQueue.async {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            self.reloadTableView()
        }
    }
    
    // MARK: dispatchAfter
    
    func dispatchAfter() {
        for i in 1...10 {
            DispatchQueue.global().asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(i)) {
                self.data.append("🐙 \(i)")
                self.reloadTableView()
            }
        }
    }
    
    // MARK: dispatchBarrier
    
    let dispatchBarrierQueue = DispatchQueue(label: "dispatchBarrierQueue", qos: .userInitiated, attributes: [.concurrent])
    
    func dispatchBarrier() {
        dispatchBarrierQueue.async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            self.reloadTableView()
        }
        
        dispatchBarrierQueue.async {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            self.reloadTableView()
        }
        
        // Let's try the same now with this in the middle
        dispatchBarrierQueue.async(flags: [.barrier]) {
            for i in 1...10 {
                self.data.append("🐙 \(i)")
            }
            self.reloadTableView()
        }
    }
    
    // MARK: dispatchGroup
    
    let dispatchGroupQueue = DispatchQueue(label: "dispatchGroupQueue", qos: .userInitiated, attributes: [.concurrent])
    
    func dispatchGroup1() {
        let group = DispatchGroup()
        group.enter()
        dispatchGroupQueue.async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            group.leave()
        }
        
        group.enter()
        dispatchGroupQueue.async {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            group.leave()
        }
        
        dispatchGroupQueue.async {
            group.wait()
            self.data.append("FINISHED!")
            self.reloadTableView()
        }
    }
    
    func dispatchGroup2() {
        let group = DispatchGroup()
        dispatchGroupQueue.async(group: group) {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
        }
        
        group.notify(queue: dispatchGroupQueue) {
            self.data.append("FINISHED!")
            self.reloadTableView()
        }
    }
    
    // MARK: workItemWithCancelation
    
    func workItemWithCancelation() {
        ourOwnSerialQueue.async {
            for i in 1...10 {
                self.data.append("🐶 \(i)")
            }
            self.reloadTableView()
            sleep(1) 
        }
        
        // This is the same task as before, only in an WorkItem
        let item = DispatchWorkItem(block: {
            for i in 1...10 {
                self.data.append("🐱 \(i)")
            }
            self.reloadTableView()
            sleep(1)
        })
        ourOwnSerialQueue.async(execute: item)
        
        ourOwnSerialQueue.async {
            for i in 1...10 {
                self.data.append("🐙 \(i)")
            }
            self.reloadTableView()
            sleep(1)
        }
        
        // Let's try adding sleep here
//        sleep(3)
        item.cancel()
    }
    
    // MARK: cannotSyncInsideAsync
    
    func cannotSyncInsideAsync() {
        ourOwnSerialQueue.async {
            self.ourOwnSerialQueue.sync {
                // It's gonna crash :)
            }
        }
    }
    
    // MARK: cannotSyncMainQueue
    
    func cannotSyncMainQueue() {
        DispatchQueue.main.sync {
            // It's gonna crash :)
        }
    }
}


// MARK: UITableViewDelegate extension
extension ViewController: UITableViewDelegate {
}


// MARK: UITableViewDataSource extension
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = logTableView.dequeueReusableCell(withIdentifier: "logTableCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}


// MARK: reloadTableView
extension ViewController {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.logTableView.reloadData()
        }
    }
}
