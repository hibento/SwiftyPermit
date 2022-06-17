Pod::Spec.new do |spec|

  spec.name         = "SwiftyPermit"
  spec.version      = "0.1.7"
  spec.summary      = "Manages permissions (e.g. camera, location etc.)"
  spec.description =  <<-DESC
    Manages permissions (e.g. camera, location etc.) on iOS-Devices with ease
    and a common interface for different permissions.
                     DESC
  spec.homepage = "https://www.hibento.de"
  spec.license = { :type => 'Copyright' }
  spec.authors = { 'Christian Steffens' => 'cs@hibento.de' }
  spec.platform = :ios, "14.0"
  spec.swift_version = "5"
  spec.source = {
    :git => 'https://github.com/hibento/SwiftyPermit.git',
    :tag => spec.version.to_s
  }

  spec.source_files =
    "Package/Sources/SwiftyPermit/**/*.{h,m,swift,strings}"
  spec.pod_target_xcconfig = {
    'PRODUCT_BUNDLE_IDENTIFIER': 'de.hibento.SwiftyPermit'
  }

end
