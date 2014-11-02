Pod::Spec.new do |s|
  s.name         = "AJPaperFlow"
  s.version      = "0.0.2"
  s.summary      = "A Facebook Paper inspired navigation flow"

  s.description  = <<-DESC
                   AJPaperFlow is a [Facebook Paper](http://facebook.com/paper) inspired navigation flow.
                   DESC

  s.homepage     = "https://github.com/mekanics/AJPaperFlow"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Alexandre Joly" => "alexandre.joly@mekanics.ch" }
  s.social_media_url   = "http://twitter.com/jolyAlexandre"

  s.platform     = :ios, "7.1"

  s.source       = { :git => "https://github.com/mekanics/AJPaperFlow.git", :tag => "0.0.2" }

  s.source_files  = "AJPaperFlow/AJPaperFlow", "AJPaperFlow/AJPaperFlow/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "pop", "~> 1.0"

end
