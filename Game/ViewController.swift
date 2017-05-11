//
//  ViewController.swift
//  Game
//
//  Created by Nhật Minh on 12/6/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var count: Int = 0 // gioi han so box
    var Items: NSMutableArray! // mang? chua' nhung vi tri dc chon. lam` box

    var index : Int = -1 // so index cua mang? moves
    
    var moves: [Int] = [] // mang? chua' nhung~ buoc' di chuyen?
    
    let n = 10 // so hang` va ` cot.
    
    let leftright: CGFloat = 25 // khoang cach so voi 2 mep trai phai
    
    let topbot: CGFloat = 100 // khoang cach so voi 2 mep tren duoi
    
    var robot = UIImageView()
    
    var vitri = 0
    
    var dot = UIImageView()
    
    var door = UIImageView()
    
    var imageSelected = UIImageView() // anh? o? vi. tri' luc minh` an' vao` de? doi? thanh` box
    
    var imageCenter = CGPoint.zero // luu vi tri ban dau` cua mui ten
    
    var len = UIImageView()
    
    var xuong = UIImageView()
    
    var trai = UIImageView()
    
    var phai = UIImageView()
    
    var arrow = UIImageView()
    
    var hightLightedImage = UIImageView()
    
    var timer = Timer()
    
    var x: CGFloat = 0
    
    var y: CGFloat = 40 
    
    var number: CGFloat = 0
    
    var running = false // de xet neu robot dang di chuyen hay khong
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBackGround()
        self.Items = NSMutableArray()
        makeArrows()
        makeDots()
        makeDoor()
        makeRobot()
        makeButton()
    }

    // CÁC HÀM BƯỚC DI CHUYỂN
    func moveLeft()
    {
        footPrint()
        if (vitri + 1) % n == 1
        {
            vitri = vitri * 1
            makeRobot()
        }
        else
        {
            vitri = vitri - 1
            makeRobot()
        }
    }
    
    func moveRight()
    {
        footPrint()
        if vitri + 1 == 10*n - 1
        {
            win()
        }
        else if (vitri - (n - 2)) % n == 1
        {
            vitri = vitri * 1
            makeRobot()
        }
        else
        {
            vitri = vitri + 1
            makeRobot()
        }
    }
    
    func moveUp()
    {
        footPrint()
        if vitri - 10 < 0
        {
            vitri = vitri * 1
            makeRobot()
        }
        else
        {
            vitri = vitri - 10
            makeRobot()
        }
        
    }
    
    func moveDown()
    {
        footPrint()
        
        if vitri + 10 == 10*n - 1
        {
            win()
        }
        else if vitri + 10 > 10*n - 1
        {
            vitri = vitri * 1
            makeRobot()
        }
        else
        {
            vitri = vitri + 10
            makeRobot()
        }
        
    }
    
    // CÁC HÀM TẠO HÌNH
    
    func makeRobot()
    {
        robot.tag = 100 + vitri
        
        if let robot1 = self.view.viewWithTag(100 + vitri) as? UIImageView
        {
            robot1.image = UIImage(named: "robot")
            robot1.tag = robot.tag
        }
        print(robot.tag)
    }
    
    func footPrint()
    {
        if let dot = self.view.viewWithTag(100 + vitri) as? UIImageView
        {
            dot.image = UIImage(named: "footprint")
        }
    }
    
    func makeDoor()
    {
        door.tag = 100 + ((10 * n) - 1)
        
        if let door1 = self.view.viewWithTag(100 + ((10 * n) - 1)) as? UIImageView
        {
            door1.image = UIImage(named: "door")
            
            door1.tag = door.tag
        }
    }
    
    func makeDots()
    {
        for hang in 0..<n
        {
            for cot in 0..<n
            {
                let image = UIImage(named: "dot")
                let dot = Item(image: image)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeBox(_:)))
                dot.addGestureRecognizer(tapGesture)
                dot.center = CGPoint(x: leftright + CGFloat(hang) * widthAction(), y: topbot + CGFloat(cot) * heightAction())
                dot.tag = hang + cot * n + 100
                dot.isUserInteractionEnabled = true
                dot.isBox = false
                self.Items.add(dot)
                self.view.addSubview(dot)
            }
        }
    }
    
    func widthAction() -> CGFloat
    {
        let width = ((self.view.bounds.size.width - 2*leftright)/CGFloat(n-1))
        
        return width
    }
    
    func heightAction() -> CGFloat
    {
        let height = ((self.view.bounds.size.height - 2*topbot)/CGFloat(n-1))
        
        return height
    }
    
    // CÁC HÀM TẠO PHÍM MŨI TÊN
    
    func makeUpArrow()
    {
        let rect1 = CGRect(x: 177, y: 601, width: 20, height: 20)
        let upImage = UIImage(named: "len")
        len = UIImageView(frame: rect1)
        len.image = upImage
        ableToTouch()
        let panGestureUp = UIPanGestureRecognizer(target: self, action: #selector(panMove(_:)))
        len.addGestureRecognizer(panGestureUp)
        len.tag = 500
        self.view.addSubview(len)
    }
    
    func makeLeftArrow()
    {
        let rect2 = CGRect(x: 149, y: 629, width: 20, height: 20)
        let leftImage = UIImage(named: "trai")
        trai = UIImageView(frame: rect2)
        trai.image = leftImage
        ableToTouch()
        let panGestureLeft = UIPanGestureRecognizer(target: self, action: #selector(panMove(_:)))
        trai.addGestureRecognizer(panGestureLeft)
        trai.tag = 501
        self.view.addSubview(trai)
    }
    
    func makeDownArrow()
    {
        let rect3 = CGRect(x: 177, y: 629, width: 20, height: 20)
        let downImage = UIImage(named: "xuong")
        xuong = UIImageView(frame: rect3)
        xuong.image = downImage
        ableToTouch()
        let panGestureDown = UIPanGestureRecognizer(target: self, action: #selector(panMove(_:)))
        xuong.addGestureRecognizer(panGestureDown)
        xuong.tag = 502
        self.view.addSubview(xuong)
    }
    
    func makeRightArrow()
    {
        let rect4 = CGRect(x: 205, y: 629, width: 20, height: 20)
        let rightImage = UIImage(named: "phai")
        phai = UIImageView(frame: rect4)
        phai.image = rightImage
        let panGestureRight = UIPanGestureRecognizer(target: self, action: #selector(panMove(_:)))
        phai.addGestureRecognizer(panGestureRight)
        ableToTouch()
        phai.tag = 503
        self.view.addSubview(phai)
    }
    
    func createMoveArrow(imgName: String, posX: CGFloat, posY: CGFloat)->UIButton{
        let Button = UIButton()
        Button.frame = CGRect(x: posX, y: posY, width: 20, height: 20)
        Button.setImage(UIImage(named: imgName), for: .normal)
        
        view.addSubview(Button)
    
    }
    
    func
    
    
    func makeArrows()
    {
        makeUpArrow()
        makeDownArrow()
        makeLeftArrow()
        makeRightArrow()
    }
    
    //HÀM TẠO COPY CÁC PHÍM MŨI TÊN
    func makeCopies(named: String)
    {
        if x + number <= 300 && y <= 56
        {
            let rect = CGRect(x: x + number , y: y , width: 15, height: 15)
            let Image = UIImage(named: named)
            arrow = UIImageView(frame: rect)
            arrow.image = Image
            self.view.addSubview(arrow)
        }
        else if x + number > 300 && y <= 56
        {
            y = y + 16
            x = 16
            number = 0
            let rect = CGRect(x: x + number , y: y , width: 15, height: 15)
            let Image = UIImage(named: named)
            arrow = UIImageView(frame: rect)
            arrow.image = Image
            self.view.addSubview(arrow)
        }
        else
        {
            // Đạt độ dài tối đa thì không append thêm số vào mảng nữa
            moves.removeLast()
        }
    }
    
    // CÁC HÀM GẮN UIGESTURERECOGNIZER
    
    func makeBox(_ tapGesture: UITapGestureRecognizer)
    {
        if running
        {
            // do nothing
        }
        else
        {
            count += 1
            
            if count <= 7
            {
            let tagView = tapGesture.view?.tag
            
            if let imageSelected = self.view.viewWithTag(tagView!) as? Item
            {
                if tagView! == door.tag || tagView! == robot.tag
                {
                    // chả làm gì cả
                }
                else
                {
                    imageSelected.image = UIImage(named: "box")
                    imageSelected.isBox = true
                    imageSelected.isUserInteractionEnabled = false
                }
            }
            }
            else
            {
                // do nothing
            }
            
        }
        
    }
    
    func panMove(_ panGesture: UIPanGestureRecognizer)
    {
        if running
        {
            
        }
        else
        {
            let tagView2 = panGesture.view?.tag
            if let selectedImage = self.view.viewWithTag(tagView2!) as? UIImageView
            {
                
                if panGesture.state == .began
                {
                    number = number + 16
                    
                    if selectedImage.tag == 500
                    {
                        imageCenter = selectedImage.center
                        moves.append(0)
                        makeUpArrow()
                    }
                    else if selectedImage.tag == 501
                    {
                        imageCenter = selectedImage.center
                        moves.append(1)
                        makeLeftArrow()
                    }
                    else if selectedImage.tag == 502
                    {
                        imageCenter = selectedImage.center
                        moves.append(2)
                        makeDownArrow()
                    }
                    else
                    {
                        imageCenter = selectedImage.center
                        moves.append(3)
                        makeRightArrow()
                    }
                }
                else if panGesture.state == .changed
                {
                    selectedImage.center = panGesture.location(in: view)
                }
                else
                {
                    
                    if selectedImage.tag == 500
                    {
                        makeCopies( named: "len")
                        selectedImage.center = imageCenter
                        
                        
                    }
                    else if selectedImage.tag == 501
                    {
                        makeCopies(named: "trai")
                        selectedImage.center = imageCenter
                        
                    }
                    else if selectedImage.tag == 502
                    {
                        
                        makeCopies( named: "xuong")
                        selectedImage.center = imageCenter
                        
                    }
                    else
                    {
                        
                        makeCopies( named: "phai")
                        selectedImage.center = imageCenter
                        
                    }
                }
                
            }
        }
        
    }
    
    // HÀM ĐỌC DỮ LIỆU TRONG MẢNG ĐỂ DI CHUYỂN
    
    func makeWay()
    {
        
        index = index + 1
        
        number = number + 16
        
        if index == moves.count && vitri != 10 * n - 1
        {
            timer.invalidate()
            lost()
        }
        else
        {
            if moves[index] == 0
            {
                moveUp()
                makeCopies(named: "lenhighlighted")
            }
            else if moves[index] == 1
            {
                moveLeft()
                makeCopies(named: "traihighlighted")
            }
            else if moves[index] == 2
            {
                moveDown()
                makeCopies(named: "xuonghighlighted")
            }
            else
            {
                moveRight()
                makeCopies(named: "phaihighlighted")
            }
            
            check()
            
        }
        
        
    }
    
    // MỘT VÀI CHỨC NĂNG PHỤ
    
    func lost()
    {
        alertBox(" " , "YOU LOST!", "Restart")
        timer.invalidate()
    }
    
    func win()
    {
        alertBox(" " , "YOU WIN!", "Restart")
        timer.invalidate()
    }
    
    func alertBox(_ title: String,_ message: String,_ actionTitle: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: {action in self.resetGame()})
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func resetGame()
    {
        
        for v in view.subviews{
            if v is UIImageView{
                v.removeFromSuperview()
            }
        }
        drawBackGround()
        Items.removeAllObjects()
        running = false
        rsValue()
        makeArrows()
        makeDots()
        makeDoor()
        footPrint()
        makeRobot()
        moves.removeAll()
        makeButton()
    }
    
    
    func ableToTouch()
    {
        len.isUserInteractionEnabled = true
        trai.isUserInteractionEnabled = true
        xuong.isUserInteractionEnabled = true
        phai.isUserInteractionEnabled = true
    }
    
    func rsValue()
    {
        count = 0
        x = 0
        y = 40
        number = 0
        index = -1
        vitri = 0
    }
    
    
    func check()
    {
        for box in Items
        {
            if  let item  = box as? Item
            {
                
                if (robot.tag == item.tag && item.isBox == true)
                {
                    playSong()
                    lost()
                }
                
            }
        }
    }

    
    
    func drawBackGround()
    {
        let background = UIImageView(image: UIImage(named: "background"))
        background.frame = self.view.bounds
        background.contentMode = .scaleToFill
        self.view.addSubview(background)
    }
    
    
    
    
    
    func makeButton()
    {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 331, y: 30, width: 40, height: 40)
        button.setBackgroundImage(UIImage(named: "running"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    func buttonAction(sender: UIButton)
    {
        sender.isEnabled = false
        running = true
        rsValue()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(makeWay), userInfo: nil, repeats: true)
        
    }
    
    
    func playSong()
    {
        let filePath = Bundle.main.path(forResource: "stupiddog", ofType: ".mp3")
        
        let url = NSURL(fileURLWithPath: filePath!)
        
        audioPlayer = try! AVAudioPlayer(contentsOf: url as URL)
        
        audioPlayer.prepareToPlay()
        
        audioPlayer.play()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

