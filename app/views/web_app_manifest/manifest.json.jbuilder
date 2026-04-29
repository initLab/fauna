# frozen_string_literal: true

json.name 'init Lab Fauna'
json.short_name 'Fauna'
json.start_url '/'
json.display 'standalone'
json.background_color '#2196f3'
json.theme_color '#2196f3'
json.icons do
  json.array! @icon_sizes, as: :icons do |size|
    json.src image_url format('favicon-%<size>d.png', size: size)
    json.sizes format('%<size>dx%<size>d', size: size)
    json.type 'image/png'
  end
end
