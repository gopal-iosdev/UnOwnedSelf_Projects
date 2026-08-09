/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)

 ## Audio Assets

 ### Two ways in

 Unlike colors, audio has both paths available: a loose `.mp3` in `Resources/`, or a **Data Set**
 in an Asset Catalog read through `NSDataAsset`. The data set here is deliberately named
 `Swift_sound_asset_catalog` while holding `Swift_sound.mp3`, so a successful lookup proves the
 catalog's asset name is being resolved rather than the filename - same technique as the imagesets.

 ### Extensions are not optional

 `UIImage(named:)` finds a loose `.png` without an extension. `Bundle.main.url(forResource:withExtension:)`
 has no such fallback - passing `nil` returns `nil`, because the extension is a separate argument
 and omitting it is a different query rather than a lenient one.

 ### Playback doesn't need `needsIndefiniteExecution` here

 Top-level code normally runs to the end and the page finishes, tearing down playback before you
 hear anything. `setLiveView` prevents that on its own, since the page stays alive to keep the view
 on screen - so this page needs no `needsIndefiniteExecution` and no `AVAudioSession` setup.
 Playing a sound *without* a live view is the case that still needs it.

 The `AVAudioPlayer` instances do still have to be retained, which is why they're declared at top
 level. Create one inside a function and it deallocates when that function returns: `play()`
 succeeds and nothing comes out.

 > **Observed behavior** — after adding an audio file to `Resources/`, quit and relaunch Xcode
 > before running. Until you do, `Bundle.main.url(forResource:withExtension:)` returns `nil` for a
 > file that is plainly sitting in the folder - a false negative on entirely correct code. The same
 > trap applies to image assets, and it's the single most likely reason a lookup "doesn't work".
 */
import AVFoundation
import SwiftUI
import PlaygroundSupport

//: ### Loose files in `Resources/`

let audioFromResources = Bundle.main.url(forResource: "Swift_sound", withExtension: "mp3") // works

let audioFromResourcesNoExt = Bundle.main.url(forResource: "Swift_sound", withExtension: nil) // nil - extension is required

//: ### From the Asset Catalog

let audioFromCatalog = NSDataAsset(name: "Swift_sound_asset_catalog")?.data // works

//: ### Players, held at top level so they aren't deallocated mid-playback

let playerFromResources = audioFromResources.flatMap { try? AVAudioPlayer(contentsOf: $0) }

let playerFromResourcesNoExt = audioFromResourcesNoExt.flatMap { try? AVAudioPlayer(contentsOf: $0) }

let playerFromCatalog = audioFromCatalog.flatMap { try? AVAudioPlayer(data: $0) }

struct AudioView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            row("Resources/ with extension", player: playerFromResources)
            row("Resources/ without extension", player: playerFromResourcesNoExt)
            row("Asset Catalog (NSDataAsset)", player: playerFromCatalog)
        }
        .padding()
        .border(Color.gray, width: 2)
        .cornerRadius(5)
    }

    private func row(_ title: String, player: AVAudioPlayer?) -> some View {
        HStack(spacing: 12) {
            Text(player == nil ? "❌" : "✅")

            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(player == nil ? "not found" : "loaded")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button("Play") {
                player?.currentTime = 0
                player?.play()
            }
            .disabled(player == nil)
        }
        .frame(width: 380)
    }
}

demo(
    "Loading audio from Resources/ and an Asset Catalog",
    expecting: "both the extension-qualified file and the data set to load; the bare name to fail"
) {
    PlaygroundPage.current.setLiveView(AudioView())
}
