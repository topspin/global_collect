task :default => :spec
task :test    => :spec
 
desc "Build a gem"
task :gem => [ :gemspec, :build ]
 
desc "Run specs"
task :spec do
  exec "spec spec/global_collect_spec.rb"
end



begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "global_collect"
    gemspec.summary = "A Ruby client to the Global Collect API"
    gemspec.description = <<END
Gives minimally intrusive access to Global Collect's payment processing API. 
Currently implements a very small segment of the full API but is built with 
extensibility in mind.
END
    gemspec.email = "timon.karnezos@gmail.com"
    gemspec.homepage = "http://github.com/timonk/global_collect"
    gemspec.authors = ["Timon Karnezos"]
    gemspec.version = "0.1.2"
    gemspec.add_dependency('httparty', '>= 0.5.2')
    gemspec.add_dependency('builder', '>= 2.0')
    
    gemspec.add_development_dependency('fakeweb', '>= 1.2.8')
  end
rescue LoadError
  warn "Jeweler not available. Install it with:"
  warn "gem install jeweler"
end