namespace :gemspec do
  desc 'Refresh rboss-gem.gemspec to include ALL files'
  task :refresh => 'manifest:refresh' do
    File.open('rboss-gem.gemspec', 'w') {|io| io.write($hoe.spec.to_ruby)}
  end
end