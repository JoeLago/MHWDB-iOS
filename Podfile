platform :ios, '13.0'

target 'MHWDB' do
    use_frameworks!
    
    pod 'GRDB.swift'
    pod 'SVGKit', :git => 'https://github.com/SVGKit/SVGKit.git', :branch => '3.x', :inhibit_warnings => true
    pod 'SwiftLint'
    pod 'SwiftyUserDefaults'
    
    target 'MHWDBTests' do
        inherit! :search_paths
    end
end
