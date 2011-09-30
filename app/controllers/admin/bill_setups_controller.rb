class BillSetupsController < ApplicationController
  # GET /bill_setups
  # GET /bill_setups.json
  def index
    @bill_setups = BillSetup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @bill_setups }
    end
  end

  # GET /bill_setups/1
  # GET /bill_setups/1.json
  def show
    @bill_setup = BillSetup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bill_setup }
    end
  end

  # GET /bill_setups/new
  # GET /bill_setups/new.json
  def new
    @bill_setup = BillSetup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @bill_setup }
    end
  end

  # GET /bill_setups/1/edit
  def edit
    @bill_setup = BillSetup.find(params[:id])
  end

  # POST /bill_setups
  # POST /bill_setups.json
  def create
    @bill_setup = BillSetup.new(params[:bill_setup])

    respond_to do |format|
      if @bill_setup.save
        format.html { redirect_to @bill_setup, :notice => 'Bill setup was successfully created.' }
        format.json { render :json => @bill_setup, :status => :created, :location => @bill_setup }
      else
        format.html { render :action => "new" }
        format.json { render :json => @bill_setup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bill_setups/1
  # PUT /bill_setups/1.json
  def update
    @bill_setup = BillSetup.find(params[:id])

    respond_to do |format|
      if @bill_setup.update_attributes(params[:bill_setup])
        format.html { redirect_to @bill_setup, :notice => 'Bill setup was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bill_setup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_setups/1
  # DELETE /bill_setups/1.json
  def destroy
    @bill_setup = BillSetup.find(params[:id])
    @bill_setup.destroy

    respond_to do |format|
      format.html { redirect_to bill_setups_url }
      format.json { head :ok }
    end
  end
end
