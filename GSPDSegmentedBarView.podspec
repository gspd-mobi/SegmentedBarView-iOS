Pod::Spec.new do |s|
  s.name             = "GSPDSegmentedBarView"
  s.version          = "1.0.0"
  s.summary          = "Custom UI control for iOS which is showing data as a segments and a value inside them."

  s.description      = <<-DESC
                       Customizable UI control for iOS which is showing data as a segments and a value inside them.
                       DESC

  s.homepage         = "https://github.com/gspd-mobi/SegmentedBarView-iOS"
  s.screenshots     = "http://i.imgur.com/iEq1unf.png", "http://i.imgur.com/nUbng0l.png"
  s.license          = 'MIT'
  s.author           = { "Alexander Kiyaykin" => "alexander.kiyaykin@gspd.mobi" }
  s.source           = { :git => "https://github.com/gspd-mobi/SegmentedBarView-iOS.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GSPDSegmentedBarView' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit', 'Foundation'
end
