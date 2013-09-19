#!/usr/bin/env ruby

class ChangelogUtils

	def self.getProjectName
		projectFiles = Dir["*.xcodeproj"]
		if (projectFiles.size()>0)
			return projectFiles[0].scan(/[^.]*/)[0]
		else 
			return nil
		end
	end
  
	def self.isXcodeDirectory  
		projectName = ChangelogUtils.getProjectName
		return projectName != nil
	end

	def self.plistFile
		projectName = ChangelogUtils.getProjectName
	   plistFile = Dir["#{Dir.pwd}/*/#{projectName}-Info.plist"]
  		if (plistFile.size() > 0)
   	   return plistFile[0]
	  	else 
   	   return nil
	  	end
	end

	def self.showVersion
		`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" #{ChangelogUtils.plistFile}`.strip
	end
	
	def self.printCurrentChange
		" * #{ChangelogUtils.getLastMessageFromGit.strip} (#{ChangelogUtils.getPullRequestHash.strip})"
	end
	
	def self.goBack
		`git checkout HEAD^ >/dev/null 2>/dev/null`
	end
	
	def self.goForward
		`git checkout develop  >/dev/null 2>/dev/null`
	end

	def self.getLastMessageFromGit
		`git log -1 --format="%b"`
	end

	def self.isPullRequestMerge
		`git log -1 --format="%s" | cut -c -18`.strip == "Merge pull request"
	end

	def self.getPullRequestHash
		`git log -1 --format="%s" | cut -f 4 -d ' '`
	end
end
