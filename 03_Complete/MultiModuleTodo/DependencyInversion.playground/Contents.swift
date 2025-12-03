import SwiftUI
import PlaygroundSupport

/*:
 このPlaygroundでは、画面遷移（Navigation）の実装を例に、
 依存性逆転の法則（DIP）を適用していく過程を3つのステップで解説します。
 */

// 共通の遷移先View
struct DestinationView: View {
    var body: some View {
        Text("遷移先")
    }
}

// MARK: - Level 1: ViewからViewへ直接遷移
/*:
 Level1ViewがDestinationViewに依存している
 */

struct Level1View: View {
    var body: some View {
        NavigationLink("Level 1: Direct Navigation") {
            // ❌ 悪い点: 遷移先のViewを直接指定している (密結合)
            DestinationView()
        }
    }
}
/*
初学者の方々へ
これが「悪い書き方」というわけじゃないです
シンプルでどこに遷移するのか一目瞭然というメリットがあります

モジュール分割という観点でいうと「目的に合ってない書き方」というだけです
*/

// MARK: - Level 2: Routerクラスへの分離
/*:
 ###
 Level2ViewがDestinationViewと紐付いていない

 だけどLevel2ViewがRouterと紐付いていて、
 Level2RouterがDestinationViewと紐付いている

 遷移を1箇所で管理するという点で意味はあるが
 モジュール分割という観点では意味がない

 */

class Router {
    func goDestination() -> some View {
        DestinationView()
    }
}

struct Level2View: View {
    // ❌ 悪い点: 具体的なRouterクラスに依存している
    let router = Router()
    
    var body: some View {
        NavigationLink("Level 2: Router Object") {
            // ⭕️ 良い点: ViewとView自体は分離された
            router.goDestination()
        }
    }
}

// MARK: - Level 3: RouterをProtocol化 (DIP適用)
/*:
 ###
 Level3ViewはRouterProtocolに依存している
 RouterProtocolは何にも依存していない

 RouterImplはDestinationViewに依存している

 Level3Viewのインスタンスを生成時に実際のRouterImplを渡す
 */

protocol RouterProtocol {
    func goDestination() -> AnyView
}

struct Level3View: View {
    // ⭕️ 良い点: 何にも紐付いていないRouterProtocolとしかViewは紐付いていない
    let router: RouterProtocol

    var body: some View {
        NavigationLink("Level 3: DIP Router") {
            // ⭕️ 良い点: ViewとView自体は分離された
            router.goDestination()
        }
    }
}

class RouterImpl: RouterProtocol {
    func goDestination() -> AnyView {
        AnyView(DestinationView())
    }
}

// MARK: - 確認用 Root View
struct RootView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Level1View()

                Level2View()

                // インスタンス生成時に実際の遷移をさせるRouterImplを渡す
                Level3View(router: RouterImpl())
            }
        }
    }
}

/*
初学者の方々へ
これが「良い書き方」というわけじゃないです

モジュール分割ができるというメリットが得られますが
- 複雑でどこに遷移するのか分かりづらい
- Routerに遷移を書くというルールを管理するコストが増える
- 遷移先が増える度にRouterImplとRouterProtocolに同じメソッドを生やすのがめんどくさい
というデメリットがあります

モジュール分割のメリットを得たいなら、このデメリットを受け入れる
という取捨選択をしているだけです
*/

// Live Viewを設定してプレビューを表示
PlaygroundPage.current.setLiveView(RootView())
