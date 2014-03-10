# To use with thin
#  thin start -p PORT -R config.ru

require './text_from_image.rb'

set :environment, :production
run TextFromImage