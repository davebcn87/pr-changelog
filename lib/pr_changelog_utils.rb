#!/usr/bin/env ruby

class ChangelogUtils

	attr_accessor :branch_name

	def self.getProjectName
		projectFiles = Dir["*.xcodeproj"]
		if (projectFiles.size()>0)
			return projectFiles[0].scan(/[^.]*/)[0]
		else 
			return nil
		end
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
	
	def self.printCurrentChange (options)
		if (options.char)
			if (options.char != ChangelogUtils.getLastMessageFromGit.strip[0])
				return 
			end
		end
		if (!options.nobullet)
			" * #{ChangelogUtils.getLastMessageFromGit.strip} (#{ChangelogUtils.getPullRequestHash.strip})"
		else
			"#{ChangelogUtils.getLastMessageFromGit.strip} (#{ChangelogUtils.getPullRequestHash.strip})"
		end
	end
	
	def self.goBack
		@branch_name = self.currentBranchName if !@branch_name
		`git checkout HEAD^ >/dev/null 2>/dev/null`
	end
	
	def self.goForward
		`git checkout #{@branch_name} >/dev/null 2>/dev/null`
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

	def self.currentBranchName
		branch = `git branch --no-color 2> /dev/null`.strip.scan(/\*\s(.*)/)
		return branch[0][0] if branch.size()>0 and branch[0].size()>0
	end 

	def self.isXcodeDirectory  
		projectName = ChangelogUtils.getProjectName
		if projectName == nil
			puts "changelog should be used in a xcode directory" 
			exit
		end
	end

	def self.validateNoChangeInCurrentWorkspace
		if `git status -s`.strip != ""
			puts "you have changes in your repository. Commit or discard changes before using changelog"
			exit
		end
	end

	def self.validateGitExists
		if Dir[".git"].first == nil
			puts "no git project found. changelog should be used in a git project."
			exit
		end
	end

	def self.validateCurrentDirectory
		ChangelogUtils.validateGitExists
		ChangelogUtils.validateNoChangeInCurrentWorkspace
		ChangelogUtils.isXcodeDirectory
	end
end
