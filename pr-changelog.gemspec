Gem::Specification.new do |s|
  s.name        = 'pr-changelog'
  s.version     = '0.1.1'
  s.date        = '2013-09-10'
  s.executables << 'chlog'
  s.summary     = "Create a changelog for an iOS app using git history of Pull Requests already merged and xcode version"
  s.description = "With this gem you can generate a changelog using Pull Requests logs on your local branch"
  s.authors     = ["David Cortés"]
  s.email       = 'david@lafosca.cat'
  s.files       = ["lib/pr_changelog_utils.rb"]
  s.homepage    =
	 'https://github.com/davebcn87/pr-changelog'
  s.license       = 'MIT'
  s.add_dependency "commander", "~> 4.1.5"
  s.add_dependency "mechanize"
  s.require_paths = ["lib"]
end
