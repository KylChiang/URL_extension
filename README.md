#### This repo is my pratice for the URL word filtering/appending, some solutions are shearching from google, or by my experiences.
#### Hopfully can help someone who was me, and welcome suggest me better wrtting by pull request :>


## Knowledge of URL (by wiki)
![Image of URL](https://upload.wikimedia.org/wikipedia/commons/d/d6/URI_syntax_diagram.svg)

https://en.wikipedia.org/wiki/URL

## Feature
* Find value of query key
```
let url = "https://www.test.com.tw/promo/coupon/?activityId=123&sn=456"
let value = url?["sn"]

// result:
// 456
```

<br>

* Find component of path
```
let isPromo = url?.findPathComponent(target: "promo")

// result:
// true
```

<br>

* Filter URL to only path by String type
```
let pureUrl = url?.getHierarchicalUrl()

// result:
// https://www.test.com.tw/promo/coupon/
```

<br>

* Add some query item programmly
```
let trackingUrl = url?.addTrackingParam()

// result:
// https://www.test.com.tw/promo/coupon/?activityId=123&sn=456&title=789&limit=abc
```
