#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_ringer_status'
  s.version          = '0.1'
  s.summary          = 'getphone ringer status and play Ringtone'
  s.description      = <<-DESC
getphone ringer status
                       DESC
  s.homepage         = 'http://www.github.com/viztushar/flutter_ringer_status'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tushar Parmar' => 'viztushar@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

