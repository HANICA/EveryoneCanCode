import Foundation

public func betterParseJSON(json : String) -> Bool {
    let jsonWithoutSpaces = json.removingWhitespaces()
    print(jsonWithoutSpaces)
    print()
    
    let parsedPhase0 = jsonWithoutSpaces.components(separatedBy: "\":{\"")
    print("Phase 0 \(parsedPhase0.count): \(parsedPhase0)")

    let parsedPhase1 = jsonWithoutSpaces.components(separatedBy: "\":\"")
    print("Phase 1 \(parsedPhase1.count): \(parsedPhase1)")

    return true
}


public func parseJSON(json : String) -> Bool {
    let numOpeningBeerBrackets = json.countInstances(of : "{")
    let numClosingBeerBrackets = json.countInstances(of : "}")
    
    // Rule: there should be the same amount of opening and closing curly braces / beer brackets.
    
    guard numOpeningBeerBrackets == numOpeningBeerBrackets else {
        print("Number of opening beer brackets (\(numOpeningBeerBrackets)) does not match number of closing beer brackets (\(numClosingBeerBrackets)).")
        return false
    }
    
    let numOpeningSquareBrackets = json.countInstances(of : "[")
    let numClosingSquareBrackets = json.countInstances(of : "]")

    // Rule: there should be the same amount of opening and closing square brackets.

    guard numOpeningSquareBrackets == numClosingSquareBrackets else {
        print("Number of opening square brackets (\(numOpeningSquareBrackets)) does not match number of closing square brackets (\(numOpeningSquareBrackets)).")
        if (numOpeningSquareBrackets > numClosingSquareBrackets) {
            print("Hint: Did you forget closing bracket(s)?")
        } else {
            print("Hint: Did you add too many closing brackets?")
        }
        return false
    }
    
    // Rule: the amount of escaped quotes should be even.

    let numEscapedQuotes         = json.countInstances(of : "\"")
    guard numEscapedQuotes % 2 == 0 else {
        print("Unbalanced number of double quotes (\").")
        return false
    }
    
    // Rule: a colon should be preceeded by a \" and followed by either a number or a \"
    
    // First we strip all spaces...
    let jsonWithoutSpaces = json.removingWhitespaces()
    
    // now count the colons
    let numColons         = json.countInstances(of : ":")
    //print("Colons: \(numColons)")
    
    let numColonsPreceededByString = jsonWithoutSpaces.countInstances(of : "\":")
    //print("Colons preceeded by String: \(numColonsPreceededByString)")
    let numColonsFollowedByString  = jsonWithoutSpaces.countInstances(of : ":\"")
    //print("Colons followed by String: \(numColonsFollowedByString)")

    // More difficult: getting all numbers, especially since the decimal points might cause trouble, we thus remove all '.' characters first!

    let jsonNoPoints = jsonWithoutSpaces.removingPoints()
    let amountOfNumbers = jsonNoPoints.components(separatedBy: CharacterSet.decimalDigits.inverted).flatMap { return Int($0) }.count
    
    //print("Amount of numbers: \(amountOfNumbers)")
    
    // so amount of colons should be:
    // procedeed by a string: colons should be same as amount of numColonsPreceededByString
    // and same as numColonsFollowedByString + amountOfNumbers
    // but... a colon can be legally proceeded by a { or [
    
    let numColonsFollowedByBeerBrackets  = jsonWithoutSpaces.countInstances(of : ":{")
    let numColonsFollowedBySquareBrackets  = jsonWithoutSpaces.countInstances(of : ":[")
    
    let strippedText = stripColonsBetweenText(input: jsonWithoutSpaces)
    let numColonsWithinText = strippedText.countInstances(of : ":")

    print("Num colons: \(numColons)")
    print("Numbers: \(amountOfNumbers)")
    print("Colons followed by string: \(numColonsFollowedByString)")
    print("Colons followed by beer bracket: \(numColonsFollowedByBeerBrackets)")
    print("Colons followed by square bracket: \(numColonsFollowedBySquareBrackets)")
    print("Colons inside text: \(numColonsWithinText)")

    print(jsonWithoutSpaces)
    
    guard ((numColons == numColonsPreceededByString) && (numColons == (amountOfNumbers + numColonsFollowedByString + numColonsFollowedByBeerBrackets + numColonsFollowedBySquareBrackets + numColonsWithinText))) else {
        print("There is an issue with the amount of colons vs. keys and values...")
        return false
    }
    
    // a key / values pair should be separated by a comma ','

    return true
}

func stripColonsBetweenText(input : String) -> String {
    var result = input.components(separatedBy: "\":{\"").joined()
    result = result.components(separatedBy: "\":[\"").joined() // brackets
    result = result.components(separatedBy: "\":\"").joined() // string as value
    result = result.components(separatedBy: "\":").joined() // number?
    return result
}

extension String {
    func countInstances(of stringToFind: String) -> Int {
        var stringToSearch = self
        var count = 0
        while let foundRange = stringToSearch.range(of: stringToFind, options: .diacriticInsensitive) {
            stringToSearch = stringToSearch.replacingCharacters(in: foundRange, with: "")
            count += 1
        }
        return count
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension String {
    func removingPoints() -> String {
        return components(separatedBy: ".").joined()
    }
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
