json.name 'init Lab Fauna'
json.short_name 'Fauna'
json.start_url '/'
json.display 'standalone'
json.background_color '#2196f3'
json.theme_color '#2196f3'
json.icons do
  json.array! @icon_sizes, as: :icons do |size|
    json.src image_url 'favicon-%d.png' % size
    json.sizes '%dx%d' % [size, size]
    json.type 'image/png'
  end
end
