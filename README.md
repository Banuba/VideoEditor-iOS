[![](https://www.banuba.com/hubfs/Banuba_November2018/Images/Banuba%20SDK.png)](https://www.banuba.com/video-editor-sdk)

# Banuba VideoEditor SDK. API Reference.

`VideoEditor` is a core module for interaction between playback modules, export, etc. All transformations with effects, sounds, time, trimming take place inside this module. In order to use exporting, applying effects, or getting a player, first you need to use the essence of the `VideoEditorService` entity and add the necessary video segments or assets to it.

- [VideoEditorService](#VideoEditorService)
    + [Setup with Asset](#Setup-with-Asset)
        + [VideoEditorAssetTrackInfo](#VideoEditorAssetTrackInfo)
            + [Constructor](#Constructor)
            + [Properties and options](#Properties-and-options)
            + [Copy func](#Copy-func)
            + [Replace asset to newest URL](#Replace-asset-to-newest-URL)
            + [Rotate current asset representation](#Rotate-current-asset-representation)
        + [VideoSequence](#VideoSequence)
            + [Constructor](#Constructor)
            + [Remove functionality](#Remove-functionality)
            + [Add functionality](#Add-functionality)
            + [File name helpers](#File-name-helpers)
            + [Duration functionality](#Duration-functionality)
            + [Session helpers](#Session-helpers)
            + [Related properties](#Related-properties)
    + [VideoEditorAsset](#VideoEditorAsset)
        + [Tracks functionality](#Tracks-functionality)
        + [Scaled export](#Scaled-export)
        + [Music functionality](#Music-functionality)
        + [Thumbnails](#Thumbnails)
        + [Reloading](#Reloading)
        + [Related properties](#Related-properties)
- [Applied effects](#Applied-effects)
- [Image generator](#Image-generator)
- [Music Functionality](#Music-functionality)
- [Related propeties](#Related-properties)

## VideoEditorService

VideoEditor is used to transform and transform the primary asset passed to this entity.

### Setup with Asset

`setCurrentAsset` add newest asset to VideoEditorService or replace existing one.

``` swift
 /// Set relevant asset into video editor service.
  /// - Parameters:
  ///   - asset: Input VideoEditorAsset. Optional.
  func setCurrentAsset(_ asset: VideoEditorAsset?)
```

A `VideoEditorAsset` could be created in a number of ways, such as the `VideoEditorAssetTrackInfo` set, the entity of the already converted `VideoSequence` segments. `VideoEditorAsset` requires several additional entire params: `fillAspectRatioRange` setups preffered aspect ratio, `videoResolutionConfiguration` setups preffered video resolution.

#### VideoEditorAssetTrackInfo

This kind of constructor initialize `VideoEditorAsset` with set of `VideoEditorAssetTrackInfo` instances.

``` swift
  /// Expected non-zero video aspect ratio constructor. Apply transform effect after adding required asset.
  /// - Parameters:
  ///   - tracks: Set of asset info params
  ///   - isDebugModeOn: Is debug mode on. Default is false.
  ///   - fillAspectRatioRange: Preffered aspect ratio
  ///   - videoResolutionConfiguration: Resolution configuration
  public init(
    tracks: [VideoEditorAssetTrackInfo],
    isDebugModeOn: Bool = false,
    fillAspectRatioRange: ClosedRange<CGFloat> = CGFloat(0)...CGFloat(0),
    videoResolutionConfiguration: VideoResolutionConfiguration
  )
```

`VideoEditorAssetTrackInfo` is video composition entity with set of options and funcs.

##### Constructor.
``` swift
  /// Expected non-zero video aspect ratio constructor. Apply transform effect after adding required asset.
  /// - Parameters:
  ///   - uuidString: uniq uuidString
  ///   - url: Asset url
  ///   - rotation: Video rotation setting
  ///   - thumbnail: Preview thumbnail
  ///   - fillAspectRatioRange: Preffered aspect ratio range
  ///   - videoResolutionConfiguration: Resolution configuration
  ///   - isGalleryAsset: is track created from gallery
  ///   - isSlideShow: is track created from photo
  ///   - transitionEffectType: Transition effect type
  public init(
    uuidString: String,
    url: URL,
    rotation: AssetRotation,
    thumbnail: UIImage?,
    fillAspectRatioRange: ClosedRange<CGFloat>,
    videoResolutionConfiguration: VideoResolutionConfiguration,
    isGalleryAsset: Bool,
    isSlideShow: Bool,
    transitionEffectType: TransitionType
  )
```

##### Properties and options
Propeties of different conditions, time ranges, avAsset compositions, instructions and etc.

:exclamation: **Important:** **All of properties setups with internal usage. Changing properties from outside doesn't affect anything and errors could be occurs. You could read them, but not to override or changing, it's on your own risk.**

``` swift
  /// UUID string
  let uuidString: String
  /// Video url
  var url: URL
  /// aspect ratio range. Contains video aspect range
  var fillAspectRatioRange: ClosedRange<CGFloat>
  /// Video resolution configuration
  let videoResolutionConfiguration: VideoResolutionConfiguration
  /// Video resolution curent size configuration
  var videoCurentSize: CGFloat?
  /// Track thumbnail
  var thumbnail: UIImage?
  /// Available track thumbnails
  var thumbnails: [UIImage]
  /// Trim time range
  var trimTimeRange: CMTimeRange
  /// Asset rotation
  var rotation: AssetRotation
  /// Video name
  var videoName: String
  /// is track created from gallery
  var isGalleryAsset: Bool
  /// is track created from gallery from photo
  var isSlideShow: Bool
  /// Track composition
  var composition: AVComposition!
  /// Video instruction
  var instructions: [AVVideoCompositionInstructionProtocol]?
  /// Track composition generation error
  var error: Error?
  /// Track composition time range
  var timeRange: CMTimeRange
  /// AVURLAsset
  var urlAsset: AVAsset
  /// Track time range according to composed asset
  var timeRangeInGlobal: CMTimeRang
  /// Transition effect type. Default is without transition effect
  var transitionEffectType: TransitionType
```

##### Copy func
``` swift
  /// Copy current asset info
  func copy() -> VideoEditorAssetTrackInfo
```

##### Replace asset to newest URL
``` swift
  /// Replace asset url
  /// - Parameters:
  ///   - url: Asset url
  func replaceAssetUrl(_ url: URL)
```

##### Rotate current asset representation
``` swift
  /// Rotate video
  /// - Parameters:
  ///   - clockwise: is clockwise rotation
  public func rotate(clockwise: Bool)
```

#### VideoSequence

This kind of constructor initialize `VideoEditorAsset` with `VideoSequence` instance.

``` swift
  /// Expected non-zero video aspect ratio constructor. Apply transform effect after adding required asset.
  /// - Parameters:
  ///   - sequence: Video sequence
  ///   - isDebugModeOn: Is debug mode on. Default is false.
  ///   - isGalleryAssets: Is asset from Gallery.
  ///   - isSlideShow: Is video asset created from image.
  ///   - fillAspectRatioRange: Preffered aspect ratio
  ///   - videoResolutionConfiguration: Resolution configuration
  convenience public init(
    sequence: VideoSequence,
    isGalleryAssets: Bool,
    isSlideShow: Bool,
    isDebugModeOn: Bool = false,
    fillAspectRatioRange: ClosedRange<CGFloat> = CGFloat(0)...CGFloat(0),
    videoResolutionConfiguration: VideoResolutionConfiguration
  )
```

`VideoSequence` is video segments entity with set of options and funcs. 
`VideoSequence` Could manage order of video segments, add newest videos to sequence, remove existing and etc.

##### Constructor
`folderURL` setups folder where video segments should store during session.
``` swift
  /// VideoSequence constructor
  /// - Parameters:
  ///   - folderURL: Sequence folder url
  public required init(
    folderURL: URL
  )
```

##### Remove functionality
``` swift
  /// Removes sequence data and folder.
  func remove()
  
  /// Remove existing videos from video sequence
  func removeVideos()
  
  /// Completle delete video from video sequence with all data
  @discardableResult
  func deleteVideo(_ video: VideoSequenceItem) -> Bool
  
  /// Restore removed videos
  func restoreRemovedVideos() 
  
  /// Sequence has removed videos
  var hasRemovedVideos: Bool
  
  /// Removes video from sequence to removedVideos property. Removed video can be restored
  @discardableResult
  func removeVideo(_ video: VideoSequenceItem) -> Bool
```

##### Add functionality

``` swift
  /// Adds video to the sequence by copying video to sequence folder
  /// - Parameters:
  ///   - uuidString: uniq identifier
  ///   - url: url to the video.
  ///   - speed: video speed. Default is 1.0.
  ///   - isGalleryAsset: describes video source. Defaults is false
  ///   - isRemovedVideo: describes is video removed. Default is false
  ///   - rotation: determines video angle rotation. Default is .none
  ///   - preview: video preview image. Default is nil
  ///   - shouldMoveFile: if true will move video file to the sequence. Otherwise, will copy.
  ///   - shouldUseUniqName: if true uniq name will be generated for video name. Otherwise video name will be extracted from video url.
  @discardableResult
  func addVideo(
    uuidString: String = UUID().uuidString,
    at url: URL,
    speed: Double = 1.0,
    isGalleryAsset: Bool = false,
    isSlideShow: Bool,
    isRemovedVideo: Bool = false,
    rotation: AssetRotation = .none,
    preview: UIImage? = nil,
    shouldMoveFile: Bool = true,
    shouldUseUniqName: Bool = true,
    transition: TransitionType
  ) -> VideoSequenceItem?
  
  /// Adds video to the sequence by adding copy of existing video
  /// - Parameters:
  ///   - url: url to the video.
  ///   - speed: video speed. Default is 1.0.
  ///   - isGalleryAsset: describes video source. Defaults is false
  ///   - isRemovedVideo: describes is video removed. Default is false
  ///   - rotation: determines video angle rotation. Default is .none
  ///   - preview: video preview image. Default is nil
  ///   - shouldMoveFile: if true will move video file to the sequence. Otherwise, will copy.
  ///   - shouldUseUniqName: if true uniq name will be generated for video name. Otherwise video name will be extracted from video url.
  @discardableResult
  func addVideoCopy(
    uuidString: String,
    at url: URL,
    speed: Double = 1.0,
    isGalleryAsset: Bool,
    isSlideShow: Bool,
    isRemoved: Bool = false,
    rotation: AssetRotation = .none,
    preview: UIImage? = nil,
    transition: TransitionType
  ) -> VideoSequenceItem?
  
  /// Tell sequence that sequence video did update
  func didUpdateVideo(_ video: VideoSequenceItem)
```

##### File name helpers
``` swift
  /// Get video file names from directory url
  /// - Parameters:
  ///  - directory: Directory url
  func getVideoFileNames(in directory: URL) -> SequnceVideos
```

##### Duration functionality
``` swift
  /// Sequnece duration with video speed counting enabled or not
  func totalDuration(
    isSpeedCountingEnabled: Bool = true
  ) -> TimeInterval
  
  /// Get total durations with speed counting extension
  func getDurations(
    isSpeedCountingEnabled: Bool = true
  ) -> [TimeInterval]
```

##### Session helpers
``` swift
  /// Restore VideoSequence from folder url
  static func restore(folder: URL) -> VideoSequence
```

##### Related properties.

:exclamation: **Important:** **All of properties setups with internal usage. Changing properties from outside doesn't affect anything and errors could be occurs. You could read them, but not to override or changing, it's on your own risk.**

``` swift
  /// Sequence folder url
  let folderURL: URL
  /// modification date of sequence
  var modificationDate: Date
  /// Sequence preview
  var preview: UIImage?
  /// Sequence videos
  var videos: [VideoSequenceItem]
  /// Sequence uniq id
  var sequenceId: String
  /// Durations of sequence videos
  var durations: [TimeInterval]
  /// Durations of sequence videos without speed extension
  var initialDurations: [TimeInterval]
  /// Is sequence composed with gallery videos only
  var isGallerySequence: Bool
```

### VideoEditorAsset

The main entity that allows you to work with adding music, pre-exporting, reloading a composition and etc.

#### Tracks functionality

Each segment of `VideoEditorAsset` is video/audio representation of mutable compositions, so `VideoEditorAsset` could be implemented with trimming, music and other functionalities.

Following funcs could be used to remove existing video segments or add newest ones.
``` swift
  /// Add tracks
  /// - Parameters:
  ///   - tracks: set of required tracks
  ///   - index: index in asset for new tracks
  func addTracks(_ tracks: [VideoEditorAssetTrackInfo], atIndex index: Int)
  /// Remove track
  /// - Parameters:
  ///   - index: Position index
  func removeTrack(at index: Int)
  /// Remove track
  /// - Parameters:
  ///   - track: reauired track
  func removeTrack(_ track: VideoEditorAssetTrackInfo)
  /// Replace track
  /// - Parameters:
  ///   - fromIndex: Initial position index
  ///   - toIndex: Desired position index
  func moveTrack(fromIndex: Int, toIndex: Int)
  /// Reorder tracks
  /// - Parameters:
  ///   - reorderedTracks: reordered tracks array
  func reorderTracks(withTracks reorderedTracks: [VideoEditorAssetTrackInfo])
```

#### Scaled export

Pre-export functionality to get current Asset composition representation.
``` swift
  /// Export current asset
  /// - Parameters:
  ///   - outputUrl: Ouput file URL
  ///   - quality: Preset quality
  ///   - trimData: Video trimming params
  ///   - completion: Track id
  func exportScaled(
    outputUrl: URL,
    quality: String,
    trimData: VideoTrimData?,
    completion: ((Error?) -> Void)?
  )
```

#### Music functionality

`VideoEditorAsset` could contains different types of music: voice, tracks and etc. So you could add your own audio tracks with infinite counting and any time ranges.
``` swift
  /// Change music track position
  /// - Parameters:
  ///   - musicTrack: Reuired music track
  func changeMusicTrackPosition(_ musicTrack: MediaTrack) -> Bool=
  
  @discardableResult
  /// Add music track
  /// - Parameters:
  ///   - musicTrack: Reuired music track
  func addMusicTrack(_ musicTrack: MediaTrack) -> (compositionTrack: AVMutableCompositionTrack, assetTrack: AVAssetTrack)? 
  
  @discardableResult
  /// Remove music track
  /// - Parameters:
  ///   - trackId: Track id
  func removeMusic(trackId: CMPersistentTrackID) -> Bool
```

#### Thumbnails

Thumbnails userd for displaying trimming frames.
``` swift
   /// Load thumbnails
   func loadNonExistingThumbnails(completion: (() -> ())?)
```

#### Reloading

`VideoEditorAsset` could be reloaded with newest options and settings.
``` swift
  /// Reload current composition
  func reloadComposition()
```

#### Related properties

:exclamation: **Important:** **All of properties setups with internal usage. Changing properties from outside could produce issues. It's on your own risk.**
``` swift
  /// Composed composition
  var composition: AVMutableComposition!
  /// Instructions
  var instructions: [AVVideoCompositionInstructionProtocol]?
  /// Creation composition errors
  var errors: [Error]
  /// Tracks composed in asset
  var tracksInfo: [VideoEditorAssetTrackInfo]
  /// Video resolution configuration
  let videoResolutionConfiguration: VideoResolutionConfiguration
  /// Video resolution current size
  var videoResolutionCurrentSize: CGSize?
  /// Video aspect ratio range
  var fillAspectRatioRange: ClosedRange<CGFloat>
  /// Music tracks placed in asset
  var musicTracks: [VideoEditorAssetMusicTrack]
```

## Applied effects

The following methods allow you to work with effects, namely, apply any effect that fits the interface `VideoEditorFilerModel`, bypassing the effects API, get a list of all applied effects, delete selected effects, etc.

:exclamation: **Important:** **Applying your own `VideoEditorFilterModel` requires strong technical skills, easiest way is to use `VEEffect` API existing effects.**

``` swift
  /// Apply filter to editor effects stack
  /// - Parameters:
  ///   - effectModel: Video editor filter model
  ///   - start: When filter starts
  ///   - end: When filter ends
  ///   - removeSameType: Remove the same filter type if effect exist.
  func applyFilter(effectModel: VideoEditorFilterModel, start: CMTime, end: CMTime, removeSameType: Bool)
  /// Get current speed extension.
  /// - Parameters:
  ///   - time: Relevant time.
  func getSpeed(at time: CMTime) -> Float
  /// Undo last editor effect
  /// - Parameters:
  ///   - type: Editor effect type.
  func undoLast(type: EditorEffectType) -> EditorCompositionEffectProtocol?
  /// Undo last editor effect
  /// - Parameters:
  ///   - id: Editor effect id.
  func undo(withId id: UInt)
  /// Undo all editor effects.
  /// - Parameters:
  ///   - type: Editor effect type.
  func undoAll(type: EditorEffectType)
  /// Start current filter
  /// - Parameters:
  ///   - effectModel: Video editor effect model.
  ///   - at: Start time.
  func startCurrentFilter(effectModel: VideoEditorFilterModel, at: CMTime)
  /// End current filter
  /// - Parameters:
  ///   - at: Start time.
  func endCurrentFilter(at: CMTime)
  /// Get current applied effects with relevant type.
  /// - Parameters:
  ///   - type: Editor effect type.
  func getCurrentAppliedEffects(type: EditorEffectType) -> [EditorCompositionEditableEffectProtocol]
  /// Get current applied effects.
  func getCurrentAppliedEffects() -> [EditorCompositionEditableEffectProtocol]
  /// Store current applied effects
  func storeStack()
  /// Restore applied effects
  func restoreStack()
  /// Has changes in applied effects
  func hasChangesInAppliedEffects() -> Bool 
  /// Get all current effects
  /// - Parameters:
  ///  - time: Relevant time
  func getAllEffects(at time: CMTime) -> [EditorCompositionEditableEffectProtocol]
  /// Getting the effects that the editor contains
  /// - Parameters:
  ///   - type: Editor effect type.
  func getEditorEffects(type: EditorEffectType) -> [VideoEditorFilterModel]
  /// Adding effects that the editor can operate on.
  /// - Parameters:
  ///   - effects: Set of video editor effects models
  func setEditorEffects(_ effects: [VideoEditorFilterModel])
```
## Image generator

Image generator for `VEPlayback` API usage.
``` swift
  /// Get image generator.
  func getImageGenerator() -> AVAssetImageGenerator?
```

## Music functionality

`VideoEditorService` could reattach existing `VideoEditorAsset` music track with relevant mutable composition.
``` swift
  /// Reattach existing music tracks with relevant mutable asset composition
  /// - Parameters:
  ///  - mutableAsset: AVMutableComposition
  func reattachMusicTracks(_ mutableAsset: AVMutableComposition)
```

Also `VideoEditorService` could manage audio/video volume and etc.
``` swift
  /// Set audio track volume
  /// - Parameters:
  ///   - volume: Audio track volume
  ///   - player: Player for audio track
  func setAudioTrackVolume(_ volume: Float, to player: VideoEditorPlayable?)
  /// Set audio track volume
  /// - Parameters:
  ///   - volume: Audio track volume
  func setAudioTrackVolume(_ volume: Float) 
  /// Is audio track volume did changed
  func isAudioTrackVolumeChanged() -> Bool
  /// Return audio track volume
  func audioTrackVolume() -> Float
  /// Is video editor service has audio track
  func hasAudioTrack() -> Bool
```

## Related properties

`VideoEditorService` has propties which you could operate on, such as different conditions, instructions, main `VideoEditorAsset`instance and etc.

Number of exisitng videos.
``` swift
  /// Get number of existing video parts
  func videoPartsCount() -> Int
``` 

Asset properties.
:exclamation: **Important:** **All of properties setups with internal usage. Changing properties from outside doesn't affect anything and errors could be occurs. You could read them, but not to override or changing, it's on your own risk.**
``` swift
  /// Editable video editor asset
  public var videoAsset: VideoEditorAsset?
  /// AVAsset
  public var asset: AVAsset?
```

Additional settings could be setupped by your own.
``` swift
  public var videoSize: CGSize
  /// Export frame rate duration. Default is 30.
  public var exportFrameDuration: CMTime
  /// Audio mixer for input and ouput editable video asset and composition.
  public var audioMixer: AudioMixer?
```
