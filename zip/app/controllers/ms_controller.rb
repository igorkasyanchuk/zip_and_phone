class MsController < InheritedResources::Base
  belongs_to :r
  actions :index, :show
  respond_to :html
  
	def index
	  redirect_to [@r.o, @r]
	end
  
end
