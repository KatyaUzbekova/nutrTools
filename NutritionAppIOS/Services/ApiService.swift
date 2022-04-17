//
//  ApiService.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//
import Alamofire
import SwiftKeychainWrapper
import Foundation


protocol ApiServiceProtocol: class {
    func getAllUserInfo(completion: @escaping (UserProfileModel?, Error?) -> Void)
    func getAllReportsJson(completion: @escaping (ArrayReportsModel?, Error?) -> Void)
}

class ApiService {
    static let shared = ApiService()
    
    private lazy var headers: HTTPHeaders = [
        "access-token": KeychainWrapper.standard.string(forKey: "accessToken")!,
        "vendor": "iphone",
        "client_version": "10000",
        "platform_name": "ios",
        "flavor_name": "client"
    ]
    func headersToPost(content_type: String) -> HTTPHeaders {
        let headersPosting: HTTPHeaders = [
            "access-token": KeychainWrapper.standard.string(forKey: "accessToken")!,
            "vendor": "iphone",
            "client_version": "10000",
            "platform_name": "ios",
            "flavor_name": "client",
            "Content-type": content_type
        ]
        return headersPosting
    }
    
    private let urlSelfUserProfileInfoURL = "https://nutrtools.info:8443/api/v1/auth/users/self"
    private let getAllMeasurementsURL = "https://nutrtools.info:8443/api/v1/measurements/measures"
    
  //  private let reportURL = "https://nutrtools.info:8443/api/v1/cabinet/report"
    private let reportURL = "https://nutrtools.info:8443/api/v1/cabinet/report"

    private let getAllMyNutritionsURL = "https://nutrtools.info:8443/api/v1/cabinet/nutritionistInteraction"
    private let bookNutritionistURL = "https://nutrtools.info:8443/api/v1/cabinet/nutritionist?nutritionistId="
    private let getAllNutritionistURL = "https://nutrtools.info:8443/api/v1/cabinet/nutritionists"
    private let getNutritionistsDataURL = "https://nutrtools.info:8443/api/v1/cabinet/nutritionistDetailed?nutritionistId="
    private let setAvatarURL = "https://nutrtools.info:8443/api/v1/auth/users/avatar"
    private let getChatsListURL = "https://nutrtools.info:8443/api/v1/chats/userChats"
    
    
    //MARK: transformations
    private let getTransformtaion = "https://nutrtools.info:8443/api/v1/transformation/transformation"
    
    
    private let logInUserURL = "https://nutrtools.info:8443/api/v1/auth/users/login"
    private let registrationURL = "https://nutrtools.info:8443/api/v1/auth/users/registration"
    
    private let openAgreementURL = "https://nutrtools.info:8443/api/v1/auth/users/agreement"
    private let getAllProductsByDate = "https://nutrtools.info:8443/api/v1/cpfc/mealDiary?date="
    
    private let getWaterByDateURL = "https://nutrtools.info:8443/api/v1/cpfc/water"
    private let searchRequestURL = "https://nutrtools.info:8443/api/v1/cpfc/cpfcSuggester?name="
    
    func searchRequest(with name: String, completion: @escaping (_ searchResults: SearchResultsModel?, Error?) -> Void) {
        let escapedString = (searchRequestURL+name).addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        AF.request(escapedString!, method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func postWater(parameters: WaterParameters, completion: @escaping (_ waterData: String?, Error?) -> Void) {
        AF.request(getWaterByDateURL, method : .post, parameters : parameters.dictionary!, encoding : JSONEncoding.default , headers : headersToPost(content_type: "application/json")).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func getWater(completion: @escaping (_ waterData: WaterParameters?, Error?) -> Void) {
        let parameters = ["date": "11-06-2021 23:51"]
        AF.request(getWaterByDateURL, method : .get, parameters : parameters, encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            print(String(bytes: dataResponse.data!, encoding: .utf8))
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    func getAllProductsByDateRequest(date: String) {
        AF.request(getAllProductsByDate + "\(date)", method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
        //    self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    func openAgreementRequest(completion: @escaping (_ agreement: DocumentsModel?, Error?) -> Void) {
        let tempHeaders: HTTPHeaders = [
            "vendor": "iphone",
            "client_version": "10000",
            "platform_name": "ios",
            "flavor_name": "client"
        ]
        
        AF.request(openAgreementURL, method : .get, parameters : [:], encoding : URLEncoding.default , headers : tempHeaders).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func registrationRequest(parameters: [String:Any], completion: @escaping (_ userModel: UserProfileModelRegistration?, Error?) -> Void) {
        registrationRequestPrivate(parameters: parameters, completion: completion)
    }
    
    private func registrationRequestPrivate(parameters: [String:Any], completion: @escaping (_ userModel: UserProfileModelRegistration?, Error?) -> Void) {
        let tempHeaders: HTTPHeaders = [
            "Content-type": "application/json",
            "vendor": "iphone",
            "client_version": "10000",
            "platform_name": "ios",
            "flavor_name": "client"
        ]
        
        AF.request(registrationURL, method : .post, parameters : parameters, encoding : JSONEncoding.default , headers : tempHeaders).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func logInUserRequest(parameters: [String:String], completion: @escaping (_ userModel: UserProfileModelLogin?, Error?) -> Void) {
        logInUserRequestPrivate(parameters: parameters, completion: completion)
    }
    
    private func logInUserRequestPrivate(parameters: [String:String], completion: @escaping (_ userModel: UserProfileModelLogin?, Error?) -> Void) {
        let tempHeaders: HTTPHeaders = [
            "Content-type": "application/json",
            "vendor": "iphone",
            "client_version": "10000",
            "platform_name": "ios",
            "flavor_name": "client"
        ]
        AF.request(logInUserURL, method : .post, parameters : parameters, encoding : JSONEncoding.default , headers : tempHeaders).responseData { dataResponse in
            //   print(String(bytes: dataResponse.data!, encoding: .utf8))
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    func getParticularChatHistory(chatId: String, nutritionistId: String, completion: @escaping (_ userModel: MessageModel?, Error?) -> Void) {
        let getChatHistory = "https://nutrtools.info:8443/api/v1/chats/userMessages?chatId=\(chatId)&nutritionistId=\(nutritionistId)"
        print(headers)
        getParticularChatHistoryPrivate(link: getChatHistory, completion: completion)
    }
    
    private func getParticularChatHistoryPrivate(link: String,completion: @escaping (_ userModel: MessageModel?, Error?) -> Void) {
        AF.request(link, method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    func getChatsListRequest(completion: @escaping (_ userModel: ChatListItemsModel?, Error?) -> Void) {
        AF.request(getChatsListURL, method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
          //  print(String(bytes: dataResponse.data!, encoding: .utf8))
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func postSetAvatarRequest(image: UIImage, completion: @escaping (_ userModel: String?, Error?) -> Void) {
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(image.jpegData(compressionQuality: 0.7)!, withName: "image" , fileName: "avatarPic.jpeg", mimeType: "image/jpeg")
            },
            to: setAvatarURL, method: .post , headers: headersToPost(content_type: "multipart/form-data"))
            .response { dataResponse in
                completion("added", dataResponse.error?.asAFError)
            }
    }
    func getAllUserInfo(completion: @escaping (_ userModel: UserProfileModel?, Error?) -> Void) {
        getAllUserInfoJson(completion: completion)
    }
    func getAllNutritionistRequest(completion: @escaping (_ userModel: NutritionistsModel?, Error?) -> Void) {
        AF.request(getAllNutritionistURL, method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            print(dataResponse.response)
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func postBookNewNutritionistJson(with id: String, completion: @escaping (_ someBlock: String, Error?) -> Void) {
        AF.request(bookNutritionistURL+id, method : .post, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            completion("added", dataResponse.error?.asAFError)
        }
    }
    
    func getAllMyNutritionsRequest(completion: @escaping (_ someBlock: NutritionistsGroupingModel?, Error?) -> Void) {
        AF.request(getAllMyNutritionsURL, method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func getNutritionistData(with id: String, completion: @escaping (_ string: SingleNutritionist?, Error?) -> Void) {
        AF.request(getNutritionistsDataURL+id, method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func getAllUserInfoJsonMain(completion: @escaping (_ userModel: UserProfileModel?, Error?) -> Void){
        let urlRequest = URLRequest(url: URL(string: urlSelfUserProfileInfoURL)!)
        URLCache.shared.removeCachedResponse(for: urlRequest)
        getAllUserInfoJson(completion: completion)
    }
    private func getAllUserInfoJson(completion: @escaping (_ userModel: UserProfileModel?, Error?) -> Void) {
        AF.request(urlSelfUserProfileInfoURL, method : .post, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func getAllMeasurementsJson(completion: @escaping (_ userModel: MeasurementsModel?, Error?) -> Void) {
        AF.request(getAllMeasurementsURL, method : .get, parameters : [:], encoding : URLEncoding.default , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func getAllReportsJson(completion: @escaping (_ userModel: ArrayReportsModel?, Error?) -> Void) {
        AF.request(reportURL, method : .get, parameters : [:], encoding : URLEncoding.queryString , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    
    func createNewReport(image: UIImage, report: String,completion: @escaping (_ results: String, Error?) -> Void) {
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(report.data(using: String.Encoding.utf8)!, withName: "report", mimeType: "text/plain; charset=utf-8")
                multipartFormData.append(image.compress(to: 500), withName: "image" , fileName: "reportPic.jpeg", mimeType: "image/jpeg")
            },
            to: reportURL, method: .post , headers: headersToPost(content_type: "multipart/form-data"))
            .response { dataResponse in
                completion("added", dataResponse.error?.asAFError)
            }
    }
    
    func setupNewMeasurements(parameters: [String: String], completion: @escaping (_ results: String, Error?) -> Void) {
        AF.request(getAllMeasurementsURL, method : .post, parameters : parameters, encoding : JSONEncoding.default , headers : headersToPost(content_type: "application/json")).responseData { dataResponse in
            completion("added", dataResponse.error?.asAFError)
        }
    }
    
    private let createNewTransformationURL = "https://nutrtools.info:8443/api/v1/transformation/transformation"
    func getAllTransformationsJson(completion: @escaping (_ transformationModel: TransformationModel?, Error?) -> Void) {
        AF.request(createNewTransformationURL, method : .get, parameters : [:], encoding : URLEncoding.queryString , headers : headers).responseData { dataResponse in
            self.requestHandler(for: dataResponse, completion: completion)
        }
    }
    func createNewTransformationRequest(images: [UIImage], text: String, completion: @escaping (_ results: TransformationCreation?, Error?) -> Void) {
        createNewTransformationPrivateRequest(images: images, text: text, completion: completion)
    }
    
    private func createNewTransformationPrivateRequest(images: [UIImage], text: String, completion: @escaping (_ results: TransformationCreation?, Error?) -> Void) {
        AF.upload(
            multipartFormData: { multipartFormData in
                for image in images {
                    multipartFormData.append(image.compress(to: 500), withName: "images" , fileName: "transformationImage.jpeg", mimeType: "image/jpeg")
                }
                multipartFormData.append(text.data(using: String.Encoding.utf8)!, withName: "body", mimeType: "text/plain; charset=utf-8")
            },
            to: createNewTransformationURL, usingThreshold: UInt64.init(), method: .post , headers: headersToPost(content_type: "multipart/form-data"))
            .responseData { dataResponse in
                self.requestHandler(for: dataResponse, completion: completion)
            }
    }
    
    private func requestHandler<T:Decodable>(for dataResponse:DataResponse<Data, AFError>, completion: @escaping (_ results: T?, Error?) -> Void) {
        let jsonDecoder = JSONDecoder()
        let responseCode = dataResponse.response?.statusCode
        switch responseCode {
        case 200:
            if let saveJsonData = dataResponse.data {
                do {
                    let decodedData = try jsonDecoder.decode(T.self, from: saveJsonData)
                    completion(decodedData, nil)
                }
                catch {
                    completion(nil, dataResponse.error?.asAFError)
                }
            }
            else {
                completion(nil, dataResponse.error?.asAFError)
            }
            break
        case 204:
            print("Пустой ответ")
            completion(nil, nil)
            break
        case 402:
            print(dataResponse.data)
            print("Заплатите плиз")
            completion(nil,dataResponse.error?.asAFError)
            break
        case 401:
            self.openRegistration()
            break
        case 993:
            if let saveJsonData = dataResponse.data {
                do {
                    let decodedData = try jsonDecoder.decode(T.self, from: saveJsonData)
                    completion(decodedData, nil)
                }
                catch {
                    completion(nil, dataResponse.error?.asAFError)
                }
            }
            else {
                completion(nil, dataResponse.error?.asAFError)
            }
            break
        default:
            completion(nil, dataResponse.error?.asAFError)
            break
        }
    }
    
    private func openRegistration() {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        KeychainWrapper.standard.remove(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "WaterBalanceSelected")

        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        // iOS13 or later
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            sceneDelegate.window!.rootViewController = initialViewController/* ViewController Instance */
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func logOut() {
        openRegistration()
    }
}
