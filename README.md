# realmSwiftTutorial-iOS
RealmSwift 데이터베이스 오픈 라이브러리를 활용한 쇼핑리스트를 만드는 튜토리얼

- RealmSwift 라이브러리의 pod 폴더의 크기가 너무 커서 깃허브에 푸쉬가 되지 않는 문제가 발생해서 프로젝트만 올리기로 하였다.
- RealmSwift 를 사용해서 만들어둔 클래스에 맞추어서 데이터베이스를 구축해보았고 추가, 조회, 삭제, 업데이트 기능을 구현하였다.
- RelamSwift studio 를 활용해서 테이블 또한 볼 수 있었다.

## UITableView 기초
- TableViewDelegate
  - 테이블뷰 델리게이트 객체는 UITableViewDelegate 프로토콜을 채택한다.
  - MVC 패턴 중 Controller 와 관련이 있다.
  - 델리게이트는 테이블뷰의 **시각적인 부분 수정, 행의 선택 관리, 액세서리뷰 지원, 테이블뷰의 개별 행 편집** 가능.
```swift
// 지정된 행이 선택되었음을 알리는 메서드
func tableView(UITableView, didSelectRowAt: IndexPath)

// 지정된 행의 선택이 해제되었음을 알리는 메서드
func tableView(UITableView, didDeselectRowAt: IndexPath)

// 특정 위치 행의 높이를 묻는 메서드
func tableView(UITableView, heightForRowAt: IndexPath)

// 특정 위치 행의 들여쓰기 수준을 묻는 메서드
func tableView(UITableView, indentationLevelForRowAt: IndexPath)

// 특정 섹션의 헤더뷰 또는 푸터뷰를 요청하는 메서드
func tableView(UITableView, viewForHeaderInSection: Int)
func tableView(UITableView, viewForFooterInSection: Int)

// 특정 섹션의 헤더뷰 또는 푸터뷰의 높이를 물어보는 메서드
func tableView(UITableView, heightForHeaderInSection: Int)
func tableView(UITableView, heightForFooterInSection: Int)

// 테이블뷰가 편집모드에 들어갔음을 알리는 메서드
func tableView(UITableView, willBeginEditingRowAt: IndexPath)

// 테이블뷰가 편집모드에서 빠져나왔음을 알리는 메서드
func tableView(UITableView, didEndEditingRowAt: IndexPath?)
```
- TableViewDataSource
  - 테이블뷰 데이터 소스 객체는 UITableViewDataSource 프로토콜을 채택합니다.
  - 테이블뷰를 생성하고 수정하는데 필요한 정보를 테이블뷰 객체에 제공한다.
  - MVC 패턴 중 Model 과 관련이 있다.
  - UITableView 객체에 섹션의 수와 행의 수를 알려주며 행의 삽입, 삭제 및 재정렬하는 기능을 선택적으로 구현 가능하다.
  - @required 로 선언된 두 가지 메서드는 UITableViewDataSource 프로토콜을 채택하 타입에 필수로 구현해야 한다.
```swift
@required 
// 특정 위치에 표시할 셀을 요청하는 메서드
func tableView(UITableView, cellForRowAt: IndexPath) 
 
// 각 섹션에 표시할 행의 개수를 묻는 메서드
func tableView(UITableView, numberOfRowsInSection: Int)
 
@optional
// 테이블뷰의 총 섹션 개수를 묻는 메서드
func numberOfSections(in: UITableView)
 
// 특정 섹션의 헤더 혹은 푸터 타이틀을 묻는 메서드
func tableView(UITableView, titleForHeaderInSection: Int)
func tableView(UITableView, titleForFooterInSection: Int)
 
// 특정 위치의 행을 삭제 또는 추가 요청하는 메서드
func tableView(UITableView, commit: UITableViewCellEditingStyle, forRowAt: IndexPath)
 
// 특정 위치의 행이 편집 가능한지 묻는 메서드
func tableView(UITableView, canEditRowAt: IndexPath)

// 특정 위치의 행을 재정렬 할 수 있는지 묻는 메서드
func tableView(UITableView, canMoveRowAt: IndexPath)
 
// 특정 위치의 행을 다른 위치로 옮기는 메서드
func tableView(UITableView, moveRowAt: IndexPath, to: IndexPath)
```

- TableViewController 클래스에 UITableViewDelegate, UITableViewDataSource 프로토콜을 채택한다.
- storyboard 의 테이블뷰오 연결.
- viewDidLoad() 에서 delegate 와 datasource 를 ``self`` 로 연결


### 완성
<img src ="https://user-images.githubusercontent.com/69136340/109425245-ba6f3f00-7a2a-11eb-868c-bdf681d38740.png" width ="250">
<img src ="https://user-images.githubusercontent.com/69136340/109425229-a9bec900-7a2a-11eb-9f6a-529efd423f04.png" width="500">

### 출처
출처ㅣhttps://jinshine.github.io/2018/11/20/iOS/Realm%20사용방법/
출처ㅣhttps://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html
출처ㅣhttps://woonhyeong.tistory.com/5?category=827228
