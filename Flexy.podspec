Pod::Spec.new do |s|
	s.name			= "Flexy"
	s.version		= "0.1.0"
	s.summary		= "Framework for constructing flexible datasource for UICollectionView and UITableView"
	s.description		= <<-DESC
				Flexy is a framework that provides convenient API for UICollectionView and UITableView datasource, allow to use multiple types cell very easy.
				DESC
	s.homepage		= "https://github.com/AnisovAleksey/Flexy"
	s.license		= { :type => "MIT", :file => "LICENSE.txt" }
	s.author		= "Anisov Aleksey"
	s.source		= { :git => "https://github.com/AnisovAleksey/Flexy.git", :tag => s.version.to_s }
	
	s.source_files 		= "Flexy/Source/**/*.swift"
	s.ios.deployment_target	= "8.0"
	s.requires_arc		= true
end
