class PositionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update]
  around_filter :catch_not_found, :only => [:edit, :create, :update]
  
  def new
     @position = Position.new

     respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @position }
     end
   end

   # GET /positions/1/edit
   def edit
     @profile = current_user.profile
     @position = @profile.positions.find(params[:id])
   end

   # POST /positions
   # POST /positions.xml
   def create
     @profile = current_user.profile
     @position = @profile.positions.build(params[:position])

     respond_to do |format|
       if @position.save
         format.html { redirect_to(@profile, :notice => 'Position was successfully created.') }
         format.xml  { render :xml => @profile, :status => :created, :location => @profile }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
       end
     end
   end

   # PUT /positions/1
   # PUT /positions/1.xml
   def update
     @profile = current_user.profile
     @position = @profile.positions.find(params[:id])

     respond_to do |format|
       if @position.update_attributes(params[:position])
         format.html { redirect_to(@profile, :notice => 'Position was successfully updated.') }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
       end
     end
   end
   
   def destroy
     @profile = current_user.profile
     @position = @profile.positions.find(params[:id])
     @position.destroy

     respond_to do |format|
       format.html { redirect_to(@profile) }
       format.xml  { head :ok }
     end
   end
   
end
