# UIKit for visionOS

## Introduction

UIKit works perfectly well under visionOS. It should; SwiftUI is built on top of it. Apple has said that loading from XIB and storyboards is deprecated for visionOS. 

## Variable Size Window Scene

This Proof-of-Concept demo changes the size of the window scene. [A SwiftUI app](https://github.com/bwake2012/VariableSizeWindowScene) can also do this, but it's much more straightforward in UIKit.

The app includes buttons inside the view and in an ornament outside it. The buttons inside the view are UIKit. The buttons in the ornament contents are SwiftUI. The app also displays the actual size in a second ornament.

![Variable size window scene, in UIKit, with button and display ornaments](https://github.com/bwake2012/VariableSizeWindowSceneUIKit/blob/main/VariableSizeWindowSceneUIKitOriginal.png?raw=true)
![Variable size window scene, in UIKit, resized.](https://github.com/bwake2012/VariableSizeWindowSceneUIKit/blob/main/VariableSizeWindowSceneUIKitTiny.png?raw=true)

The ornament content SwiftUI views are `SizeButtonOrnamentContent` and `SizeDisplayOrnamentContent`. 
