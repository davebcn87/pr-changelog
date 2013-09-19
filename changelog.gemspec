Gem::Specification.new do |s|
  s.name        = 'changelog'
  s.version     = '0.1.0'
  s.date        = '2013-09-10'
  s.executables << 'changelog'
  s.summary     = "Create a changelog for an iOS app using git and xcode version"
  s.description = "Use this command to generate a changelog file for the current version"
  s.authors     = ["David Cortés"]
  s.email       = 'david@lafosca.cat'
  s.files       = ["lib/changelog_utils.rb"]
  s.homepage    =
    'http://rubygems.org/gems/changelog'
  s.license       = 'MIT'
end
