## 1.0.0

- Initial version, created by Stagehand

## 1.0.1

- fixed `TypeToken`, now can use '==' operator to compare two `TypeToken`

## 1.0.2

 - remove `dart_format.dart` and replace with `package:dart_style`

## 1.0.2+1

- bug fixed

## 1.0.2+2

- bug fixed

## 1.0.3

- New constructor of `MetaSpec`
    + `MetaSpec.ofInstance(String instanceName)`
    + `MetaSpec.ofConstructor(TypeToken type, {List<ParameterSpec> parameters})`
    
## 1.0.4

- support generic type

## 1.0.4+1

- bug fixed

## 1.0.4+2

- bug fixed

## 1.0.5

- support operator method

## 1.0.5+4

- fix bugs of dependencies

## 1.0.6

- detach `TypeToken` to a independent library

## 1.0.6+1

- classes now support "abstract"

## 1.0.6+2

- methods now support "abstract" and "asynchronous"

## 1.0.6+3

- bug fixed for issue-#3