class ShopsController < ApplicationController

  def index

    require 'uri'
    require 'net/http'
    require 'json'
    # require 'active_support'
    # require 'active_support/core_ext'

    api_key = ENV['GRUNAVI_APIKEY']
    url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid='
    url << api_key << "&hit_per_page=100"
    # url << api_key

    if params[:search]
      word = params[:search]
      url << "&name=" << word #名前で検索
      # url << "&freeword=ラーメン"
    end

    if params[:area]
      area = params[:area]
      url << "&area=" << area #エリアで検索
    end
    
    url=URI.encode(url)
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    rests=result["rest"]
    

    @rests = Kaminari.paginate_array(rests).page(params[:page]).per(12)

    area_url = 'https://api.gnavi.co.jp/master/PrefSearchAPI/v3/?keyid='
    area_url << api_key << "&lang=ja"
    area_url=URI.encode(area_url)
    area_uri = URI.parse(area_url)
    area_json = Net::HTTP.get(area_uri)
    area_result = JSON.parse(area_json)
    @area_rests=area_result["pref"]

  end
    
end



