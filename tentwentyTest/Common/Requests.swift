
//
//  Requests.swift
//  Finny
//
//  Created by Raees on 28/03/2021.
//

import Foundation
import Alamofire
import ObjectMapper

class Requests {
    static var locallang = String(Locale.preferredLanguages[0].prefix(2))
    static let APIKey = "80d30f2b8a9c224e01c41892207bf8ed"
    static var ReqURL = "https://api.themoviedb.org/3/movie/"
    
    static func getUpcomingMovies (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Movie]?) -> Void){

        let endPoint = "upcoming"
        let params = ["api_key": APIKey]
        Alamofire.request(ReqURL + endPoint, method:.get, parameters: params, headers:nil).responseJSON { response in

            switch response.result
            {

            case .success:
                debugPrint(response)
                if let responseJSON = response.value as? [String: AnyObject]
                {
                    print(responseJSON)
                    var movies = [Movie]()
                    if let results = responseJSON["results"] as? NSArray{
                        print(results.count)
                        
                        for result in results {
                            let movieDict = Mapper<Movie>().map(JSON: result as! [String:Any])
                            if movieDict?.id != nil {
                            movies.append(movieDict!)
                            }
                        }
                        for movie in movies
                        {
                            print(movie.title)
                        }
                        if movies.count > 0
                        {
                            //testing empty Feeds
                            //let emptyFeeds = [Place]()
                            //complition(true,"Success", emptyFeeds)
                            complition(true,"Success", movies)
                        }
                        else
                        {
                            complition(false,"No Movies", nil)
                        }
                        
                    }
                    else
                    {
                        if let error = responseJSON["error"] as? NSDictionary
                        {
                            let errormsg = error["msg"]
                            complition(false,errormsg as! String, nil)
                        }
                        else
                        {
                            let error = responseJSON["errmsg"] as! String
                            complition(false,error as! String, nil)
                        }
                    }
                }

            case .failure(let error):
                print(error)
                //self.delegate?.didSignInError(msg: error as? String)
            }

        }

    }
    static func getMovieDetail (id:Int,complition: @escaping  (_ success:Bool,_ message:String,_ resultedMoview:MovieDetail?) -> Void){

        let endURL = "\(id)"
        let params = ["api_key": APIKey]
        Alamofire.request(ReqURL + endURL, method:.get, parameters: params, headers:nil).responseJSON { response in

            switch response.result
            {

            case .success:
                debugPrint(response)
                if let responseJSON = response.value as? [String: AnyObject]
                {
                    print(responseJSON)
                    var movie = MovieDetail()
                    let movieDict = Mapper<MovieDetail>().map(JSON: responseJSON as [String:Any])
                    if movieDict != nil {
                        movie = movieDict!
                        complition(true,"success", movie)
                    }
                    else {
                        complition(false,"something went Wrong", nil)
                    }
                }
                    else
                    {
                        complition(false,"something went Wrong", nil)
                    }

            case .failure(let error):
                print(error)
                //self.delegate?.didSignInError(msg: error as? String)
            }

        }

    }
    
//    static func getUserProfile (complition: @escaping (_ success:Bool,_ message:String) -> Void){
//
//        let user = "/user/\((CommonClass.sharedInstance.currentUser!.id)!)"
//        print(user)
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        Alamofire.request(ReqURL + user, method:.get, parameters: nil, headers:headers).responseJSON { response in
//
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                            let user = Mapper<User>().map(JSON: data as! [String : Any])
//                            user?.token = CommonClass.sharedInstance.currentUser?.token
//                            user?.friendsList = CommonClass.sharedInstance.currentUser?.friendsList
//                        CommonClass.sharedInstance.currentUser = user
//                        if CommonClass.sharedInstance.currentUser?.imageUrl != nil
//                        { user?.imageUrl = CommonClass.sharedInstance.currentUser?.imageUrl }
//                        complition(true,"Success")
//                    }
//                    else
//                    {
//                        let error = responseJSON["error"] as? NSDictionary
//                        let errormsg = error?["msg"]
//                        complition(false,errormsg as! String)
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                //self.delegate?.didSignInError(msg: error as? String)
//            }
//
//        }
//
//    }
//
//    static func loadFriends (complition: @escaping (_ success:Bool,_ message:String,_ friends:[User]?) -> Void){
//
//        let user = "/user/\((CommonClass.sharedInstance.currentUser!.id)!)"
//        print(user)
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        Alamofire.request(ReqURL + user, method:.get, parameters: nil, headers:headers).responseJSON { response in
//
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    if let data = responseJSON["data"] as? NSDictionary{
//                            let user = Mapper<User>().map(JSON: data as! [String : Any])
//                        complition(true,"Success", user?.friends)
//                    }
//                    else
//                    {
//                        let error = responseJSON["error"] as? NSDictionary
//                        let errormsg = error?["msg"]
//                        complition(false,errormsg as! String, nil)
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,error.localizedDescription , nil)
//            }
//
//        }
//
//    }
//
//    static func loadNotifications (complition: @escaping (_ success:Bool,_ message:String,_ friends:[User]?) -> Void){
//
//        let user = "/user/\((CommonClass.sharedInstance.currentUser!.id)!)"
//        print(user)
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        Alamofire.request(ReqURL + user, method:.get, parameters: nil, headers:headers).responseJSON { response in
//
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    if let data = responseJSON["data"] as? NSDictionary{
//                            let user = Mapper<User>().map(JSON: data as! [String : Any])
//                        complition(true,"Success", user?.friends)
//                    }
//                    else
//                    {
//                        let error = responseJSON["error"] as? NSDictionary
//                        let errormsg = error?["msg"]
//                        complition(false,errormsg as! String, nil)
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,error.localizedDescription , nil)
//            }
//
//        }
//
//    }
//    static func getSocialogin ( parameters :[String : Any] ,complition: @escaping (_ success:Bool,_ message:String) -> Void){
//        let login = "/login-fb"
//        Alamofire.request(ReqURL + login, method:.post, parameters: parameters,encoding: JSONEncoding.default, headers:nil).responseJSON { response in
//
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        if let user =  data["user"] as? NSDictionary{
//                            let user = Mapper<User>().map(JSON: user as! [String : Any])
//                            //user?.loginType = CommonClass.sharedInstance.currentUser?.loginType
//                            print(user?.loginType)
//                            if CommonClass.sharedInstance.currentUser?.imageUrl != nil && user?.imageUrl == nil
//                            { user?.imageUrl = CommonClass.sharedInstance.currentUser?.imageUrl }
//                            CommonClass.sharedInstance.currentUser = user
//                            if let token = data["token"] as? String
//                            {
//                                CommonClass.sharedInstance.currentUser?.token = token
//                            }
//                        }
//                        complition(true,"Success")
//                    }
//                    else
//                    {
//                        let error = responseJSON["error"] as? NSDictionary
//                        let errormsg = error?["msg"]
//                        complition(false,errormsg as! String)
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                //self.delegate?.didSignInError(msg: error as? String)
//            }
//
//        }
//
//    }
//    static func resetPassword ( parameters :[String : Any] ,complition: @escaping (_ success:Bool,_ message:String) -> Void){
//        let login = "/forgot-password"
//        Alamofire.request(ReqURL + login, method:.post, parameters: parameters,encoding: JSONEncoding.default, headers:nil).responseJSON { response in
//
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        let msg = data["msg"] as? String
//                        complition(true,msg ?? "")
//                    }
//                    else
//                    {
//                        if let msg = responseJSON["msg"] as? String
//                        {
//                            complition(false,msg)
//                        }
//                        else
//                        {
//                        complition(false,"some error occured" as! String)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                //self.delegate?.didSignInError(msg: error as? String)
//            }
//
//        }
//
//    }
//
//    static func getRegister ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//
//        let register = "/signup"
//
//        Alamofire.request(ReqURL + register, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        if let user = data["user"] as? NSDictionary
//                        {
//                            let user = Mapper<User>().map(JSON: user as! [String : Any])
//                            CommonClass.sharedInstance.currentUser = user
//                            if let token = data["token"] as? String
//                            {
//                                CommonClass.sharedInstance.currentUser?.token = token
//                            }
//                        complition(true,"Success")
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!)
//            }
//
//        }
//    }
//
// static func postUserData( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//
//     let update = "/update-user-info"
//     var headers: [String: String] = [String: String]()
//     headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//     headers["Content-Type"] = "application/json"
//     Alamofire.request(ReqURL + update, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//         switch response.result
//         {
//
//         case .success:
//             debugPrint(response)
//             if let responseJSON = response.value as? [String: AnyObject]
//             {
//                 print(responseJSON)
//                 if let data = responseJSON["data"] as? NSDictionary{
//                     print(data)
//                     let user = Mapper<User>().map(JSON: data as! [String : Any])
//                     let token = CommonClass.sharedInstance.currentUser?.token!
//                     CommonClass.sharedInstance.currentUser = user
//                     CommonClass.sharedInstance.currentUser?.token = token
//                     complition(true,"Success")
//                 }
//                 else
//                 {
//                    if let error = responseJSON["error"] as? NSDictionary
//                    {
//                     let msg = error["msg"] as? String
//                     complition(false,msg!)
//                    }
//
//
//                 }
//             }
//
//         case .failure(let error):
//             print(error)
//             complition(false,(error as? String)!)
//         }
//
//     }
// }
//
// static func postChangePassword( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//
//     let update = "/change-password"
//     var headers: [String: String] = [String: String]()
//     headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//     headers["Content-Type"] = "application/json"
//     Alamofire.request(ReqURL + update, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//         switch response.result
//         {
//
//         case .success:
//             debugPrint(response)
//             if let responseJSON = response.value as? [String: AnyObject]
//             {
//                 print(responseJSON)
//                 if let data = responseJSON["data"] as? NSDictionary{
//                     print(data)
//                     let user = Mapper<User>().map(JSON: data as! [String : Any])
//                     let token = CommonClass.sharedInstance.currentUser?.token!
//                     CommonClass.sharedInstance.currentUser = user
//                     CommonClass.sharedInstance.currentUser?.token = token
//                     complition(true,"Success")
//                 }
//                 else
//                 {
//                    if let error = responseJSON["error"] as? NSDictionary
//                    {
//                     let msg = error["msg"] as? String
//                     complition(false,msg!)
//                    }
//
//
//                 }
//             }
//
//         case .failure(let error):
//             print(error)
//             complition(false,(error as? String)!)
//         }
//
//     }
// }
//
//    static func postAddLocation ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ place:Place?,_ message:String) -> Void){
//
//
//        let register = "/location/add"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        let place = Mapper<Place>().map(JSON: data as! [String : Any])
//                        print(place!.id)
//                        complition(true,place!, "Success")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,nil,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,nil,error as! String)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,nil,(error as? String)!)
//            }
//
//        }
//    }
//
//    static func postLikeUnlike ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ place:Place?,_ message:String) -> Void){
//
//        let register = "/visit/update-like-status"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        if let dataDict = data["Data"] as? NSDictionary
//                        {
//                            let place = Mapper<Place>().map(JSON: dataDict as! [String : Any])
//                            print(place!.id)
//                            complition(true,place!, "Success")
//                        }
//                        else
//                        {
//                            complition(false,nil, "some error occured")
//                        }
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,nil,errormsg as! String)
//                        }
//                        else
//                        {
//                            if let error = responseJSON["errmsg"] as? String
//                            {
//                                complition(false,nil,error)
//                            }
//                            else
//                            {
//                                complition(false,nil,"some error occured")
//                            }
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,nil,(error as? String)!)
//            }
//
//        }
//    }
//
//    static func getLatestVisitDataByID ( ID : String,complition: @escaping  (_ success:Bool,_ place:Place?,_ message:String) -> Void){
//
//        let register = "/visit/get-by-id/\(ID)"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .get, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        let place = Mapper<Place>().map(JSON: data as! [String : Any])
//                        print(place!.id)
//                        complition(true,place!, "Success")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,nil,errormsg as! String)
//                        }
//                        else
//                        {
//                            if let error = responseJSON["errmsg"] as? String
//                            {
//                                complition(false,nil,error)
//                            }
//                            else
//                            {
//                                complition(false,nil,"some error occured")
//                            }
//                        }
//                    }
//            }
//            case .failure(let error):
//                print(error)
//                complition(false,nil,(error as? String)!)
//            }
//
//        }
//    }
//
//    static func postAddComment ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//
//        let feedback = "/feedback/add"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + feedback, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        complition(true,"Comment added")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["msg"] as! String
//                            complition(false,error as! String)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!)
//            }
//
//        }
//    }
//
//    static func getComments ( visit :String ,complition: @escaping  (_ success:Bool,_ message:String,_ comments:[(user:User, comment: String,date:String)]?) -> Void){
//
//        let feedback = "/feedback/get_by_visit/\(visit)"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + feedback, method: .get, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSArray{
//                        print(data)
//                        var comments:[(user: User, comment: String,date:String)] = []
//                        for comment in data
//                        {
//                            if let cmnt = comment as? NSDictionary
//                            {
//                            if let customer = cmnt["customer"] as? NSDictionary
//                            {
//                                let user = Mapper<User>().map(JSON: customer as! [String : Any])
//                                print(user?.name)
//                                if let commentDescripition = cmnt["description"] as? String
//                                {
//                                    print(commentDescripition)
//                                    if let date = cmnt["createdAt"] as? String
//                                    {
//                                        print(date)
//                                        comments.append((user!, commentDescripition,date))
//                                    }
//
//
//                                }
//
//
//                            }
//
//                            }
//                        }
//                        complition(true,"success",comments)
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,errormsg as! String,nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["msg"] as! String
//                            complition(false,error as! String,nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!,nil)
//            }
//
//        }
//    }
//
//    static func postAddVisit ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ place:Place?,_ message:String) -> Void){
//
//        let register = "/visit/add"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        let place = Mapper<Place>().map(JSON: data as! [String : Any])
//                        print(place!.id)
//                        complition(true,place!, "Success")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,nil,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,nil,error as! String)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,nil,(error as? String)!)
//            }
//
//        }
//    }
//
//    static func updateLocation ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ place:Place?,_ message:String) -> Void){
//
//        let register = "/location/update-info"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        let place = Mapper<Place>().map(JSON: data as! [String : Any])
//                        print(place!.id)
//                        complition(true,place!, "Success")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,nil,errormsg as! String)
//                        }
//                        else if let msg = responseJSON["msg"] as? String
//                        {
//
//                            complition(false,nil,msg)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,nil,(error as? String)!)
//            }
//
//        }
//    }
//
//    static func postUpdateVisit ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ place:Place?,_ message:String) -> Void){
//
//        let register = "/visit/update"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let data = responseJSON["data"] as? NSDictionary{
//                        print(data)
//                        let place = Mapper<Place>().map(JSON: data as! [String : Any])
//                        print(place!.id)
//                        complition(true,place!, "Success")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,nil,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,nil,error as! String)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,nil,(error as? String)!)
//            }
//
//        }
//    }
//
//    static func getAllUsers (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[User]?) -> Void){
//
//        let user = "/user"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + user, method: .get, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var users = [User]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let allUsers = responseJSON["data"] as? NSArray{
//                        for user in allUsers
//                        {
//                            let user = Mapper<User>().map(JSON: user as! [String : Any])
//                            users.append(user!)
//                        }
//                        complition(true,"success", users)
//
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func getPersonalFeeds (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/location/get-by-id"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["id": CommonClass.sharedInstance.currentUser!.id!]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        print(feeds.count)
//
//                        for feed in feeds {
//                            if let feedArray = feed as? NSArray
//                            {
//                                let monthString = feedArray[0] as? String
//                                let place = Place()
//                                place.headerString = monthString
//                                userFeeds.append(place)
//                                if let locations = feedArray[1] as? NSArray
//                                {
//                                    print(feedArray)
//                                    for feed in locations
//                                    {
//                                        let feedDict = Mapper<Place>().map(JSON: feed as! [String : Any])
//                                        print(feedDict,feedDict?.user)
//                                        if feedDict!.name != nil
//                                        {
//                                        userFeeds.append(feedDict!)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        for feed in userFeeds
//                        {
//                            print(feed.name)
//                        }
//                        if userFeeds.count > 0
//                        {
//                            //testing empty Feeds
//                            //let emptyFeeds = [Place]()
//                            //complition(true,"Success", emptyFeeds)
//                            complition(true,"Success", userFeeds)
//                        }
//                        else
//                        {
//                            complition(false,"No places", nil)
//                        }
////                        let posts = Mapper<Place>().mapArray(JSONArray: feeds as! [[String : Any]])
////                        if posts.count > 0
////                        {
////                        complition(true,"Success", posts)
////                        }
////                        else
////                        {
////                            complition(false,"Error", nil)
//                      //  }
//
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,"Some error occured", nil)
//            }
//
//        }
//    }
//    static func getPersonalNotificationsHistory (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[NotificationModel]?) -> Void){
//
//        let register = "/notification/get-history-by-user-id"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["userId": CommonClass.sharedInstance.currentUser!.id!]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var notifications = [NotificationModel]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let notificaitonsFromAPI = responseJSON["data"] as? NSArray{
//                        for notification in notificaitonsFromAPI {
//                            let notification = Mapper<NotificationModel>().map(JSON: notification as! [String : Any])
//                            print(notification?.sender?.name,notification?.reciever?.name)
//                            //if notification has no visit and if notification is from current user then dont add
//                            if notification?.sender != nil
//                            {
//                            notifications.append(notification!)
//                            }
////                            if notification?.visit != nil && notification?.sender?.id != CommonClass.sharedInstance.currentUser?.id
////                            {
////                            notifications.append(notification!)
////                            }
////                            if notification?.title == "Friend requested accepted"
////                            {
////                                notifications.append(notification!)
////                            }
//                        }
//                        for notification in notifications
//                        {
//                            print(notification.sender?.name,notification.reciever?.name)
//                        }
//                        if notifications.count > 0
//                        {
//                            let realNotifications = Array(notifications.reversed())
//                            //testing scenario
//                            //let emptynotifications = [NotificationModel]()
//                           // complition(true,"Success", emptynotifications)
//                            complition(true,"Success", realNotifications)
//                        }
//                        else
//                        {
//                            complition(false,"No notifications", nil)
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            if let error = responseJSON["errmsg"] as? String
//                            {
//                            complition(false,error as! String, nil)
//                            }
//                            else
//                            {
//                                complition(false,"some error occured", nil)
//                            }
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,"Some error occured", nil)
//            }
//
//        }
//    }
//
//    static func getLocation (locationID:String, complition: @escaping  (_ success:Bool,_ message:String,_ resultedPlace:Place?) -> Void){
//
//        let register = "/location/get/\(locationID)"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .get, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        let feed = feeds[0]
//                        let feedDict = Mapper<Place>().map(JSON: feed as! [String : Any])
//                        print(feedDict?.name,feedDict?.address)
//                        complition(true,"Success",feedDict)
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            if let error = responseJSON["errmsg"] as? String
//                            {
//                            complition(false,error as! String, nil)
//                            }
//                            else
//                            {
//                                complition(false,"some error occured", nil)
//                            }
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,"Some error occured", nil)
//            }
//
//        }
//    }
//    static func updateNotificationsHistory (parameters :[String : Any], complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//
//        let register = "/notification/update-history-by-id"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var notifications = [NotificationModel]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let notificaitonsFromAPI = responseJSON["data"] as? NSDictionary{
//                        complition(true,"updated")
//
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String)
//                        }
//                        else
//                        {
//                            if let error = responseJSON["errmsg"] as? String
//                            {
//                            complition(false,error as! String)
//                            }
//                            else
//                            {
//                                complition(false,"some error occured")
//                            }
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,"Some error occured")
//            }
//
//        }
//    }
//
//    static func getFriendsFeeds (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/location/get-by-friends"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["id": CommonClass.sharedInstance.currentUser!.id!]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        print(feeds.count)
//
//                        for feed in feeds {
//                            if let feedArray = feed as? NSArray
//                            {
//                                let monthString = feedArray[0] as? String
//                                let place = Place()
//                                place.headerString = monthString
//
//                                if let locations = feedArray[1] as? NSArray
//                                {
//                                    let feedArray = Mapper<Place>().mapArray(JSONArray: locations as! [[String : Any]])
//                                    print(feedArray)
//                                    if feedArray.contains(where: { place in
//                                        if place.user == nil
//                                        { return false }
//                                        else
//                                        { return true }
//                                    }) {
//                                        print("true")
//                                        userFeeds.append(place)
//                                    }
//                                    else
//                                    {
//                                        print("false")
//                                    }
//                                    for feed in locations
//                                    {
//                                        let feedDict = Mapper<Place>().map(JSON: feed as! [String : Any])
//                                        print(feedDict,feedDict?.user)
//                                        if feedDict!.name != nil && feedDict?.user != nil
//                                        {
//                                        userFeeds.append(feedDict!)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        for feed in userFeeds
//                        {
//                            print(feed.name)
//                        }
//                        if userFeeds.count > 0
//                        {
//                            complition(true,"Success", userFeeds)
//                        }
//                        else
//                        {
//                            complition(false,"No places", nil)
//                        }
////                        let posts = Mapper<Place>().mapArray(JSONArray: feeds as! [[String : Any]])
////                        if posts.count > 0
////                        {
////                        complition(true,"Success", posts)
////                        }
////                        else
////                        {
////                            complition(false,"Error", nil)
//                      //  }
//
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func getPublicFeeds (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/location/get-by-privacy"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["id": CommonClass.sharedInstance.currentUser!.id!,"privacy":"public"]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        print(feeds.count)
//
//                        for feed in feeds {
//                            if let feedArray = feed as? NSArray
//                            {
//
//                                let monthString = feedArray[0] as? String
//                                let place = Place()
//                                place.headerString = monthString
//
//                                if let locations = feedArray[1] as? NSArray
//                                {
//                                    print(feedArray)
//                                    let feedArray = Mapper<Place>().mapArray(JSONArray: locations as! [[String : Any]])
//                                    print(feedArray.count)
//                                    if feedArray.contains(where: { place in
//                                        if place.user == nil
//                                        { return false }
//                                        else
//                                        { return true }
//                                    }) {
//                                        print("true")
//                                        userFeeds.append(place)
//                                    }
//                                    else
//                                    {
//                                        print("false")
//                                    }
//                                    for feed in locations
//                                    {
//                                        let feedDict = Mapper<Place>().map(JSON: feed as! [String : Any])
//                                        print(feedDict,feedDict?.user)
//                                        if feedDict!.name != nil && feedDict?.user != nil
//                                        {
//                                        userFeeds.append(feedDict!)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        for feed in userFeeds
//                        {
//                            print(feed.name)
//                        }
//                        if userFeeds.count > 0
//                        {
//                            complition(true,"Success", userFeeds)
//                        }
//                        else
//                        {
//                            complition(false,"No places", nil)
//                        }
////                        let posts = Mapper<Place>().mapArray(JSONArray: feeds as! [[String : Any]])
////                        if posts.count > 0
////                        {
////                        complition(true,"Success", posts)
////                        }
////                        else
////                        {
////                            complition(false,"Error", nil)
//                      //  }
//
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func getPersonalList (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[List]?) -> Void){
//
//        let register = "/listing/get-by-userId"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["user_id": CommonClass.sharedInstance.currentUser!.id!]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userLists = [List]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSArray{
//                        print(lists.count)
//                        if lists.count > 0
//                        {
//                            for list in lists
//                            {
//                            let listItem = Mapper<List>().map(JSON: list as! [String : Any])
//                                userLists.append(listItem!)
//
//                            }
//                            let sortedList = userLists.sorted { $0.name! < $1.name! }
//                            complition(true,"Success",sortedList)
//                        }
//                        else
//                        {
//                            complition(false,"No list item available", nil)
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func getOthersList (userId :String ,complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[List]?) -> Void){
//
//        let register = "/listing/get-by-userId"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["user_id": userId]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userLists = [List]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSArray{
//                        print(lists.count)
//                        if lists.count > 0
//                        {
//                            for list in lists
//                            {
//                            let listItem = Mapper<List>().map(JSON: list as! [String : Any])
//                                userLists.append(listItem!)
//                            }
//                            complition(true,"Success",userLists)
//                        }
//                        else
//                        {
//                            complition(false,"No list item available", nil)
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//    static func addPersonalList ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/listing/add"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = parameters
//        Alamofire.request(ReqURL + register, method: .post, parameters: params, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSDictionary{
//                        print(lists.count)
//                        if lists.count > 0
//                        {
//                            complition(true,"Success", nil)
//                        }
//                        else
//                        {
//                            complition(false,"No list item available", nil)
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//    static func updateListItem ( parameters :[String : Any],complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let update = "/listing/update-listing"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = parameters
//        Alamofire.request(ReqURL + update, method: .post, parameters: params,encoding:JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSDictionary{
//                        complition(true,"Success", nil)
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error , nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//    static func updateListPrivacy ( parameters :[String : Any],complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let update = "/listing/update-listing-privacy"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = parameters
//        Alamofire.request(ReqURL + update, method: .post, parameters: params,encoding:JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSDictionary{
//                        complition(true,"Success", nil)
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error , nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//    static func deleteVisit ( id :String ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//        //localhost:8000/api/visit/delete/60f276460c62826674b7c13a
//        let delete = "/visit/delete/\(id)"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + delete, method: .delete, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSDictionary{
//                        if let msg =  lists["msg"] as? String
//                        {
//                        complition(true,msg)
//                        }
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error )
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!)
//            }
//        }
//    }
//    static func deleteLocation ( id :String ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//        let delete = "/location/delete/\(id)"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + delete, method: .delete, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSDictionary{
//                        if let msg =  lists["msg"] as? String
//                        {
//                        complition(true,msg)
//                        }
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error )
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!)
//            }
//        }
//    }
//    static func loadComments ( id :String ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//        let delete = "/feedback/get_by_visit/\(id)"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + delete, method: .get, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSDictionary{
//                        complition(true,"Deleted successfully")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error )
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!)
//            }
//        }
//    }
//    static func deleteListItem ( id :String ,complition: @escaping  (_ success:Bool,_ message:String) -> Void){
//
//        let delete = "/listing/delete/\(id)"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + delete, method: .delete, parameters: nil,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSDictionary{
//                        complition(true,"Deleted successfully")
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error )
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!)
//            }
//
//        }
//    }
//    static func getPersonalPlaces (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/location/get-by-id-obj"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["id": CommonClass.sharedInstance.currentUser!.id!]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        print(feeds.count)
//                        for feed in feeds {
//                                let feedDict = Mapper<Place>().map(JSON: feed as! [String : Any])
//                            print(feedDict?.phoneNumber,feedDict?.name)
//                            if feedDict?.name != nil
//                            {
//                            userFeeds.append(feedDict!)
//                            }
//                            }
//                        complition(true,"success",userFeeds)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String ?? "error"), nil)
//            }
//
//        }
//    }
//
//    static func getVisits(locationId :String,complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/visit/get-by-location"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["location": locationId]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        print(feeds.count)
//                        for feed in feeds {
//                                let feedDict = Mapper<Place>().map(JSON: feed as! [String : Any])
//                            print(feedDict?.phoneNumber,feedDict?.name)
//                            if feeds.count > 1
//                            {
////                                //dont add save visit
////                            if feedDict?.status != "save"
////                            {
////                            userFeeds.append(feedDict!)
////                            }
//                                userFeeds.append(feedDict!)
//                            }
//                            else
//                            {
//                                userFeeds.append(feedDict!)
//                            }
//                        }
//                        complition(true,"success",userFeeds)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String) ?? "", nil)
//            }
//
//        }
//    }
//
//    static func getPersonalTags (complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[String]?) -> Void){
//
//        let register = "/visit/get-tag-by-user"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["id": CommonClass.sharedInstance.currentUser!.id!]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var tags = [String]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSDictionary{
//                        if let usertags = feeds["tags"] as? NSArray
//                        {
//                            for tag in usertags
//                            {
//                                tags.append(tag as! String)
//                            }
//                            let sortedTags = tags.sorted { $0 < $1 }
//                            complition(true,"success",sortedTags)
//                        }
//                        else
//                        {
//                            complition(false,"error",nil)
//                        }
//                    }
//                    else
//                    {
//                        complition(false,"error",nil)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func getPersonalTagPlaces (tag : String,complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/visit/get-by-tags"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["tags": tag]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        print(feeds.count)
//                        for feed in feeds {
//                            if let feedDict = feed as? NSDictionary
//                            {
//                                if let feedLocation = feedDict["location"] as? NSDictionary
//                                {
//                                    let feedDict = Mapper<Place>().map(JSON: feedLocation as! [String : Any])
//                                    userFeeds.append(feedDict!)
//                                }
//                            }
//
//                            }
//                        complition(true,"success",userFeeds)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func getOthersFeeds (userId:String ,complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Place]?) -> Void){
//
//        let register = "/location/get-by-id"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = [String: Any]()
//        params = ["id": userId]
//        Alamofire.request(ReqURL + register, method: .get, parameters: params,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let feeds = responseJSON["data"] as? NSArray{
//                        print(feeds.count)
//                        for feed in feeds {
//                            if let feedArray = feed as? NSArray
//                            {
//                                if let locations = feedArray[1] as? NSArray
//                                {
//                                    print(feedArray)
//                                    for feed in locations
//                                    {
//                                        let feedDict = Mapper<Place>().map(JSON: feed as! [String : Any])
//                                        print(feedDict,feedDict?.user)
//                                        if feedDict!.name != nil
//                                        {
//                                        userFeeds.append(feedDict!)
//                                        }
//                                    }
//                                }
//                            }
//
//                        }
//                        for feed in userFeeds
//                        {
//                            print(feed.name)
//                        }
//                        if userFeeds.count > 0
//                        {
//                            complition(true,"Success", userFeeds)
//                        }
//                        else
//                        {
//                            complition(false,"No places", nil)
//                        }
////                        let posts = Mapper<Place>().mapArray(JSONArray: feeds as! [[String : Any]])
////                        if posts.count > 0
////                        {
////                        complition(true,"Success", posts)
////                        }
////                        else
////                        {
////                            complition(false,"Error", nil)
//                      //  }
//
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            if let error = responseJSON["errmsg"] as? String
//                            {
//                            complition(false,error as! String, nil)
//                            }
//                            else
//                            {
//                                complition(false,"some error occured", nil)
//                            }
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func postApplyFilters (complition: @escaping  (_ success:Bool,_ places:[Place]?,_ message:String) -> Void){
//
//        var register = "/location/get-filter"
//        if let id = CommonClass.sharedInstance.filters["customer"]
//        {
//            register.append("?customer=\(id)")
//        }
//        if let rating = CommonClass.sharedInstance.filters["rating"]
//        {
//            register.append("&rating=\(rating)")
//        }
//        if let priceRating = CommonClass.sharedInstance.filters["price"]
//        {
//            register.append("&price=\(priceRating)")
//        }
//        if let status = CommonClass.sharedInstance.filters["status"]
//        {
//            register.append("&status=\(status)")
//        }
//        if let radius = CommonClass.sharedInstance.filters["redis"]
//        {
//            if radius as! Float != 10
//            {
//            register.append("&redis=\(radius)")
//                if let location = CommonClass.sharedInstance.filters["locations"]
//                {
//                    register.append("&locations=\(location)")
//                }
//            }
//        }
//
//        if let fromDate = CommonClass.sharedInstance.filters["from_date"]
//        {
//            register.append("&from_date=\(fromDate)")
//        }
//        if let toDate = CommonClass.sharedInstance.filters["to_date"]
//        {
//            register.append("&to_date=\(toDate)")
//        }
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        Alamofire.request(ReqURL + register, method: .get,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var filteredPlaces = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let lists = responseJSON["data"] as? NSArray{
//                        print(lists)
//                        if lists.count == 0
//                        {
//                            complition(false,nil,"no result found")
//                        }
//                        else
//                        {
//                        for plac in lists
//                        {
//                            let place = Mapper<Place>().map(JSON: plac as! [String : Any])
//                            filteredPlaces.append(place!)
//                        }
//
//
//                        complition(true,filteredPlaces, "Success")
//                        }
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                        complition(false,nil,errormsg as! String)
//                        }
//                        else
//                        {
//                            //let error = responseJSON["errmsg"] as! String
//                            //complition(false,nil,error as! String)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,nil,(error as? String)!)
//            }
//
//        }
//    }
//    static func sendFollowRequest ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String,_ user:User?) -> Void){
//        let sendRequest = "/user/send-follow-request"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = parameters
//        Alamofire.request(ReqURL + sendRequest, method: .post, parameters: params, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let detail = responseJSON["data"] as? NSDictionary{
//                        if let data = detail["data"] as? NSDictionary
//                        {
//                            if let user = data["loginUser"] as? NSDictionary
//                            {
//                                let user = Mapper<User>().map(JSON: user as! [String : Any])
//                                user?.token = CommonClass.sharedInstance.currentUser?.token
//                                print(user?.id)
//                                complition(true,"Request updated",user)
//                                //send user to main class
//                            }
//
//                        }
//                        else
//                        {
//                            complition(false,"No list item available", nil)
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func unfriend ( parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String,_ user:User?) -> Void){
//        let sendRequest = "/user/delete-follow-request"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        var params = parameters
//        Alamofire.request(ReqURL + sendRequest, method: .post, parameters: params, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userFeeds = [Place]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let detail = responseJSON["data"] as? NSDictionary{
//                        if let data = detail["data"] as? NSDictionary
//                        {
//                            if let user = data["updatedUser$"] as? NSDictionary
//                            {
//                                let user = Mapper<User>().map(JSON: user as! [String : Any])
//                                user?.token = CommonClass.sharedInstance.currentUser?.token
//                                print(user?.id)
//                                complition(true,"user unfollowed",user)
//                                //send user to main class
//                            }
//
//                        }
//                        else
//                        {
//                            complition(false,"No list item available", nil)
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            let error = responseJSON["errmsg"] as! String
//                            complition(false,error as! String, nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
//
//    static func postRequest (parameters :[String : Any] ,complition: @escaping  (_ success:Bool,_ message:String,_ updatedUser:User?) -> Void){
//        let register = "/user/response-follow-request"
//        var headers: [String: String] = [String: String]()
//        headers["Authorization"] =  "Bearer \(CommonClass.sharedInstance.currentUser!.token!)"
//        headers["Content-Type"] = "application/json"
//        let params = parameters
//        Alamofire.request(ReqURL + register, method: .post, parameters: params,encoding: JSONEncoding.default,headers: headers).responseJSON { response in
//            switch response.result
//            {
//
//            case .success:
//                debugPrint(response)
//                var userLists = [List]()
//                if let responseJSON = response.value as? [String: AnyObject]
//                {
//                    print(responseJSON)
//                    if let detail = responseJSON["data"] as? NSDictionary{
//                        if let data = detail["data"] as? NSDictionary
//                        {
//                            if let user = data["updatedUser$"] as? NSDictionary
//                            {
//                                let userObj = Mapper<User>().map(JSON: user as! [String : Any])
//                                let token = CommonClass.sharedInstance.currentUser?.token
//                                print(userObj?.id)
//                                userObj?.token = token
//                                complition(true,"Request updated",userObj)
//                                //send user to main class
//                            }
//
//                        }
//                        else
//                        {
//                            complition(false,"No list item available", nil)
//                        }
//
//                    }
//                    else
//                    {
//                        if let error = responseJSON["error"] as? NSDictionary
//                        {
//                            let errormsg = error["msg"]
//                            complition(false,errormsg as! String, nil)
//                        }
//                        else
//                        {
//                            //let error = responseJSON["errmsg"] as String
//                            complition(false,"Some error occured", nil)
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                complition(false,(error as? String)!, nil)
//            }
//
//        }
//    }
}


