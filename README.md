# CodableDictionary

[![Swift 4](https://img.shields.io/badge/Language-Swift%204-orange.svg)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)

Struct to make simple `[String: Any]` dictionaries conform to `Codable`. 

## Usage

### Decoding

```
let data1: Data = try! Data(contentsOf: Bundle.main.url(forResource: "test", withExtension: "json")!)
let dict = try? JSONDecoder().decode(CodableDictionary.self, from: data)
let name = dict?["name"]
```

### Encoding

`CodableDictionary` can be initialised with [String: Any].

```
let dict = CodableDictionary(value: ["foor": 233, "nested": ["n1": "hallo", "n2": "welt", "nested": ["n1": "hallo", "n2": "welt"]]])
let encodedData: Data = try! JSONEncoder().encode(dict)
let jsonString = String(data: encodedData, encoding: .utf8)
```

Encoding of custom models is also supported. So you can simply wrap models into an dictionary.

```
struct User: Codable {
	let name: String
}
        
let user = User(name: "Stefan")
        
var userDict = CodableDictionary(value: ["user": user])
userDict.additionalEncoding = { (container, codingKey, value) in
	if let user = value as? User {
		try container.encode(user, forKey: codingKey)
	}
}
        
let encodedData: Data = try! JSONEncoder().encode(userDict)
let jsonString = String(data: encodedData, encoding: .utf8)
```

### Limitations

Since `CodableDictionary` has to know the type of model which has to be decoded/encoded, `Any` has to be one of the following types:

| supported types of Any | 
| ------------- | ----------------- |
| String, [String] | 
| Bool, [Bool] | 
| Int, [Int] | 
| Double, [Double] | 
| CodableDictionary | 

## Version Compatibility

Current Swift compatibility breakdown:

| Swift Version | Framework Version |
| ------------- | ----------------- |
| 4.x           | 1.x                 |


[all releases]: https://github.com/wieweb/CodableDictionary/releases

## Installation

### Carthage

Add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

```
github "wieweb/CodableDictionary", ~> 1.0
```

Then run `carthage update`.

### Manually

Just drag and drop the `CodableDictionary.swift` file in the `CodableDictionary` folder into your project.

## Contributing

* Create something awesome, make the code better, add some functionality,
whatever (this is the hardest part).
* [Fork it](http://help.github.com/forking/)
* Create new branch to make your changes
* Commit all your changes to your branch
* Submit a [pull request](http://help.github.com/pull-requests/)

## Contact

Contact me at [wielandweb@gmail.com](mailto:wielandweb@gmail.com)
