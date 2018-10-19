platform:ios,'10.0'
use_frameworks!
target 'PMLCommunity' do
pod 'AFNetworking’,'~>3.1.0’
pod 'MBProgressHUD','~>1.1.0’
pod 'MJRefresh’,’~>3.1.12’
pod 'SDWebImage’,’3.8.2’
pod 'Masonry’,’~>1.0.2’
pod 'IQKeyboardManager','~>3.3.7’
pod 'MJExtension','~>3.0.15.1'
pod 'pop','~> 1.0'
pod 'TZImagePickerController','~>3.0.3'
pod 'SnapKit', '~> 4.0.0'
pod 'UICountingLabel', '~> 1.4.1'
pod 'JXCategoryView'
pod 'FMDB', '~> 2.7.5'
#视频播放器
pod 'JPVideoPlayer', '~> 3.1.1'

#图片裁剪
pod 'Gridicons', :podspec => 'https://raw.github.com/Automattic/Gridicons-iOS/develop/Gridicons.podspec'
#富文本编辑器
pod 'WordPress-Aztec-iOS','~>1.0'
pod 'WordPress-Editor-iOS','~>1.0'
#pod 'WordPress-Aztec-iOS', :git => 'https://github.com/wordpress-mobile/WordPress-Aztec-iOS.git', :branch => 'develop'

#指定WordPress-Aztec-iOS库的swift版本
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['WordPress-Aztec-iOS'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end

#友盟统计的依赖库
pod 'UMCCommon'
pod 'UMCSecurityPlugins'
#友盟统计的SDK
pod 'UMCAnalytics'
#友盟分享
pod 'UMCPush'

# 集成微信(精简版0.2M)
pod 'UMCShare/Social/ReducedWeChat'

# 集成QQ/QZone/TIM(精简版0.5M)
pod 'UMCShare/Social/ReducedQQ'

# 集成新浪微博(精简版1M)
pod 'UMCShare/Social/ReducedSina'

# 集成Facebook/Messenger
pod 'UMCShare/Social/Facebook'

# 集成Twitter
pod 'UMCShare/Social/Twitter'

# 集成Kakao
pod 'UMCShare/Social/Kakao'

# 集成Instagram
pod 'UMCShare/Social/Instagram'

# 集成Line
pod 'UMCShare/Social/Line'

end
