# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @q = Micropost.ransack(params[:q])
    @microposts = @q.result(distinct: true).page(params[:page]).per(9)
    # @microposts =Kaminari.paginate_array(Micropost.all).page(params[:page]).per(9)
  end

  def index
    @q = Micropost.ransack(params[:q])
    if params[:tags_name]
      @microposts = @q.result(distinct: true).tagged_with("#{params[:tags_name]}").page(params[:page]).per(9)
    else
      @microposts = @q.result(distinct: true).page(params[:page]).per(9)
    end
    #if params[:tag_name]
      #@microposts = Micropost.tagged_with("#{params[:tag_name]}").page(params[:page]).per(9)
    #end
    @tags = Micropost.tag_counts.group(:id,:name).order('taggings_count DESC').limit(5)
  end
end

