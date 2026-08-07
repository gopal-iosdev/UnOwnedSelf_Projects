/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)

 ## Video Assets

 ### Same two paths, but the catalog one needs a detour

 A loose `.mp4` in `Resources/` behaves exactly like audio: `Bundle.main.url(forResource:withExtension:)`
 with the extension spelled out, then `AVPlayer(url:)`.

 The Asset Catalog path is where video diverges. `AVAudioPlayer` has an `init(data:)`, so the Audio
 page could hand `NSDataAsset`'s bytes straight to it. **`AVPlayer` has no data initializer at all** -
 it takes a URL, and `AVAsset` is URL-backed too. So bytes from a Data Set have to be written to a
 temporary file first, and `AVPlayer` given that URL.

 Worth noting how this failure differs from the others in this playground: everywhere else a wrong
 approach returns `nil` at runtime. Here it simply doesn't compile - there's no `AVPlayer(data:)` to
 call - so you find out immediately rather than staring at an empty view.

 ### AVKit doesn't load in a playground

 `import AVKit` fails outright with a linker error - it can't resolve its `CoreAudioTypes`
 dependency in the simulator runtime. That takes SwiftUI's `VideoPlayer` off the table, along with
 `AVPlayerViewController` and the transport controls they bring.

 `AVFoundation` loads fine, so the fix is to build the video surface from `AVPlayerLayer` inside a
 `UIViewRepresentable`. The cost is losing the built-in playback controls, hence the explicit Play
 button below.

 > **Observed behavior** — as with every other asset type, quit and relaunch Xcode after adding the
 > video to `Resources/`. Until you do, the lookup returns `nil` for a file that is plainly there.
 */
import AVFoundation
import SwiftUI
import PlaygroundSupport

/*:
 `import AVKit` fails in a playground - it can't resolve its `CoreAudioTypes` dependency in the
 simulator runtime - which rules out SwiftUI's `VideoPlayer`. `AVPlayerLayer` lives in
 `AVFoundation`, which loads fine, so the video surface is built from that instead.
 */

final class PlayerContainerView: UIView {
    override class var layerClass: AnyClass { AVPlayerLayer.self }
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}

struct PlayerLayerView: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> PlayerContainerView {
        let view = PlayerContainerView()
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspect
        return view
    }

    func updateUIView(_ uiView: PlayerContainerView, context: Context) {}
}

//: ### Loose file in `Resources/`

let videoFromResources = Bundle.main.url(forResource: "Swift_video", withExtension: "mp4") // works

//: ### From the Asset Catalog

let videoDataFromCatalog = NSDataAsset(name: "Swift_video_asset_catalog")?.data // works - but it's Data, not a URL

//: `AVPlayer` can't take `Data`, so the bytes are written to a temp file and played from there.

let videoFromCatalogTempURL: URL? = {
    guard let videoDataFromCatalog else { return nil }

    let url = FileManager.default
        .temporaryDirectory
        .appendingPathComponent("Swift_video_from_catalog.mp4")

    do {
        try videoDataFromCatalog.write(to: url)
        return url
    } catch {
        return nil
    }
}()

//: ### Players

let playerFromResources = videoFromResources.map(AVPlayer.init(url:))

let playerFromCatalog = videoFromCatalogTempURL.map(AVPlayer.init(url:))

struct VideoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            row("Resources/ - AVPlayer(url:)", player: playerFromResources)
            row("Asset Catalog - NSDataAsset via temp file", player: playerFromCatalog)
        }
        .padding()
        .border(Color.gray, width: 2)
        .cornerRadius(5)
    }

    private func row(_ title: String, player: AVPlayer?) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(player == nil ? "❌" : "✅")
                Text(title).font(.headline)
            }

            if let player {
                PlayerLayerView(player: player)
                    .frame(width: 320, height: 180)
                    .cornerRadius(8)

                Button("Play") {
                    player.seek(to: .zero)
                    player.play()
                }
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.2))
                    .frame(width: 320, height: 180)
                    .overlay(
                        Text("not available").foregroundStyle(.secondary)
                    )
            }
        }
    }
}

demo(
    "Loading video from Resources/ and an Asset Catalog",
    expecting: "both to play - the catalog one only after its bytes are written to a temp file"
) {
    PlaygroundPage.current.setLiveView(VideoView())
}
