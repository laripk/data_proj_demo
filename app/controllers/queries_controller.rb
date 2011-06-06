class QueriesController < ApplicationController
  def index
    # lists all the saved queries
    @title = "All Queries"
  end

  def show
    # displays an individual saved query
    # include results??
    # no - ask the user; need to ask browse(html) or download(csv) too

    # # so results code actually belongs to allcombinedcontroller#index or how about resultslist#show ?
    # @search = VwcAllCombined.search(params[:search])  
    # @results = @search.relation.select("distinct #{@query.selected_fields.join(', ')}")  
  end

  def new
    # display form for creating a new query
    @title = "New Query"
    # @query = Query.new
    # @query.selected_fields = [:region_code]
    # @search = VwcAllCombined.search()
    @field_info = VwcAllCombined.field_info
    # @query.vwc_all_combined = MetaSearch::Searches::VwcAllCombined.new(VwcAllCombined)
    # @results = @search.select("distinct #{@query.selected_fields.join(', ')}").limit(10)
  end

  def create
    # save a new query
  end

  def edit
    # display form for editing an existing query
  end

  def update
    # save modifications to a query
  end

  def destroy
    # delete a query (perhaps only deactivate it)
  end

end
