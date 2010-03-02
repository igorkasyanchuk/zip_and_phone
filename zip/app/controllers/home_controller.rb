class HomeController < ApplicationController
  def index
  end

  def search
    if (params['q'] || '').length > 3
      @results = M.search_for(params['q']).paginate :per_page => 20, :page => params['page']
    else
      @results = [].paginate
    end
  end

end
