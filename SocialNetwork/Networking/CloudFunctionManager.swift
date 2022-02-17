import UIKit
import Alamofire
import FirebaseAuth

class CloudFunctionManager: NSObject {
    
    static func request(completion:((_ result:[String:Any]?, _ error:Error?) -> Void)?){
        let urlString = "\(Api.BASE_URL)"
        
                Alamofire.request(
                    urlString,
                    method: HTTPMethod.get ,
                    parameters: nil,
                    encoding: JSONEncoding.default,
                    headers: nil).responseJSON { (response) in
                        if let error = response.result.error{
                            completion?(nil, error)
                        }else if let data = response.result.value as? [String:Any]{
                            if let status = data["estatus"] as? String,
                                status == "error",
                                let mensaje = data["mensaje"] as? String{
                                let userInfo = [
                                    NSLocalizedDescriptionKey: mensaje,
                                    NSLocalizedFailureReasonErrorKey: mensaje
                                ]
                                var code = 0
                                if let stringCode = data["codigo"] as? String{
                                    code = Int(stringCode) ?? 0
                                }
                                let error = NSError(domain: "com.prueba", code: code, userInfo: userInfo)
                                
                                completion?(data, error)
                                
                            }else{
                                completion?(data, nil)
                            }
                        }else{
                            completion?(nil, NSError() as Error)
                        }
                }
        }
    }

