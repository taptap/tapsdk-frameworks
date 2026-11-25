Pod::Spec.new do |s|
  s.name             = 'TapTapSDK'
  s.version          = '4.11.2'
  s.summary          = 'TapTap SDK 统一接入方式，支持按需引入各个功能模块'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
  TapTap SDK 提供了 TapTap 游戏服务的完整功能，包括：
  - 数据分析（Core）
  - 用户登录（Login）
  - 成就系统（Achievement）
  - 排行榜（Leaderboard）
  - 内嵌动态（Moment）
  - 合规认证（Compliance）
  - 云存档（CloudSave）
  - 好友系统（Relation/RelationLite）
  - 用户资料（Profile）
  - 分享功能（Share）

  支持两种使用方式：
  1. 独立 Pod 方式（推荐现有用户）：pod 'TapTapLoginSDK'
  2. Subspec 方式（推荐新用户）：pod 'TapTapSDK/Login'
  DESC

  s.homepage         = 'https://github.com/taptap/tapsdk-frameworks'
  s.license          = { :type => "MIT" }
  s.author           = 'TapTap'
  s.source           = { :git => 'https://github.com/taptap/tapsdk-frameworks.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.static_framework = true

  # 默认不安装任何模块，用户需要显式指定需要的 subspec
  s.default_subspecs = 'Core'

  # ==================== Gid 模块 ====================
  s.subspec 'Gid' do |gid|
    gid.vendored_frameworks = [
      "iOS/Frameworks/TapTapBasicToolsSDK.xcframework",
      "iOS/Frameworks/THEMISLite.xcframework",
      "iOS/Frameworks/TapTapNetworkSDK.xcframework",
      "iOS/Frameworks/TapTapGidSDK.xcframework",
      "iOS/Frameworks/tapsdkcorecpp.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]

    gid.frameworks = ['UIKit', 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'GameController']
    # Static XCFramework resources are not automatically copied by CocoaPods.
    # Keep each manifest in its own named bundle to avoid filename collisions.
    gid.resource_bundles = {
      'TapTapBasicToolsSDKPrivacy' => ["iOS/Frameworks/TapTapBasicToolsSDK.xcframework/ios-arm64/TapTapBasicToolsSDK.framework/PrivacyInfo.xcprivacy"],
      'THEMISLitePrivacy' => ["iOS/Frameworks/THEMISLite.xcframework/ios-arm64/THEMISLite.framework/PrivacyInfo.xcprivacy"]
    }
    gid.libraries = ['c++']
    gid.xcconfig = {
      'OTHER_LDFLAGS' => '-lz.1'
    }
    # 禁用 auto-linking 以避免 Xcode 15+ 误链接 CoreAudioTypes（header-only framework）
    gid.pod_target_xcconfig = {
      'CLANG_MODULES_AUTOLINK' => 'NO'
    }
  end

  # ==================== Core 模块 ====================
  s.subspec 'Core' do |core|
    core.vendored_frameworks = "iOS/Frameworks/TapTapCoreSDK.xcframework"
    core.dependency 'TapTapSDK/Gid'
    core.resource_bundles = {
      'TapTapCoreSDKPrivacy' => ["iOS/Frameworks/TapTapCoreSDK.xcframework/ios-arm64/TapTapCoreSDK.framework/PrivacyInfo.xcprivacy"]
    }

    core.frameworks = ['UIKit', 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'GameController']
    core.library = 'c++'
  end

  # ==================== Login 模块 ====================
  s.subspec 'Login' do |login|
    login.vendored_frameworks = [
      "iOS/Frameworks/TapTapLoginSDK.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    login.resources = 'iOS/Frameworks/TapTapLoginResource.bundle'
    login.dependency 'TapTapSDK/Core'

    login.frameworks = ['UIKit', 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'GameController']
    login.library = 'c++'
  end

  # ==================== Achievement 模块 ====================
  s.subspec 'Achievement' do |achievement|
    achievement.resource_bundles = {
      'TapTapAchievementSDKPrivacy' => ["iOS/Frameworks/TapTapAchievementSDK.xcframework/ios-arm64/TapTapAchievementSDK.framework/PrivacyInfo.xcprivacy"]
    }
    achievement.vendored_frameworks = [
      "iOS/Frameworks/TapTapAchievementSDK.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    achievement.resources = 'iOS/Frameworks/TapTapAchievementResource.bundle'
    achievement.dependency 'TapTapSDK/Login'
  end

  # ==================== Moment 模块 ====================
  s.subspec 'Moment' do |moment|
    moment.resource_bundles = {
      'TapTapMomentSDKPrivacy' => ["iOS/Frameworks/TapTapMomentSDK.xcframework/ios-arm64/TapTapMomentSDK.framework/PrivacyInfo.xcprivacy"]
    }
    moment.vendored_frameworks = [
      "iOS/Frameworks/TapTapMomentSDK.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    moment.resources = 'iOS/Frameworks/TapTapMomentResource.bundle'
    moment.dependency 'TapTapSDK/Login'
  end

  # ==================== Compliance 模块 ====================
  s.subspec 'Compliance' do |compliance|
    compliance.vendored_frameworks = [
      "iOS/Frameworks/TapTapComplianceSDK.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    compliance.resources = 'iOS/Frameworks/TapTapComplianceResource.bundle'
    compliance.dependency 'TapTapSDK/Login'
    compliance.resource_bundles = {
      'TapTapComplianceSDKPrivacy' => ["iOS/Frameworks/TapTapComplianceSDK.xcframework/ios-arm64/TapTapComplianceSDK.framework/PrivacyInfo.xcprivacy"]
    }
  end

  # ==================== CloudSave 模块 ====================
  s.subspec 'CloudSave' do |cloudsave|
    cloudsave.resource_bundles = {
      'TapTapCloudSaveSDKPrivacy' => ["iOS/Frameworks/TapTapCloudSaveSDK.xcframework/ios-arm64/TapTapCloudSaveSDK.framework/PrivacyInfo.xcprivacy"]
    }
    cloudsave.vendored_frameworks = [
      "iOS/Frameworks/TapTapCloudSaveSDK.xcframework",
      "iOS/Frameworks/cloudsave_sdk.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    cloudsave.dependency 'TapTapSDK/Login'
    cloudsave.xcconfig = {
      'OTHER_LDFLAGS' => '-lz.1'
    }
    # 禁用 auto-linking 以避免 Xcode 15+ 误链接 CoreAudioTypes（header-only framework）
    cloudsave.pod_target_xcconfig = {
      'CLANG_MODULES_AUTOLINK' => 'NO'
    }
  end

  # ==================== Share 模块 ====================
  s.subspec 'Share' do |share|
    share.vendored_frameworks = "iOS/Frameworks/TapTapShareSDK.xcframework"
    share.dependency 'TapTapSDK/Core'
  end

  # ==================== Profile 模块 ====================
  s.subspec 'Profile' do |profile|
    profile.resource_bundles = {
      'TapTapKingfisherPrivacy' => ["iOS/Frameworks/TapTapKingfisher.xcframework/ios-arm64/TapTapKingfisher.framework/PrivacyInfo.xcprivacy"]
    }
    profile.vendored_frameworks = [
        "iOS/Frameworks/TapTapProfileSDK.xcframework",
        "iOS/Frameworks/TapTapKingfisher.xcframework"
    ]
    profile.resources = 'iOS/Frameworks/TapTapProfileResource.bundle'
    profile.dependency 'TapTapSDK/Login'
  end

  # ==================== RelationLite 模块 ====================
  s.subspec 'RelationLite' do |relationlite|
    relationlite.vendored_frameworks = [
      "iOS/Frameworks/TapTapRelationLiteSDK.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    relationlite.resources = 'iOS/Frameworks/TapTapRelationLiteResource.bundle'
    relationlite.dependency 'TapTapSDK/Profile'
  end

  # ==================== Relation 模块 ====================
  s.subspec 'Relation' do |relation|
    relation.resource_bundles = {
      'TapTapRelationSDKPrivacy' => ["iOS/Frameworks/TapTapRelationSDK.xcframework/ios-arm64/TapTapRelationSDK.framework/PrivacyInfo.xcprivacy"]
    }
    relation.vendored_frameworks = [
      "iOS/Frameworks/TapTapRelationSDK.xcframework",
      "iOS/Frameworks/bifrost_sdk.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    relation.resources = 'iOS/Frameworks/TapTapRelationResource.bundle'
    relation.dependency 'TapTapSDK/Profile'
    # 禁用 auto-linking 以避免 Xcode 15+ 误链接 CoreAudioTypes（header-only framework）
    relation.pod_target_xcconfig = {
      'CLANG_MODULES_AUTOLINK' => 'NO'
    }
  end

  # ==================== Leaderboard 模块 ====================
  s.subspec 'Leaderboard' do |leaderboard|
    leaderboard.vendored_frameworks = [
      "iOS/Frameworks/TapTapLeaderboardSDK.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    leaderboard.resources = 'iOS/Frameworks/TapTapLeaderboardResource.bundle'
    leaderboard.dependency 'TapTapSDK/Profile'
  end

  # ==================== Rep 模块 ====================
  s.subspec 'Rep' do |rep|
    rep.vendored_frameworks = [
      "iOS/Frameworks/TapTapRepSDK.xcframework",
      "iOS/Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    rep.dependency 'TapTapSDK/Core'
  end

# ==================== Battle 模块 ====================
  s.subspec 'Battle' do |battle|
    battle.vendored_frameworks = [
      "iOS/Frameworks/onlinebattle_sdk.xcframework",
      "iOS/Frameworks/TapOnlineBattleSDK.xcframework"
    ]
    battle.dependency 'TapTapSDK/Login'
    battle.xcconfig = {
          'OTHER_LDFLAGS' => '-lz.1'
        }
        # 禁用 auto-linking 以避免 Xcode 15+ 误链接 CoreAudioTypes（header-only framework）
        battle.pod_target_xcconfig = {
          'CLANG_MODULES_AUTOLINK' => 'NO'
        }
  end

end
