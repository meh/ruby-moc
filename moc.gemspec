Kernel.load 'lib/moc/version.rb'

Gem::Specification.new {|s|
	s.name         = 'moc'
	s.version      = Moc.version
	s.author       = 'meh.'
	s.email        = 'meh@paranoici.org'
	s.homepage     = 'http://github.com/meh/ruby-moc'
	s.platform     = Gem::Platform::RUBY
	s.summary      = 'moc controller library.'

	s.files         = `git ls-files`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ['lib']
}
