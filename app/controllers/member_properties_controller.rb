class MemberPropertiesController < ApplicationController
  # GET /member_properties
  # GET /member_properties.json
  def index
    @member_properties = MemberProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @member_properties }
    end
  end

  # GET /member_properties/1
  # GET /member_properties/1.json
  def show
    @member_property = MemberProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @member_property }
    end
  end

  # GET /member_properties/new
  # GET /member_properties/new.json
  def new
    @member_property = MemberProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @member_property }
    end
  end

  # GET /member_properties/1/edit
  def edit
    @member_property = MemberProperty.find(params[:id])
  end

  # POST /member_properties
  # POST /member_properties.json
  def create
    @member_property = MemberProperty.new(params[:member_property])

    respond_to do |format|
      if @member_property.save
        format.html { redirect_to @member_property, :notice => 'Member property was successfully created.' }
        format.json { render :json => @member_property, :status => :created, :location => @member_property }
      else
        format.html { render :action => "new" }
        format.json { render :json => @member_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /member_properties/1
  # PUT /member_properties/1.json
  def update
    @member_property = MemberProperty.find(params[:id])

    respond_to do |format|
      if @member_property.update_attributes(params[:member_property])
        format.html { redirect_to @member_property, :notice => 'Member property was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @member_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /member_properties/1
  # DELETE /member_properties/1.json
  def destroy
    @member_property = MemberProperty.find(params[:id])
    @member_property.destroy

    respond_to do |format|
      format.html { redirect_to member_properties_url }
      format.json { head :ok }
    end
  end
end
