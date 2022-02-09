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

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray
        return scrollView
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
    
    lazy var dataTextView: UITextView = {
        let textView = UITextView()
        textView.text = "데이터 대기.."
        return textView
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
    }

    private func setupUI() {

        // MARK: addSubview
        view.addSubview(scrollView)
        scrollView.addSubview(postButton)
        scrollView.addSubview(dataTextView)
        scrollView.addSubview(getButton)
        scrollView.addSubview(testButton)

        // MARK: setupLayout
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        postButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(100)
            $0.centerX.equalTo(scrollView)
        }
        
        dataTextView.snp.makeConstraints {
            $0.top.equalTo(postButton).inset(400)
            $0.width.equalTo(300)
            $0.height.equalTo(300)
            $0.centerX.equalTo(scrollView)
        }

        getButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(1000)
            $0.width.equalTo(150)
            $0.height.equalTo(100)
            $0.centerX.equalTo(scrollView)
        }

        testButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2000)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(100)
            $0.centerX.equalTo(scrollView)
        }


    }

    func fetchData(completion: @escaping (Result<[Record], Error>) -> Void) {

            let url = "https://staging.onionsapp.com/record/record/"
            // todo 테스트
    //         let url = "https://jsonplaceholder.typicode.com/todos/1"
            

    //        let header: HTTPHeaders = ["key": "93f6a8b64495daef8e68dcd3177a8f867c66315a"]

            AF.request(url,
                       method: .get
    //                   parameters: param
    //                   headers: header
            )
            .responseJSON { response in
                switch response.result {
                case .success:

                    guard let res = response.data else { return }

                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let json = try decoder.decode(Records.self, from: res)
                        
//                        guard let finalData = json.results else { return }
//
                        let recordData = json.results.map { data in
                            guard let id = data.id,
                                  let name = data.name,
                                  let survey = data.survey,
                                  let title = data.title,
                                  let unit = data.unit,
                                  let type = data.type else { return }
                            
                            var recordInfo: Record = Record(id: id, name: name, survey: survey, title: title, type: type, unit: unit)
                            
                            dump(recordInfo)
                            print("recordInfo:", recordInfo)
                            
                            print("id:",id, "name:",name, "survey:",survey, "title:",title, "unit:",unit, "type:",type)
                            
                        }
                        
                        
//                        let surveyData = recordData.map { data in
//
//                            print("survey:", data)
//                        }
                        
                        print("recordData:", recordData)
//                        print("surveyData:", surveyData)
                        

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



    func showData() {

//        Service.shared.fetchData { data in
//            print("completion 데이터 가져오나!? : \(data)")
//        }

    }

    func postTest() {
        // ocr 테스트서버
        let url = "http://dev2.arasoft.kr:18080/okra-app-v1/ocrTest"

        let params = ["username": "테스트",
                      "email": "1@23.com",
                      "password": "123123"]

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
                    print("data: \(data)")
                    self.dataTextView.text = "\(data)"
    //                    if let data = data as? [String: Any] {
    //                        print("Get 성공:  \(data)")
    //                    }
                case .failure(let err):
                    print("get Error: \(err.localizedDescription)")
                }
            }

    }

    @objc func tappedPostButton() {
        print("Post 버튼 눌림")
        postTest()
    }

    @objc func tappedGetButton() {
        fetchData { data in
            print("data: \(data)")
        }
    }

    @objc func tappedTestButton() {
        showData()
    }
}
