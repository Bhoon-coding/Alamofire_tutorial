//
//  ViewController.swift
//  AlamofirePractice
//
//  Created by BH on 2021/10/29.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    
    lazy var viewWrapper: UIView = {
       let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.391511023, green: 0.4367037416, blue: 0.4872434139, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.setTitle("POST(로그인)", for: .normal)
        button.setTitleColor(.white , for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.addTarget(self, action: #selector(tappedPostButton), for: .touchUpInside)
        return button
    }()
    
    lazy var getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.white , for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.addTarget(self, action: #selector(tappedGetButton), for: .touchUpInside)
        return button
    }()
    
    lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("dataTest", for: .normal)
        button.setTitleColor(.white , for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        button.addTarget(self, action: #selector(tappedTestButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Networkings.shared.fetchTodoData { (result) in
//            print("Result ===>", result)
//        }
        setupUI()
//        getTest()

    }
    
    private func setupUI() {
        
        // MARK: addSubview
        self.view.addSubview(viewWrapper)
        self.view.addSubview(postButton)
        self.view.addSubview(getButton)
        self.view.addSubview(testButton)
        
        // MARK: setupLayout
        viewWrapper.snp.makeConstraints {
            $0.width.height.equalTo(300)
            $0.center.equalTo(self.view)
        }
        
        postButton.snp.makeConstraints {
            $0.top.equalTo(self.viewWrapper).offset(80)
            $0.width.equalTo(150)
            $0.centerX.equalTo(self.viewWrapper)
        }
        
        getButton.snp.makeConstraints {
            $0.top.equalTo(self.postButton).offset(80)
            $0.width.equalTo(80)
            $0.centerX.equalTo(self.viewWrapper)
        }
        
        testButton.snp.makeConstraints {
            $0.top.equalTo(self.getButton).offset(80)
            $0.width.equalTo(80)
            $0.centerX.equalTo(self.viewWrapper)
        }
        

    }
    
    func fetchData(completion: @escaping (Result<[Record], Error>) -> Void) {
            
            let url = "https://staging.onionsapp.com/record/record/"
            // todo 테스트
    //         let url = "https://jsonplaceholder.typicode.com/todos/1"
            // ocr 테스트서버
    //        let url = "http://dev2.arasoft.kr:18080/okra-app-v1/ocrTest"
            
    //        let header: HTTPHeaders = ["key": "93f6a8b64495daef8e68dcd3177a8f867c66315a"]
                  
            AF.request(url,
                       method: .get
    //                   parameters: param
    //                   headers: header
            )
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    print("response:", response)
                    guard let res = response.data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        let json = try decoder.decode(Records.self, from: res)
                        
                        debugPrint("데이터 디버그프린트:",json.results)
                        completion(.success(json.results))
                        
                        
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                    
                case .failure(let err):
                    print("Error: \(err.localizedDescription)")
                    completion(.failure(err))
                    return
                }
            }
          
        }

    
    
    func printData() {
        
//        Service.shared.fetchData { data in
//            print("completion 데이터 가져오나!? : \(data)")
//        }
        
    }
    
    func postTest() {
        
        let url = "https://staging.onionsapp.com/rest-auth/login/"

        let params = ["username": "bhooncoding",
                      "email": "bhooncoding@gmail.com",
                      "password": "bhbbbbbb"
                     ]
        
//        let headers: HTTPHeaders = ["Authorization": "Token:93f6a8b64495daef8e68dcd3177a8f867c66315a"]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default
//                   headers: headers
        )
//            .validate(statusCode: 200..<300)
            .responseJSON { res in
                switch res.result {
                case .success(let data):
                    if let data = data as? [String: Any] {
                        print("Get 성공:  \(data)")
                    }
                case .failure(let err):
                    print("get Error: \(err.localizedDescription)")
                }
            }

    }
    
    @objc func tappedPostButton() {
        postTest()
    }
    
    @objc func tappedGetButton() {
        fetchData { data in
            debugPrint("data: \(data)")
        }
    }
    
    @objc func tappedTestButton() {
        printData()
    }
}
