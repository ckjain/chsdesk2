class BillHeadersController < ApplicationController
  # GET /bill_headers
  # GET /bill_headers.json
  def index
    @bill_headers = BillHeader.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @bill_headers }
    end
  end

  # GET /bill_headers/1
  # GET /bill_headers/1.json
  def show
    @bill_header = BillHeader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bill_header }
    end
  end

  # GET /bill_headers/new
  # GET /bill_headers/new.json
  def new
    @bill_header = BillHeader.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @bill_header }
    end
  end

  # GET /bill_headers/1/edit
  def edit
    @bill_header = BillHeader.find(params[:id])
  end

  # POST /bill_headers
  # POST /bill_headers.json
  def create
    @bill_header = BillHeader.new(params[:bill_header])

    respond_to do |format|
      if @bill_header.save
        format.html { redirect_to @bill_header, :notice => 'Bill header was successfully created.' }
        format.json { render :json => @bill_header, :status => :created, :location => @bill_header }
      else
        format.html { render :action => "new" }
        format.json { render :json => @bill_header.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bill_headers/1
  # PUT /bill_headers/1.json
  def update
    @bill_header = BillHeader.find(params[:id])

    respond_to do |format|
      if @bill_header.update_attributes(params[:bill_header])
        format.html { redirect_to @bill_header, :notice => 'Bill header was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bill_header.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_headers/1
  # DELETE /bill_headers/1.json
  def destroy
    @bill_header = BillHeader.find(params[:id])
    @bill_header.destroy

    respond_to do |format|
      format.html { redirect_to bill_headers_url }
      format.json { head :ok }
    end
  end
end
