class RsController <InheritedResources::Base
	belongs_to :o
	actions :index, :show
	respond_to :html
	
  def index
    redirect_to @o
  end
	
end