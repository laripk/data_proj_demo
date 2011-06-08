class QueriesController < ApplicationController

  # lists all the saved queries
  def index
    @title = "All Queries"
    @queries = Query.paginate(:page => params[:page])
  end

  # displays an individual saved query
  def show
    @title = "Show Query"
    @query = Query.find(params[:id])
    @filters = @query.selected_filters
    
    params[:results_mode] ||= 'preview'
    results = VwcAllCombined.search(@filters).relation.
                  select("DISTINCT #{@query.selected_fields.join(', ')}")
    @count = VwcAllCombined.count_me(results.to_sql).first.first
    case params[:results_mode]
      when 'full-html'
        @results = results.paginate :page => params[:page], 
                                    :total_entries => @count, 
                                    :per_page => 50
      when 'full-csv'
        @results = results
        respond_to do |format|
          format.csv
        end
      else # includes 'preview' - ie, default to preview mode
        @results = results.limit(12)
    end
    
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
    clean_checkboxes
    @query = Query.new(params[:query])
    # puts "\n", params[:filter].inspect
    @query.selected_filters = @filter = params[:filter]
    
    if @query.save
      redirect_to @query # show query
    else
      @title = "New Query"
      # @field_info = VwcAllCombined.field_info
      # @filter = @query.selected_filters
      render :new
    end
  end

  # display form for editing an existing query
  def edit
    @title = "Edit Query"
    @query = Query.find(params[:id])
    @filter = @query.selected_filters
  end

  # save modifications to a query
  def update
    clean_checkboxes
    @query = Query.find(params[:id])
    @query.selected_filters = @filter = params[:filter]
    if @query.update_attributes(params[:query])
      flash[:success] = 'Query updated.'
      redirect_to @query
    else
      @title = "Edit Query"
      # @filter = @query.selected_filters
      render :edit
    end
  end

  def destroy
    # delete a query (perhaps only deactivate it)
  end

  private
  
    # clean up the checkbox array fields (because if I didn't put the
    # hidden blank entries in, the fields would disappear from params
    # if all the checkboxes were unselected)
    def clean_checkboxes
      params[:query][:selected_fields].delete("")
      params[:filter][:country_code_in].delete("")
      params[:filter][:region_code_in].delete("")
    end

end
