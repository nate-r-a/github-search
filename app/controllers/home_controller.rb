class HomeController < ApplicationController
  def home
  end
  
  def search
    base_url = "https://api.github.com/search/repositories?q="
    
    search_term = params[:q]
    
    language_query = "+language:"
    language_term = params[:language]
    if language_term == ""
      language_query = ""
    else
      language_query += language_term
    end
    
    sort = ""
    if params[:sort] == "true"
      sort = "&sort=stars&order=desc"
    end
    
    
    @page_number = params[:page]
    if @page_number == nil
      page_term = ""
    else
    page_term = "&page=" + @page_number
    end
    
    pagination_term = "&per_page=25"
    
    
    
    
    
    final_url = base_url + search_term + language_query + pagination_term + page_term + sort
    
    response = RestClient.get(final_url)
    @repos = JSON.parse(response.body)
    
    if @repos
      render :search
    else
      flash[:alert] = "Sorry, your search did not return any results."
      redirect_to root_path
    end
    
    
  end
end
