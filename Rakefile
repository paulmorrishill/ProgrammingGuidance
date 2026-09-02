# rake check   builds the site and runs every gate the CI runs.
# rake serve   local preview at http://localhost:4000

# The checks run against a build with no path prefix, so internal links resolve
# from the root of _site exactly as they do on the published site.
DEV_CONFIG = "_config.yml,_config.dev.yml".freeze

task default: :check

desc "Build the site for checking"
task :build do
  rm_rf "_site"
  sh "bundle exec jekyll build --config #{DEV_CONFIG}"
end

desc "Check every internal link and anchor"
task links: :build do
  sh "bundle exec ruby script/check-links.rb"
end

desc "Check the content rules the style guide sets"
task :content do
  sh "bundle exec ruby script/check-content.rb"
end

desc "Run every gate"
task check: %i[content links] do
  puts "All checks passed."
end

desc "Serve locally with live reload"
task :serve do
  sh "bundle exec jekyll serve --livereload --config #{DEV_CONFIG}"
end
