# 2024-NC2-M40-Siri
![NC2 Act 썸네일_최종](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M40-Siri/assets/92905500/4a704bcc-971b-4982-8754-97745125623e)

## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)


## 💡 About Siri
Siri는 사용자와 음성으로 상호작용하며 업무를 처리할 수 있게 도와주는 비서입니다! <br/>
시리로 할 수 있는 것들은 정말 많습니다. <br/>
비서처럼 전화도 대신 걸어주고, 메시지도 보내주고, 주차된 차의 위치도 확인해주고 앱을 통해 다양한 제어들도 대신 해줄 수 있습니다. <br/>


## 🎯 What we focus on?
Siri, App Intents, Siri ShortCuts을 사용해서 사용자가 음성으로 말하면, 특정한 기능을 직접 실행하지 않아도 바로 수행할 수 있도록 하는 부분에 집중했습니다. <br/>

## 💼 Use Case
아이를 안고 수유할 때,  간단한 음성 명령으로 수유 정보를 기록하자! <br/>

> 저희는 이 기술을 가지고 아이데이션을 할 때, 시리의 강점인 음성명령부터 생각했습니다. 화면을 보고 있을 때보다는 두 손을 쓸 수 없는 상황에 초점을 맞췄고 자연스럽게 어떤 사람들이 비서의 역할이 필요할지를 고민했습니다. <br/>
그래서 내가 필요한 상황과 타인이 필요한 상황을 나열해보면서 더 engage가 끌어올려지는 ‘아이에게 수유하는 상황’ 으로 결정했습니다!<br/>
Use Case 결정 과정에서는 먼저 사용자의 상태와 니즈를 구체적으로 적어보았고, 그 결과 30대 초보 신생아의 부모가 혼자 아기를 안고 수유할 때 간단한 음성 명령으로 시리가 수유 정보를 대신 기록하게 만드는 것으로 결정되었습니다!<br/>

## 🖼️ Prototype
> 저희 서비스 ‘기록할게’ 는 최대한 사용자가 간단하게 수유 정보를 기록할 수 있도록 한 화면에 모든 기능을 담았습니다. <br/><br/>
아기에 대한 정보를 기록하는 앱이므로 따뜻한 느낌을 주고자 노란색, 주황색을 사용하였고 사용자가 앱에 들어와서 자주 볼 정보(다음 알람 시간)와 필연적으로 기록해야하는 수유량 정보를 빠르게 입력할 수 있도록 포인트 컬러를 사용했습니다. 또한 아이와 늘 함께 있는 신생아 부모의 상황을 고려하여 한손으로도 수유량을 입력할 수 있게 스텝퍼를 사용하였습니다. <br/><br/>
수유 정보는 시리를 불러 명령하면 기록됩니다. 수유량 입력 부분은 수유 과정에서 남는 수유량이 항상 발생한다는 점, 이로 인해 기록이 종료된 뒤 시리로 음성 명령을 바로 받는다면 수유 상황이 종료되지 않은채로 바로 수유량을 계산해야하기 때문에 혼란스러울 수 있다는 점을 고려했습니다. <br/> 
따라서 수유 상황 정리 후 사용자가 직접 앱에 들어와서 기록할 수 있도록 구현했습니다. <br/>
<br/>


![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M40-Siri/assets/92905500/e9e21c80-6fbe-4595-b9f2-c7588efa2acb) <br/>
아이를 두손에 안고 있어도 시리를 부르는 것으로 간단하게 기록이 가능한데요, 디바이스가 멀리 있어도 <시리야 기록할게, 수유 시작!> 이라고 말하면 바로 기록을 시작합니다. <br/>
수유가 끝나면 <시리야 기록할게, 수유 끝났어!> 라고 말하면 기록이 종료되고, 종료된 시점으로부터 3시간 뒤 알람이 자동으로 설정됩니다.<br/>
앱을 켜면 방금 기록한 내용들을 확인할 수 있고, 스텝퍼로 수유량을 기록합니다. <br/><br/>

![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M40-Siri/assets/92905500/2ace9a19-05d9-47b2-ab57-cdf501a48c3f) <br/>
알람을 삭제하면 삭제된 것을 확인할 수 있습니다. <br/><br/>

![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M40-Siri/assets/92905500/26bdad87-303d-40e4-877e-e28211883dd6) 
![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M40-Siri/assets/92905500/76cc35a1-017d-41e5-af2e-670134298229) <br/>

알람 시간 수정과 삭제가 가능하며, 기록 날짜를 선택해서 볼 수 있습니다. <br/><br/>


## 🛠️ About Code
‘기록할게’ 앱에는 두가지 핵심 기능이 정의되어 있습니다!
1. 수유를 시작할 때, 시작 시간을 기록하기
2. 수유를 마칠 때, 끝난 시간을 기록하고 3시간 뒤에 알람을 설정하기
<details><summary>code
</summary>

```js
class FeedingManager {
	func startFeeding() {...}
	func finishFeeding() {...}
}

class AlarmManager {
	func scheduleAlarm() {...}
}

// 1번기능: 수유 시작시간 기록
FeedingManager.startFeeding()

// 2번기능: 수유 종료시간 기록 + 알람 설정
FeedingManager.finishFeeding()
AlarmManager.scheduleAlarm()
```
</details>

이 기능을, 사용자가 꼭 직접 앱을 열지 않아도 언제든 사용할 수 있도록
앱 속의 기능을 ‘사용자와 시스템에게 노출’시켜 줄 수 있는데요!
‘App Intents’ 프레임워크를 활용해 쉽고 간단하게 구현할 수 있습니다.

>App Intents 프레임워크로, 동작 정의
<details><summary>code
</summary>

```js
import AppIntents

struct StartFeedingIntent: AppIntent {
    static let title: LocalizedStringResource = "수유 시작"
    
    func perform() throws -> some IntentResult & ProvidesDialog {
            FeedingManager.shared.startFeeding(startTime: Date())
        return .result(dialog: "네, 기록을 시작할게요~")
    }
}

struct FinishFeedingIntent: AppIntent {
    static let title: LocalizedStringResource = "수유 종료"
    
    func perform() throws -> some IntentResult & ProvidesDialog {
        DispatchQueue.main.async {
            FeedingManager.shared.endFeeding(endTime: Date())
            
            let alarmTime = Calendar.current.date(byAdding: .hour, value: 3, to: Date())!
            AlarmManager.shared.scheduleAlarm(at: alarmTime, withTitle: "수유시간", andBody: "아기 밥먹일 시간이에요!")
        }
        return .result(dialog: "고생하셨어요! 3시간 뒤에 알려드릴게요!")
    }
}
```
</details>

이렇게 노출된 Intent는, 사용자가 단축어 앱에서 사용할 수 있는데요
사용자가 직접 단축어를 설정하지 않아도 되도록, 기본 단축어를 정의해서 제공할 수 있습니다!
한 앱당 최대 10개의 기본 단축어를 생성할 수 있습니다

>App Shortcuts Provider로, 기본 단축어 생성
<details><summary>code
</summary>

```js
import AppIntents

// 단축어 기본 제공
struct FeedingShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: StartFeedingIntent(),
            phrases: ["\(.applicationName) 수유 시작",
                      "\(.applicationName) 맘마먹자",
                     "\(.applicationName) 분유 먹일게",
                     "\(.applicationName) 밥 먹일게"],
            shortTitle: "수유 시작",
            systemImageName: "waterbottle"
        )
        AppShortcut(
            intent: FinishFeedingIntent(),
            phrases: ["\(.applicationName) 수유종료",
                      "\(.applicationName) 다먹었다",
                     "\(.applicationName) 수유 끝났어",
                     "\(.applicationName) 수유 끝",
                     "\(.applicationName) 다 먹였어"],
            shortTitle: "수유 종료",
            systemImageName: "waterbottle.fill"
        )
    }
}
```
</details>

