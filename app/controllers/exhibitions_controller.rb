class ExhibitionsController < ApplicationController
  def index
    Scraping.artspace
    @exhibitions = Exhibition.all
    @exhibition_name = Exhibition.select("title").distinct  # 重複なくnameカラムのデータを取り出す
  end

  def search
    @place_1_id = params[:exhibition][:place_1].to_i
    method = "getStations"
    x = params[:exhibition][:lng_1].to_f
    y = params[:exhibition][:lat_1].to_f
    uri = URI('http://express.heartrails.com/api/json')
    uri.query = {
      method: method, x: x, y: y
    }.to_param
    response = Net::HTTP.get(uri)
    @station_1 = JSON.parse(response)['response']['station'][0]['name']
    distance = JSON.parse(response)['response']['station'][0]['distance']
    @walking_1 = ( distance.delete("^0-9").to_i / 80 ).ceil(0)

    @place_2_id = params[:exhibition][:place_2].to_i
    method = "getStations"
    x = params[:exhibition][:lng_2].to_f
    y = params[:exhibition][:lat_2].to_f
    uri = URI('http://express.heartrails.com/api/json')
    uri.query = {
      method: method, x: x, y: y
    }.to_param
    response = Net::HTTP.get(uri)
    @station_2 = JSON.parse(response)['response']['station'][0]['name']
    distance = JSON.parse(response)['response']['station'][0]['distance']
    @walking_2 = ( distance.delete("^0-9").to_i / 80 ).ceil(0)

    @place_3_id = params[:exhibition][:place_3].to_i
    method = "getStations"
    x = params[:exhibition][:lng_3].to_f
    y = params[:exhibition][:lat_3].to_f
    uri = URI('http://express.heartrails.com/api/json')
    uri.query = {
      method: method, x: x, y: y
    }.to_param
    response = Net::HTTP.get(uri)
    @station_3 = JSON.parse(response)['response']['station'][0]['name']
    distance = JSON.parse(response)['response']['station'][0]['distance']
    @walking_3 = ( distance.delete("^0-9").to_i / 80 ).ceil(0)

    src = "品川"
    dst = @station_1
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_s1 = JSON.parse(response)['ways'][0]['min']

    src = "品川"
    dst = @station_2
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_s2 = JSON.parse(response)['ways'][0]['min']

    src = "品川"
    dst = @station_3
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_s3 = JSON.parse(response)['ways'][0]['min']

    src = @station_1
    dst = @station_2
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_12 = JSON.parse(response)['ways'][0]['min']

    src = @station_2
    dst = @station_1
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_21 = JSON.parse(response)['ways'][0]['min']

    src = @station_2
    dst = @station_3
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_23 = JSON.parse(response)['ways'][0]['min']

    src = @station_3
    dst = @station_2
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_32 = JSON.parse(response)['ways'][0]['min']

    src = @station_1
    dst = @station_3
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_13 = JSON.parse(response)['ways'][0]['min']

    src = @station_3
    dst = @station_1
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_31 = JSON.parse(response)['ways'][0]['min']

    src = @station_1
    dst = "東京"
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_1g = JSON.parse(response)['ways'][0]['min']

    src = @station_2
    dst = "東京"
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_2g = JSON.parse(response)['ways'][0]['min']

    src = @station_3
    dst = "東京"
    key = "キー"
    uri = URI('https://api.trip2.jp/ex/tokyo/v1.0/json')
    uri.query = {
      src: src, dst: dst, key: key
    }.to_param
    response = Net::HTTP.get(uri)
    @rail_3g = JSON.parse(response)['ways'][0]['min']

    @pla_1 = @place_1_id
    @pla_2 = @place_2_id
    @pla_3 = @place_3_id
    @rails = @rail_s1 + @rail_12 + @rail_23 + @rail_3g
    if @rails > @rail_s1 + @rail_13 + @rail_32 + @rail_2g
      @rail_s1 = @rail_s1
      @rail_12 = @rail_13
      @rail_23 = @rail_32
      @rail_3g = @rail_2g
      @sta_1 = @station_1
      @sta_2 = @station_3
      @sta_3 = @station_2
      @wal_1 = @walking_1
      @wal_2 = @walking_3
      @wal_3 = @walking_2
      @pla_1 = @place_1_id
      @pla_2 = @place_3_id
      @pla_3 = @place_2_id
    end
    @rails = @rail_s1 + @rail_12 + @rail_23 + @rail_3g
    if @rails > @rail_s2 + @rail_23 + @rail_31 + @rail_1g
      @rail_s1 = @rail_s2
      @rail_12 = @rail_23
      @rail_23 = @rail_31
      @rail_3g = @rail_1g
      @sta_1 = @station_2
      @sta_2 = @station_3
      @sta_3 = @station_1
      @wal_1 = @walking_2
      @wal_2 = @walking_3
      @wal_3 = @walking_1
      @pla_1 = @place_2_id
      @pla_2 = @place_3_id
      @pla_3 = @place_1_id
    end
    @rails = @rail_s1 + @rail_12 + @rail_23 + @rail_3g
    if @rails > @rail_s2 + @rail_21 + @rail_13 + @rail_3g
      @rail_s1 = @rail_s2
      @rail_12 = @rail_21
      @rail_23 = @rail_13
      @rail_3g = @rail_3g
      @sta_1 = @station_2
      @sta_2 = @station_1
      @sta_3 = @station_3
      @wal_1 = @walking_2
      @wal_2 = @walking_1
      @wal_3 = @walking_3
      @pla_1 = @place_2_id
      @pla_2 = @place_1_id
      @pla_3 = @place_3_id
    end
    @rails = @rail_s1 + @rail_12 + @rail_23 + @rail_3g
    if @rails > @rail_s3 + @rail_31 + @rail_12 + @rail_2g
      @rail_s1 = @rail_s3
      @rail_12 = @rail_31
      @rail_23 = @rail_12
      @rail_3g = @rail_2g
      @sta_1 = @station_3
      @sta_2 = @station_1
      @sta_3 = @station_2
      @wal_1 = @walking_3
      @wal_2 = @walking_1
      @wal_3 = @walking_2
      @pla_1 = @place_3_id
      @pla_2 = @place_1_id
      @pla_3 = @place_2_id
    end
    @rails = @rail_s1 + @rail_12 + @rail_23 + @rail_3g
    if @rails > @rail_s3 + @rail_32 + @rail_21 + @rail_1g
      @rail_s1 = @rail_s3
      @rail_12 = @rail_32
      @rail_23 = @rail_21
      @rail_3g = @rail_1g
      @sta_1 = @station_3
      @sta_2 = @station_2
      @sta_3 = @station_1
      @wal_1 = @walking_3
      @wal_2 = @walking_2
      @wal_3 = @walking_1
      @pla_1 = @place_3_id
      @pla_2 = @place_2_id
      @pla_3 = @place_1_id
    end
    @place_1_id = @pla_1
    @place_2_id = @pla_2
    @place_3_id = @pla_3
    @rails = @rail_s1 + @rail_12 + @rail_23 + @rail_3g
    @duration = @walking_1 * 2 + @walking_2 * 2 + @walking_3 * 2 + @rails
  end
end