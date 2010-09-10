#!/usr/bin/env ruby
#
# Harold Leboulanger <harold@leboulanger.org>
#
# Script d'ajout d'un bundle automatique
#
# Exemple d'entrée : http://github.com/vim-scripts/closetag.vim.git
require 'URI'

BUNDLE_DIR = 'bundle'

ARGV.each do |a|
  url = URI.parse(a)

  bundle_name = url.path.split('/')[-1].split('.')[0]
  bundle_path = File.join(BUNDLE_DIR, bundle_name)

  system "git submodule add #{a} #{bundle_path}"
  system "git submodule init"
end
