import UIKit

class MenuController {
    
    static let shared = MenuController()
    
    let baseURL = URL(string: "http://macbook-pro.local:8090/")!
    // Default server address is: http://localhost:8090/
    // In case you want to test with a real device change the URL
    // since otherwise you can't reach it since localhost assumes
    // client and server are on the same machine
    // see console of the server app for the address
    // (localhost still is possible)
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            
            //print(response)
            
            //let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
            //print(string1)

            if let data = data,
                let categories = try? jsonDecoder.decode(Categories.self, from: data) {
                completion(categories.categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            print(response)
            
            let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
            print(string1)
            
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        // Added by Johan Korten:
        // otherwise the entire (server)path to the image URL is needed in your menu.json
        // if no http found in URL we assume it is the default server (-> baseURL)
        // if there was no http found in the string then it will append the server path to the beginning of the image URL
        var finalURL = url
        if (!url.absoluteString.contains("http")) {
            finalURL = MenuController.shared.baseURL
            finalURL = finalURL.appendingPathComponent("images")
            finalURL = finalURL.appendingPathComponent(url.absoluteString)
        }
        
        let task = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        print(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
