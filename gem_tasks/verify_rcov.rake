require 'rake'
require 'spec/rake/verify_rcov'

RCov::VerifyTask.new(:verify_rcov => :spec) do |t|
  t.threshold = 99.7 # Make sure you have rcov 0.9 or higher!
  t.index_html = 'coverage/index.html'
end
