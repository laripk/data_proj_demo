class QueriesController < ApplicationController
  def index
    # lists all the saved queries
    @title = "All Queries"
  end

  # displays an individual saved query
  def show
    @title = "Show Query"
    @query = Query.find(params[:id])
    @filters = @query.selected_filters
    
    params[:results_mode] ||= 'preview'
    
    
    # include results??
    # no - ask the user; need to ask browse(html) or download(csv) too
    
    # @search = VwcAllCombined.search(params[:search])  
    # @results = @search.relation.select("distinct #{@query.selected_fields.join(', ')}")  

    # @search = VwcAllCombined.search()
    # @query.vwc_all_combined = MetaSearch::Searches::VwcAllCombined.new(VwcAllCombined)
    # @results = @search.select("distinct #{@query.selected_fields.join(', ')}").limit(10)
  end

  # display form for creating a new query
  def new
    @title = "New Query"
    @query = Query.new
    @query.selected_fields = ['region_code']
    # @field_info = VwcAllCombined.field_info
    @filter = {}
  end

  # creates a new query
  def create
    # clean up the checkbox array fields (because if I didn't put the hidden blank entries in, the fields would disappear from params if all the checkboxes were unselected)
    params[:query][:selected_fields].delete("")
    params[:filter][:country_code_in].delete("")
    params[:filter][:region_code_in].delete("")
    
    @query = Query.new(params[:query])
    # puts "\n", params[:filter].inspect
    @filter = params[:filter]
    @query.selected_filters = @filter
    
    if @query.save
      redirect_to @query # show query
    else
      @title = "New Query"
      @field_info = VwcAllCombined.field_info
      @filter = @query.selected_filters
      render :new
    end
  end

  # display form for editing an existing query
  def edit
    @title = "Edit Query"
    @query = Query.find(params[:id])
    @filters = @query.selected_filters
    puts "\n", @query.selected_fields.inspect
    puts "\n", @query.selected_filters.inspect
    puts "\n", @query.selected_filters.inspect
  end

  def update
    # save modifications to a query
  end

  def destroy
    # delete a query (perhaps only deactivate it)
  end


end
