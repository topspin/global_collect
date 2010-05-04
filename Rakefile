task :default => :spec
task :test    => :spec
 
desc "Build a gem"
task :gem => [ :gemspec, :build ]
 
desc "Run specs"
task :spec do
  exec "spec spec/"
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
    gemspec.version = "0.1.5"
    gemspec.add_dependency('httparty', '>= 0.5.2')
    gemspec.add_dependency('builder', '>= 2.0')
    
    gemspec.add_development_dependency('fakeweb', '>= 1.2.8')
  end
rescue LoadError
  warn "Jeweler not available. Install it with:"
  warn "gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rprince #{version}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end