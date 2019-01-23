require './lib/jekyll-auth/version'

Gem::Specification.new do |s|

  s.name                  = "nexaas-jekyll-google-auth"
  s.version               = JekyllAuth::VERSION
  s.summary               = "A simple way to use Google OAuth to serve a protected jekyll site"
  s.description           = "A simple way to use Google OAuth to serve a protected jekyll site."
  s.authors               = "Eduardo Hertz"
  s.email                 = "eduardo.hertz@nexaas.com"
  s.homepage              = "https://github.com/myfreecomm/nexaas-jekyll-google-auth"
  s.license               = "MIT"
  s.files                 = ["lib/jekyll-auth.rb", "bin/jekyll-auth", "config.ru", "Rakefile",
                             "lib/jekyll-auth/auth-site.rb", "lib/jekyll-auth/jekyll-site.rb",
                             "lib/jekyll-auth/version.rb", "lib/jekyll-auth/config.rb", ".gitignore"]
  s.executables           = ["jekyll-auth"]

  s.add_dependency("jekyll", "~> 3.8")
  s.add_dependency("sinatra-index", "~> 0.0")
  s.add_dependency("commander", "~> 4.1")
  s.add_dependency("git", "~> 1.2")
  s.add_dependency("dotenv", "~> 2.6")
  s.add_dependency("rake", "~> 10.3")
  s.add_dependency("rack-ssl-enforcer", "~> 0.2")
  s.add_dependency("mail", "~> 2.7")
  s.add_runtime_dependency('safe_yaml', "~> 1.0")
end
