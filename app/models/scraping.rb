class Scraping
  def self.artspace
    agent = Mechanize.new
    page = agent.get('https://artscape.jp/exhibition/schedule/exhi_schedule_result.php?area=8')
    html = Nokogiri::HTML(page.body)
    elements = html.search('.headH3D')
    names = html.search('.infoList a')
    elements.each_with_index do |ele, i|
      exhibition = Exhibition.new
      exhibition.name = names[i].inner_text.strip
      exhibition.title = ele.inner_text.strip
      exhibition.save
    end
  end
end