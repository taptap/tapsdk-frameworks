Pod::Spec.new do |s|
  s.name             = 'TapTapSDK'
  s.version          = '4.10.3-beta.1'
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

  s.homepage         = 'https://github.com/taptap/TapSDK4-frameworks'
  s.license          = { :type => "MIT" }
  s.author           = 'TapTap'
  s.source           = { :git => 'https://github.com/taptap/TapSDK4-frameworks.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.static_framework = true

  # 默认不安装任何模块，用户需要显式指定需要的 subspec
  s.default_subspecs = 'Core'

  # ==================== Gid 模块 ====================
  s.subspec 'Gid' do |gid|
    gid.vendored_frameworks = [
      "Frameworks/TapTapBasicToolsSDK.xcframework",
      "Frameworks/THEMISLite.xcframework",
      "Frameworks/TapTapNetworkSDK.xcframework",
      "Frameworks/TapTapGidSDK.xcframework",
      "Frameworks/tapsdkcorecpp.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]

    gid.frameworks = ['UIKit', 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'GameController']
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
    core.vendored_frameworks = "Frameworks/TapTapCoreSDK.xcframework"
    core.dependency 'TapTapSDK/Gid'

    core.frameworks = ['UIKit', 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'GameController']
    core.library = 'c++'
  end

  # ==================== Login 模块 ====================
  s.subspec 'Login' do |login|
    login.vendored_frameworks = [
      "Frameworks/TapTapLoginSDK.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    login.resources = 'Frameworks/TapTapLoginResource.bundle'
    login.dependency 'TapTapSDK/Core'

    login.frameworks = ['UIKit', 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'GameController']
    login.library = 'c++'
  end

  # ==================== Achievement 模块 ====================
  s.subspec 'Achievement' do |achievement|
    achievement.vendored_frameworks = [
      "Frameworks/TapTapAchievementSDK.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    achievement.resources = 'Frameworks/TapTapAchievementResource.bundle'
    achievement.dependency 'TapTapSDK/Login'
  end

  # ==================== Moment 模块 ====================
  s.subspec 'Moment' do |moment|
    moment.vendored_frameworks = [
      "Frameworks/TapTapMomentSDK.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    moment.resources = 'Frameworks/TapTapMomentResource.bundle'
    moment.dependency 'TapTapSDK/Login'
  end

  # ==================== Compliance 模块 ====================
  s.subspec 'Compliance' do |compliance|
    compliance.vendored_frameworks = [
      "Frameworks/TapTapComplianceSDK.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    compliance.resources = 'Frameworks/TapTapComplianceResource.bundle'
    compliance.dependency 'TapTapSDK/Login'
  end

  # ==================== CloudSave 模块 ====================
  s.subspec 'CloudSave' do |cloudsave|
    cloudsave.vendored_frameworks = [
      "Frameworks/TapTapCloudSaveSDK.xcframework",
      "Frameworks/cloudsave_sdk.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
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
    share.vendored_frameworks = "Frameworks/TapTapShareSDK.xcframework"
    share.dependency 'TapTapSDK/Core'
  end

  # ==================== Profile 模块 ====================
  s.subspec 'Profile' do |profile|
    profile.vendored_frameworks = [
        "Frameworks/TapTapProfileSDK.xcframework",
        "Frameworks/TapTapKingfisher.xcframework"
    ]
    profile.resources = 'Frameworks/TapTapProfileResource.bundle'
    profile.dependency 'TapTapSDK/Login'
  end

  # ==================== RelationLite 模块 ====================
  s.subspec 'RelationLite' do |relationlite|
    relationlite.vendored_frameworks = [
      "Frameworks/TapTapRelationLiteSDK.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    relationlite.resources = 'Frameworks/TapTapRelationLiteResource.bundle'
    relationlite.dependency 'TapTapSDK/Profile'
  end

  # ==================== Relation 模块 ====================
  s.subspec 'Relation' do |relation|
    relation.vendored_frameworks = [
      "Frameworks/TapTapRelationSDK.xcframework",
      "Frameworks/bifrost_sdk.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    relation.resources = 'Frameworks/TapTapRelationResource.bundle'
    relation.dependency 'TapTapSDK/Profile'
    # 禁用 auto-linking 以避免 Xcode 15+ 误链接 CoreAudioTypes（header-only framework）
    relation.pod_target_xcconfig = {
      'CLANG_MODULES_AUTOLINK' => 'NO'
    }
  end

  # ==================== Leaderboard 模块 ====================
  s.subspec 'Leaderboard' do |leaderboard|
    leaderboard.vendored_frameworks = [
      "Frameworks/TapTapLeaderboardSDK.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    leaderboard.resources = 'Frameworks/TapTapLeaderboardResource.bundle'
    leaderboard.dependency 'TapTapSDK/Profile'
  end

  # ==================== Rep 模块 ====================
  s.subspec 'Rep' do |rep|
    rep.vendored_frameworks = [
      "Frameworks/TapTapRepSDK.xcframework",
      "Frameworks/TapTapSDKBridgeCore.xcframework"
    ]
    rep.dependency 'TapTapSDK/Core'
  end

# ==================== Battle 模块 ====================
  s.subspec 'Battle' do |battle|
    battle.vendored_frameworks = [
      "Frameworks/onlinebattle_sdk.xcframework",
      "Frameworks/TapTapBattleSDK.xcframework"
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
