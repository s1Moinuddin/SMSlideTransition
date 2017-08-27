#
# Be sure to run `pod lib lint SMSlideTransition.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SMSlideTransition'
  s.version          = '1.0.0'
  s.summary          = 'A custom UIViewController Modal transition. Slide In/Out transiton'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Custom modal transitoin for UIViewController. It presents your viewController on top of a dim/transparent view. You can specify the height of presented viewController, provide topLeft and topRight corner radius, Slide in/out from top bottom left and right direction. Enable/disable interaction on presented viewController dismissal. You can also control transition duration, alpha of the dim view. All you need to do is initialize SMSlideTransitionDelegate give it your desired parameters and assign it to your presented viewController transitioningDelegate. And you also 'don't need to worry about strong reference cycle' due to custom transition.
                       DESC

  s.homepage         = 'https://github.com/s1Moinuddin/SMSlideTransition'
  s.screenshots     = 'https://cdn.rawgit.com/s1Moinuddin/SMSlideTransition/09fb6842/Screenshots/SMSlideTransition.gif',
'https://cdn.rawgit.com/s1Moinuddin/SMSlideTransition/09fb6842/Screenshots/SMSlideTransitionInteraction.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'S.M.Moinuddin' => 'shuvn.eee@gmail.com' }
  s.source           = { :git => 'https://github.com/s1Moinuddin/SMSlideTransition.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SMSlideTransition/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SMSlideTransition' => ['SMSlideTransition/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
