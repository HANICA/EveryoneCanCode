//: Playground - noun: a place where people can play

import UIKit

var simpleJSONString = "[{\"id\": 1, \"name\": \"Spaghetti and Meatballs\", \"price\": 9.0}]"

var simpleJSONString1 = "[{\"id\": 12, \"name\": \"Spaghetti and Meatballs\", \"price\": 9.0}]"

var otherJSONExample = "{\"glossary\": {    \"title\": \"example glossary\",    \"GlossDiv\": {        \"title\": \"S\",        \"GlossList\": {            \"GlossEntry\": {                \"ID\": \"SGML\",                \"SortAs\": \"SGML\",                \"GlossTerm\": \"Standard Generalized Markup Language\",                \"Acronym\": \"SGML\",                \"Abbrev\": \"ISO 8879:1986\",                \"GlossDef\": {                    \"para\": \"A meta-markup language, used to create markup languages such as DocBook.\",                    \"GlossSeeAlso\": [\"GML\", \"XML\"]                },                \"GlossSee\": \"markup\"            }        }    }}}"
print(betterParseJSON(json : otherJSONExample))

