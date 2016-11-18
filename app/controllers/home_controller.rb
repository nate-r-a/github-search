class HomeController < ApplicationController
  def home
  end
  
  def search
    base_url = "https://api.github.com/search/repositories?q="
    search_term = params[:q]
    final_url = base_url + search_term
    
    response = RestClient.get(final_url)
    data = JSON.parse(response.body)
    
    @repos = data["items"]
    
    if !@repos.empty?
      render :search
    else
      flash[:alert] = "Sorry, your search did not return any results."
      redirect_to root_path
    end
    
    
  end
end
