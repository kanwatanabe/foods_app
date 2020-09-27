class ShopsController < ApplicationController
  def index
    require 'uri'
    require 'net/http'
    require 'json'
    require 'cgi'
    # require 'active_support'
    # require 'active_support/core_ext'

    api_key = ENV['GRUNAVI_APIKEY']
    url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid='
    url << api_key << '&hit_per_page=100'
    # url << api_key

    if params[:search]
      word = params[:search]
      # 名前で検索
      url << '&name=' << word
      # url << "&freeword=ラーメン"
    end

    if params[:area]
      area = params[:area]
      # エリアで検索
      url << '&area=' << area
    end

    url = CGI.escape(url)
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    rests = result['rest']

    @rests = Kaminari.paginate_array(rests).page(params[:page]).per(12)

    area_url = 'https://api.gnavi.co.jp/master/PrefSearchAPI/v3/?keyid='
    area_url << api_key << '&lang=ja'
    area_url = CGI.escape(area_url)
    area_uri = URI.parse(area_url)
    area_json = Net::HTTP.get(area_uri)
    area_result = JSON.parse(area_json)
    @area_rests = area_result['pref']
  end
end
