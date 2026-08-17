# UnOwnedSelf_Projects

Public repo holding the companion Xcode playgrounds for unownedself.com — one
folder per article. Being public is the point: the blog fetches code from
`raw.githubusercontent.com` at build time, so an article never has a pasted copy
that can drift out of sync.

## Layout

One folder per article, each with a `README.md` and a `.playground`:

    unowned-self-swift/     -> posts/unowned-self-swift
    xcode-playgrounds/      -> tools/xcode-playgrounds
    Singleton/              in progress

Inside a multi-page playground:

    Pages/       one .xcplaygroundpage per topic
    Sources/     shared helpers, compiled once
    Resources/   images, audio, video

## Playground rules

- **Page order comes from the explicit `<pages>` element in
  `contents.xcplayground`**, not from filenames. A page missing from that list
  disappears from the playground entirely — this is the first thing to check
  when a page "vanishes".
- Page names are spaced Title Case: `Image Assets`, `LiveView SwiftUI`.
- Helpers in `Sources/` are a separate compilation unit, so anything a page uses
  must be marked `public` — including initializers.
- Each page opens with the same nav header:

      [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)

- **Assets added to `Resources/` don't resolve until Xcode is quit and
  relaunched.** Correct code fails, which reads as a code bug. Check this before
  debugging anything asset-related.

## Image loading in playgrounds

Verified by running `ImageAssets.xcplaygroundpage` in `XcodePlaygrounds.playground`.

Asset Catalogs **are** compiled inside playgrounds. Drop a `.xcassets` into a
page's `Resources/` and PNG, JPEG, and SVG all resolve through `UIImage(named:)`.
Two details in that page prove real compilation rather than a filename fallback:
each imageset is named differently from the file inside it, yet lookup still
succeeds; and the SVG renders, which requires `actool` processing it with
`"preserves-vector-representation": true` — iOS has no runtime SVG decoder.

- SwiftUI's `Image("name")` does **not** resolve those catalog names, even with
  `bundle: .main` passed explicitly, while `UIImage(named:)` does. Undocumented;
  observed, not explained. Workaround: `Image(uiImage: UIImage(named:)!)`.
- Loose files in `Resources/` with no catalog behave differently again: `.png`
  resolves by name alone; `.jpeg`/`.jpg` needs the extension in the string
  (undocumented, observed only); `.svg` never loads by any `UIImage` initializer.

## Swift and API claims

- Never assert Apple API behavior from memory. Check the documentation, or say
  plainly that the claim is untested.
- Never invent API names, method signatures, or availability versions. If you
  aren't sure something exists, say so.
- When behavior is undocumented, say that, and say what was actually observed.
  "Observed, not documented" beats stating it as fact.
- Tests follow Essential Developer conventions: `sut` for the system under test,
  `trackForMemoryLeaks` for lifecycle assertions.

## Publishing

Work on `article/<Name>` branches, matching the blog repo.

**Merge here before the blog build runs.** The blog's `ghcode` shortcode fetches
at ref `main`; code sitting on an unmerged branch will fail the blog build with a
fetch error, not a warning.

When adding a project, add its row to the table in the root `README.md` — project
folder, published post, one-line description.
