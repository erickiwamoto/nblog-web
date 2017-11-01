
After do |scenario|
  filename = scenario.name.tr(' ', '_')

  target = "results/shots/#{filename.downcase!}.png"

  page.save_screenshot(target)
  embed(target, 'image/png', 'Clique aqui')
end
