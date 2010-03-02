class PhonesController <InheritedResources::Base
	actions :index, :show
	respond_to :html
	
  def index
    redirect_to root_path
  end
	
end