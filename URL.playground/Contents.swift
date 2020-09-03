import Foundation

let urlStr = "https://www.test.com.tw/promo/coupon/?activityId=123&sn=456"
let urlStr_fragment = "https://www.test.com.tw/#/promo/coupon/?activityId=123&sn=456"

extension URL {
    /// Find value of query key.
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: absoluteString) else { return nil }

        if let params = url.queryItems {
            // find first result of query items
            return params.first(where: { $0.name == queryParam })?.value
        } else if let paramPairs = url.fragment?.components(separatedBy: "?").last?.components(separatedBy: "&") {
            // find url fragment componets after "?", and separated by "&"
            for pair in paramPairs where pair.contains(queryParam) {
                return pair.components(separatedBy: "=").last
            }
            return nil
        } else {
            return nil
        }
    }
    
    /// Find component of path
    func findPathComponent(target: String) -> Bool {
        guard !pathComponents.isEmpty else { return false }
        if let fragmentUrl = fragment {
            // fragment url
            return fragmentUrl.components(separatedBy: "/").contains(target)
        } else {
            return pathComponents.contains(target)
        }
    }
    
    /// Filter URL to only path by String type
    func getHierarchicalUrl() -> String? {
        var url = URLComponents(url: self, resolvingAgainstBaseURL: false)

        url?.queryItems = nil
        url?.fragment = nil
        
        if let urlStr = url?.url {
            return "\(urlStr)"
        } else {
            return ""
        }
    }
    
    /// Add some query item programmly
    func addTrackingParam() -> URL? {
        addQueryItems(queryList: [
            URLQueryItem(name: "title", value: "789"),
            URLQueryItem(name: "limit", value: "abc")
        ])
    }
    
    private func addQueryItems(queryList: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        
        if components.queryItems == nil {
            components.queryItems = []
        }
        
        components.queryItems?.append(contentsOf: queryList)
        return components.url
    }
}

let url = URL(string: urlStr)
let value1 = url?["sn"]

let url_fragment = URL(string: urlStr_fragment)
let value2 = url_fragment?["sn"]

let isPromo = url?.findPathComponent(target: "promo")
let isPromo_fragment = url_fragment?.findPathComponent(target: "promo")

let pureUrl = url?.getHierarchicalUrl()
let pureUrl_fragment = url_fragment?.getHierarchicalUrl()

let trackingUrl = url?.addTrackingParam()
let trackingUrl_fragment = url_fragment?.addTrackingParam()

