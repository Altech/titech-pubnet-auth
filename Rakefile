# -*- coding: utf-8 -*-
require 'rdoc/task'
require "bundler/gem_tasks"

BASE_DIR = File.dirname(__FILE__)

require 'yard'
require 'yard/rake/yardoc_task'
YARD::Rake::YardocTask.new do |t|
  t.files   = ['README.md','lib/**/*.rb']
end
