class MeetingMembersController < ApplicationController
  # GET /meeting_members
  # GET /meeting_members.json
  def index
    @meeting_members = MeetingMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @meeting_members }
    end
  end

  # GET /meeting_members/1
  # GET /meeting_members/1.json
  def show
    @meeting_member = MeetingMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @meeting_member }
    end
  end

  # GET /meeting_members/new
  # GET /meeting_members/new.json
  def new
    @meeting_member = MeetingMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @meeting_member }
    end
  end

  # GET /meeting_members/1/edit
  def edit
    @meeting_member = MeetingMember.find(params[:id])
  end

  # POST /meeting_members
  # POST /meeting_members.json
  def create
    @meeting_member = MeetingMember.new(params[:meeting_member])

    respond_to do |format|
      if @meeting_member.save
        format.html { redirect_to @meeting_member, :notice => 'Meeting member was successfully created.' }
        format.json { render :json => @meeting_member, :status => :created, :location => @meeting_member }
      else
        format.html { render :action => "new" }
        format.json { render :json => @meeting_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meeting_members/1
  # PUT /meeting_members/1.json
  def update
    @meeting_member = MeetingMember.find(params[:id])

    respond_to do |format|
      if @meeting_member.update_attributes(params[:meeting_member])
        format.html { redirect_to @meeting_member, :notice => 'Meeting member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @meeting_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_members/1
  # DELETE /meeting_members/1.json
  def destroy
    @meeting_member = MeetingMember.find(params[:id])
    @meeting_member.destroy

    respond_to do |format|
      format.html { redirect_to meeting_members_url }
      format.json { head :ok }
    end
  end
end
